ECHO "generating a chain of replacements between revisions using ICB code ... ";
SPARQL
DEFINE sql:log-enable 3
INSERT {
	GRAPH ?gx {
	?x dct:isReplacedBy ?y
	}
	GRAPH ?gy {
	?y dct:replaces ?x
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?gx {
	?x skos:notation ?cod .
	}
	FILTER(?gx != <http://data.ga-group.nl/ics/icb/>)
	GRAPH ?gy {
	?y skos:notation ?cod .
	}
	FILTER(?gy != <http://data.ga-group.nl/ics/icb/>)
	FILTER(STR(?x) < STR(?y))
	OPTIONAL {
	?z skos:notation ?cod
	FILTER(STR(?x) < STR(?z))
	FILTER(STR(?z) < STR(?y))
	}
	FILTER(!BOUND(?z))
	FILTER(!ISBLANK(?y))
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;
