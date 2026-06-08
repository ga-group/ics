SPARQL
PREFIX trbc: <http://permid.org/ontology/trbc/>

SELECT (CONCAT(SUBSTR("                ", 1, STRLEN(?cod) - 2), "- ", STR(?cod), "  ", STR(?lbl), "  ") AS ?trbc2012)
FROM <http://data.ga-group.nl/ics/trbc/2012/>
WHERE {
	?x a trbc:BusinessClassification ;
		skos:notation ?cod ;
		rdfs:label ?lbl .
	FILTER(LANG(?lbl) = "en")
}
GROUP BY ?cod ?lbl
ORDER BY ?cod
;
