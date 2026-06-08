SPARQL
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>

SELECT (CONCAT(SUBSTR("                ", 1, STRLEN(?cod) - 2), "- ", STR(?cod), "  ", STR(?lbl), "  ") AS ?gics2018)
FROM <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier ;
		skos:notation ?cod ;
		rdfs:label ?lbl .
	FILTER(LANG(?lbl) = "en")
}
GROUP BY ?cod ?lbl
ORDER BY ?cod
;
