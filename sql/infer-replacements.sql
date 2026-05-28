ECHO "generating a chain of replacements between revisions using GICS code ... ";
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
USING <http://data.ga-group.nl/ics/gics/1999/>
USING <http://data.ga-group.nl/ics/gics/2002/>
USING <http://data.ga-group.nl/ics/gics/2003/>
USING <http://data.ga-group.nl/ics/gics/2004/>
USING <http://data.ga-group.nl/ics/gics/2005/>
USING <http://data.ga-group.nl/ics/gics/2006/>
USING <http://data.ga-group.nl/ics/gics/2008/>
USING <http://data.ga-group.nl/ics/gics/2010/>
USING <http://data.ga-group.nl/ics/gics/2014/>
USING <http://data.ga-group.nl/ics/gics/2016/>
USING <http://data.ga-group.nl/ics/gics/2018/>
USING <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	GRAPH ?gx {
	?x skos:notation ?cod .
	}
	FILTER(?gx != <http://data.ga-group.nl/ics/gics/>)
	GRAPH ?gy {
	?y skos:notation ?cod .
	}
	FILTER(?gy != <http://data.ga-group.nl/ics/gics/>)
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

ECHO "constructing a revision-agnostic individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
INSERT {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/gics/1999/>
USING <http://data.ga-group.nl/ics/gics/2002/>
USING <http://data.ga-group.nl/ics/gics/2003/>
USING <http://data.ga-group.nl/ics/gics/2004/>
USING <http://data.ga-group.nl/ics/gics/2005/>
USING <http://data.ga-group.nl/ics/gics/2006/>
USING <http://data.ga-group.nl/ics/gics/2008/>
USING <http://data.ga-group.nl/ics/gics/2010/>
USING <http://data.ga-group.nl/ics/gics/2014/>
USING <http://data.ga-group.nl/ics/gics/2016/>
USING <http://data.ga-group.nl/ics/gics/2018/>
USING <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier
	}
	?x dct:isReplacedBy* ?y .
	FILTER(!ISBLANK(?y))
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/gics/",REPLACE(STR(?y),".*/",""))) AS ?z)
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;
