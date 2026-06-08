SPARQL
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>

SELECT (CONCAT(SUBSTR("                ", 1, STRLEN(?cod) - 2), "- ", STR(?cod), "  ", STR(?lbl), "  ") AS ?gics2023)
FROM <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	?x a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
		skos:notation ?cod ;
		rdfs:label ?lbl .
	FILTER(LANG(?lbl) = "en")
}
GROUP BY ?cod ?lbl
ORDER BY ?cod
;
