#!/bin/sh
#postgresql データベースeuc、ターミナルutf8の場合
DBAPW=$1
DBBPW=$2







#TABLEPW=$3

#データベース構造比較
#echo "\dt" | psql $DBAPW > /tmp/$DBAPW-dt.txt
#echo "\dt" | psql $DBBPW > /tmp/$DBBPW-dt.txt
#diff -u $DBAPW-dt.txt $DBBPW-dt.txt | nkf -w8 > $DBAPW-$DBBPW-diff.txt

#テーブル構造比較


FILEPW=tables.txt                          #diffしたいテーブル名を入れておく
TABLESPW=$(cat ${FILEPW})
for TABLEPW in ${TABLESPW[@]};do
#	echo $temp	


    echo "\d $TABLEPW" | nkf -e | psql $DBAPW | nkf -w8 > /tmp/$DBAPW-$TABLEPW-d.txt
    echo "\d $TABLEPW" | nkf -e | psql $DBBPW | nkf -w8 > /tmp/$DBBPW-$TABLEPW-d.txt

    diff -u $DBAPW-$TABLEPW-d.txt $DBBPW-$TABLEPW-d.txt > $DBAPW-$DBBPW-$TABLEPW-d-diff.txt

done
