#!/bin/bash
#
# GNU Smalltalk 環境における簡易的なビルドスクリプト（的なもの）
#
# オプションの処理
# -t: SUnit によるテストを実行する
# -b: カレントプロジェクトに .star パッケージを作成し、パッケージ作成の詳細を標準出力に表示
#
TEST_FLAG=FALSE
BUILD_FLAG=FALSE
FLAGS=""

while getopts tb FLAGS; do
  case $FLAGS in
    t)  TEST_FLAG=TRUE
        echo 'Running SUnit'
        ;;
    b)  BUILD_FLAG=TRUE
        echo 'Building Package'
        ;;
  esac
done

IM_name='SayYes'              # 保存するイメージファイルの名前
star_name='HelloWorld'        # 作成するパッケージの名前
load_packages="$star_name"    # ロードするパッケージの名前（スペースで区切れば複数定義可能）

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
gst-load $load_packages -I "$IM_name.im"

#
# テストオプションが有効な場合 SUnit を実行
#
[ $TEST_FLAG = TRUE ] && gst-sunit -p $star_name -I $IM_name.im TestCase *
