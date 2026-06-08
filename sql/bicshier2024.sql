SPARQL
PREFIX bics: <http://data.ga-group.nl/ics/bics/>

SELECT (CONCAT(SUBSTR("                ", 1, STRLEN(?cod) - 2), "- ", STR(?cod), "  ", STR(?lbl), "  ") AS ?r)
FROM <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	?x a bics:Classifier ;
		skos:notation ?cod ;
		rdfs:label ?lbl .
}
GROUP BY ?cod ?lbl
ORDER BY ?cod
;
