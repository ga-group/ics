SPARQL
SELECT ?from ?trbc ?text ?lang ?desc
FROM <http://data.ga-group.nl/ics/trbc/2008/>
FROM <http://data.ga-group.nl/ics/trbc/2012/>
FROM <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	?x skos:notation ?trbc ;
		tempo:validFrom ?from ;
		rdfs:label ?text .
	BIND(LANG(?text) AS ?lang)
	OPTIONAL {
	?x skos:definition ?desc
	FILTER(LANG(?desc) = ?lang)
	}
}
ORDER BY ?lang ?from ?trbc
;
