BEGIN {FS=";"}


{ 
for(i = 1; i <= NF; i++) 
	{gsub(/^\s+|\s+$|\s+(?=\s)/,"",$i)}
}

{
if(length($3)==0)
	{$3 = "NIL"}
}

{t[$3][$2]++}

END{
	for(i in t){
		printf("> %s\n",i)
		for(j in t[i]){
			total += t[i][j]
			printf("\t %4s %6s\n",j, t[i][j])
		}
		printf("         --------------------------\n")
		printf("\t %4s =    %6s\n\n","Total",total)
		total = 0
	}
}

