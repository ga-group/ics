SPARQL
SELECT ?from ?gics ?text ?lang ?desc
FROM <http://data.ga-group.nl/ics/gics/1999/>
FROM <http://data.ga-group.nl/ics/gics/2002/>
FROM <http://data.ga-group.nl/ics/gics/2003/>
FROM <http://data.ga-group.nl/ics/gics/2004/>
FROM <http://data.ga-group.nl/ics/gics/2005/>
FROM <http://data.ga-group.nl/ics/gics/2006/>
FROM <http://data.ga-group.nl/ics/gics/2008/>
FROM <http://data.ga-group.nl/ics/gics/2010/>
FROM <http://data.ga-group.nl/ics/gics/2014/>
FROM <http://data.ga-group.nl/ics/gics/2016/>
FROM <http://data.ga-group.nl/ics/gics/2018/>
FROM <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	?x skos:notation ?gics ;
		tempo:validFrom ?from ;
		rdfs:label ?text .
	OPTIONAL {
	?x skos:definition ?desc
	}
	BIND(LANG(?text) AS ?lang)
}
ORDER BY ?from ?gics
;
