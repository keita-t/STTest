#!/bin/bash
#
# GNU Smalltalk 環境における簡易的なビルドスクリプト（的なもの）
#
# オプションの処理
# -i [arg]: 作成するイメージファイルの名前を指定する
# -p [arg]: 作成するパッケージの名前を指定する
# -l [arg]: ロードするパッケージを指定する
#           (複数指定する場合は文字列として区切って’arg1 arg2...’で指定出来る）
#
# -t: SUnit によるテストを実行する
# -b: プロジェクト下に .star パッケージを作成し、パッケージ作成の詳細を標準出力に表示
#
IM_name="IM"
star_name="Package"
load_packages=""

TEST_FLAG=FALSE
BUILD_FLAG=FALSE
FLAGS=""

while getopts i:p:l:tb FLAGS; do
  case $FLAGS in
    i)  IM_name=$OPTARG
        ;;
    p)  star_name=$OPTARG
        ;;
    l)  load_packages="$OPTARG"
        ;;
    t)  TEST_FLAG=TRUE
        echo 'Running SUnit'
        ;;
    b)  BUILD_FLAG=TRUE
        echo 'Building Package'
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
rm .package.xml
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
# .star パッケージをプロジェクト下に作成する
#
if [ $BUILD_FLAG = TRUE ]; then
  gst-package -t. .package.xml
  gst-package -t ~/.st "$star_name".star
else
  gst-package -t ~/.st .package.xml 1> /dev/null
fi

#
# デフォルトのイメージファイルからカレントディレクトリに初期化したイメージファイルを作成
#
temp="/tmp/stbuild-$(echo $RANDOM)"
echo "ObjectMemory snapshot: '$IM_name.im'." >> $temp
gst -f $temp
rm $temp

#
# パッケージをイメージファイルにロード
#
gst-load $star_name $load_packages -I $IM_name.im

#
# テストオプションが有効な場合 SUnit を実行
#
[ $TEST_FLAG = TRUE ] && gst-sunit -p $star_name -I $IM_name.im TestCase *
