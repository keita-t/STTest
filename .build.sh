#!/bin/bash
#
# GNU Smalltalk 環境における簡易的なビルドスクリプト（的なもの）
#

IM_name='SayYes'              # 保存するイメージファイルの名前
star_name='HelloWorld'        # 作成するパッケージの名前
load_packages="$star_name"    # ロードするパッケージの名前（スペースで区切れば複数定義可能）

#
# カレントディレクトリ下の .st ソースファイルをもとに .package.xml を生成
#
rm .package.xml
st_sourcefiles=`find . -type f -name '*.st'`   # ソースファイルのリストを作成

echo "<package>" >> .package.xml
echo "<name>$star_name</name>" >> .package.xml
for afile in $st_sourcefiles; do
     echo "<file>${afile#*/}</file>"
     echo "<filein>${afile#*/}</filein>"
done >> .package.xml
echo "</package>" >> .package.xml

#
# カレントディレクトリ下に .star パッケージを作成
#
gst-package -t. .package.xml

#
# ~/.st ディレクトリに作成した .star パッケージをインストール
#
gst-package -t ~/.st "$star_name.star"

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
# 成果物を移動
#
[ ! -d bin ] && mkdir bin
mv -f $star_name.star $IM_name.im bin/
