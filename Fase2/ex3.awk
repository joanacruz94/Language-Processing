BEGIN {FS=";"}

{
for(i = 1; i <= NF; i++)
      {gsub(/^\s+|\s+$|\s+(?=\s)/,"",$i)}
}

{split($5,apelidos,/[^a-zA-ZáÁéÉóÓçÇ]+/)}

length(apelidos)>0{ 
	printf("Número da carta: %d\n",$1);	
	printf("Apelidos: ");
	for(i in apelidos){ 
		if(length(apelidos[i])>0){
			printf("%s, ", apelidos[i])
		}
	}
	print "\n"
}
