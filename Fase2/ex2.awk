BEGIN { FS=";"
        headerTitle="Processamento de Linguagens-TP2";
        bodyTitle="Índice de anos";
        headerFormat= "<html><head><meta charset = 'UTF-8'/><title>%s</title></head><body><center><h1>%s</h1></center><ul>\n";
        refHtml = "<a href=file:///Users/joanacruz/Desktop/%s>%s</a>\n";
        textHtml = "<h3>%s</h3>%s";
        endHtml = "</ul></body></html>";
        printf headerFormat , headerTitle , bodyTitle > "index.html";
}

{ 	
	for(i = 1; i <= NF; i++) 
	{gsub(/^\s+|\s+$|\s+(?=\s)/,"",$i)}
	gsub(/\.[0-9.]+/,"",$2);

	for(i=6; i <=NF; i++)
		str=sprintf("%s %s", str, $i);
	ano[$2][$4] = str;
	str = NULL;
}

END {  	for(i in ano){
			printf headerFormat, headerTitle, i > i".html";
			for(j in ano[i])
				printf textHtml, j, ano[i][j] > i".html";
			printf endHtml > i".html";
			printf refHtml, i".html", i > "index.html";
		}
		print endHtml > "index.html"; 
}


