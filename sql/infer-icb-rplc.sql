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
	{
	GRAPH ?gx {
	?x dct:isReplaced ?y
	}
	FILTER(?gx != <http://data.ga-group.nl/ics/icb/>)
	GRAPH ?gy {
	?y a ?typ
	}
	FILTER(?gy != <http://data.ga-group.nl/ics/icb/>)
	} UNION {
	GRAPH ?gx {
	?x a ?typ
	}
	FILTER(?gx != <http://data.ga-group.nl/ics/icb/>)
	GRAPH ?gy {
	?y dct:replaces ?x
	}
	FILTER(?gy != <http://data.ga-group.nl/ics/icb/>)
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
DELETE {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
INSERT {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier
	}
	?x dct:isReplacedBy* ?y .
	FILTER(!ISBLANK(?y))
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/icb/",REPLACE(STR(?y),".*/",""))) AS ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic anachronous individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
DELETE {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
INSERT {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier
	}
	?x dct:isReplacedBy* ?y .
	FILTER(!ISBLANK(?y))
	FILTER NOT EXISTS {
	?y dct:isReplacedBy ?othr
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/icb/",REPLACE(STR(?x),".*/",""))) AS ?u)
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/icb/",REPLACE(STR(?y),".*/",""))) AS ?z)
	FILTER(?u != ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic contemporary individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
DELETE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
INSERT {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING <http://data.ga-group.nl/ics/icb/2005/>
USING <http://data.ga-group.nl/ics/icb/2007/>
USING <http://data.ga-group.nl/ics/icb/2019/>
USING <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/icb/",REPLACE(STR(?x),".*/",""))) AS ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;
