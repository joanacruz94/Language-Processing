BEGIN { FS=";"
		graph = "digraph grafo {\n\tsize=\"100,100\";\n";
		printf graph > "graph.gv";
}

{ 	
	for(i = 1; i <= NF; i++) 
	{gsub(/^\s+|\s+$|\s+(?=\s)/,"",$i)}
}

#$4 ~ /d[eo][A-Za-z .íãó]+\ ao?/ 

$4 ~ /(Carta|Requerimento|Certidão)/ {	
					gsub(/(Carta|Requerimento|Certidão)[ a-z]+d(e|o) /,"",$4);
					split($4,autores,/ ao?s? /);
					print $1;
					printf("%s --> %s\n", autores[1], autores[2]);
					autor = "\t\"%s\" -> \"%s\";\n";
					printf autor, autores[1], autores[2] > "graph.gv";
				}

END { printf "}" > "graph.gv";}

