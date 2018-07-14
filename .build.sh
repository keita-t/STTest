#!/bin/bash
#
# GNU Smalltalk 環境における簡易的なビルドスクリプト（的なもの）
#

IM_name='SayYes'         # 保存するイメージファイルの名前
star_name='HelloWorld'        # 作成するパッケージの名前
load_package="$star_name"   # ロードするパッケージの名前（スペースで区切れば複数定義可能）

#
# カレントディレクトリ下の .st ソースファイルをもとに package.xml を生成
#
st_sourcefiles=`ls *.st`    # ソースファイルのリストを抽出するコマンド
rm package.xml              # package.xml があるなら削除して定義し直す

echo "<package>" >> package.xml
echo "<name>$star_name</name>" >> package.xml
for afile in $st_sourcefiles; do
     echo "<file>$afile</file>"
     echo "<filein>$afile</filein>"
done >> package.xml
echo "</package>" >> package.xml

#
# カレントディレクトリ下に .star パッケージを作成
#
gst-package -t. package.xml

#
# ~/.st ディレクトリに作成した .star パッケージをインストール
#
gst-package -t ~/.st "$star_name.star"

#
# デフォルトのイメージファイルからカレントディレクトリに初期化したイメージファイルを作成
#
echo "ObjectMemory snapshot: '$IM_name.im'." >> temp
gst -f temp
rm temp

#
# パッケージをイメージにロード
#
gst-load $load_package -I "$IM_name.im"
