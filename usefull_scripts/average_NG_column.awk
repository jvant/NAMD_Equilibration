#! /usr/bin/awk -f 


BEGIN {print "Start!"}

/ENERGY:  / { sum2 += $2; sum3 += $3; sum4 += $4; sum5 += $5; sum6 += $6; sum7 += $7; sum8 += $8; sum9 += $9; sum10 += $10; sum11 += $11; sum12 += $12; sum13 += $13; sum14 += $14; sum15 += $15; sum16 += $16; sum17 += $17; sum18 += $18; sum19 += $19; sum20 += $20; sum21 += $21; n++ } 
/ETITLE:  / && n<1 { print $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21}


END { print  n, sum3/n, sum4/n, sum5/n, sum6/n, sum7/n, sum8/n, sum9/n, sum10/n, sum11/n, sum12/n, sum13/n, sum14/n, sum15/n, sum16/n, sum17/n, sum18/n, sum19/n, sum20/n, sum21/n }

#END { printf "10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\n", sum2/n, sum3/n, sum4/n, sum5/n, sum6/n, sum7/n, sum8/n, sum9/n, sum10/n, sum11/n, sum12/n, sum13/n, sum14/n, sum15/n, sum16/n, sum17/n, sum18/n, sum19/n, sum20/n, sum21/n }
#/ETITLE:  / && n<1 { printf "10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\10%s\n", $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21}
