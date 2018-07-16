#!/bin/bash
#
# GNU Smalltalk 環境における簡易的なビルドスクリプト（的なもの）
# ./src ディレクトリ下の .st ソースファイルを集めてパッケージングする
# ./test ディレクトリ下の .st テストケースファイルを集めて SUnit によるテストを行う
# カレントディレクトリ下に作成したパッケージを適用してイメージファイルを作成する
#
# オプションの処理
#
# [必須]
# -i [arg]: 作成するイメージファイルの名前を指定する
# -p [arg]: 作成するパッケージの名前を指定する
#
# [任意]
# -l [arg]: ロードする追加のパッケージを指定する
#           複数指定する場合は文字列内でスペースで区切って（’arg1 arg2...’）指定出来る
# -t:       SUnit によるテストを実行する
# -b:       カレントディレクトリ下に .star パッケージを作成し、パッケージ作成の詳細を標準出力に表示
# -r [arg]: 文字列で指定した GNU Smalltalk コードをトリガとして gst を実行
#           例えばパッケージ内で Application #run が定義されている場合
#           'Application run'でそのメソッドを起動時に実行する
#
IM_name='IM'
star_name='Package'
load_packages=''
run_state=''

TEST_FLAG=FALSE
BUILD_FLAG=FALSE
RUN_FLAG=FALSE
FLAGS=''

while getopts i:p:l:tbr: FLAGS; do
  case $FLAGS in
    i)  IM_name=$OPTARG
        ;;
    p)  star_name=$OPTARG
        ;;
    l)  load_packages="$OPTARG"
        ;;
    t)  TEST_FLAG=TRUE
        ;;
    b)  BUILD_FLAG=TRUE
        ;;
    r)  RUN_FLAG=TRUE
        run_state=$OPTARG
        ;;
  esac
done

# テストオプションが有効な場合は SUnit を読み込む
[ $TEST_FLAG = TRUE ] && load_packages="$load_packages SUnit"

#
# ./src ディレクトリ下の .st ソースファイルをもとに .package.xml を生成
#
# テストオプションが有効にな場合:
# ./test ディレクトリ下の .st テストケースを .package.xml に含める
#
rm .package.xml 1> /dev/null
st_sourcefiles=`find ./src -type f -name '*.st'`   # ソースファイルのリストを作成

echo "<package>" >> .package.xml
echo "<name>$star_name</name>" >> .package.xml

for afile in $st_sourcefiles; do
     echo "<file>${afile#*/}</file>"
     echo "<filein>${afile#*/}</filein>"
done >> .package.xml

if [ $TEST_FLAG = TRUE ]; then
  st_testfiles=`find ./test -type f -name '*.st'`   # テストケースのリストを作成

  echo "<test>" >> .package.xml
  echo "<sunit>${star_name}Test</sunit>" >> .package.xml

  for afile in $st_testfiles; do
    echo "<file>${afile#*/}</file>"
    echo "<filein>${afile#*/}</filein>"
  done >> .package.xml

  echo "</test>" >> .package.xml
fi

echo "</package>" >> .package.xml

#
# ~/.st ディレクトリに作成した .star パッケージをインストール
#
# パッケージオプションが有効な場合：
# .star パッケージをプロジェクト下に作成する（詳細を標準出力に表示）
#
if [ $BUILD_FLAG = TRUE ]; then
  echo 'Building Package'
  echo '.package.xml at:'
  cat .package.xml;

  gst-package -t. .package.xml
  gst-package -t ~/.st ${star_name}.star
else
  gst-package -t ~/.st .package.xml 1> /dev/null
fi

#
# デフォルトのイメージファイルからカレントディレクトリにパッケージを適用し初期化したイメージファイルを作成
#
temp="/tmp/gstbuild-$(echo $RANDOM)"
for apackage in $load_packages; do
  echo "PackageLoader fileInPackage: '$apackage'." >> $temp
done
echo "PackageLoader fileInPackage: '$star_name'." >> $temp
echo "ObjectMemory snapshot: '${IM_name}.im'." >> $temp
gst -qf $temp
rm $temp

#
# テストオプションが有効な場合 SUnit を実行
#
if [ $TEST_FLAG = TRUE ];then
  echo 'Running SUnit'
  gst-sunit -p $star_name -I ${IM_name}.im TestCase *
fi

#
# ランオプションが有効な場合 gst を実行
#
[ $RUN_FLAG = FALSE ] && exit

echo "Running '$run_state' at ${IM_name}.im"
gst -qI ${IM_name}.im <<- RUN
  $run_state
RUN
