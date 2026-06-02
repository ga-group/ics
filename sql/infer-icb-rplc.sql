ECHO "generating a chain of replacements between revisions using ICB code ... ";
SPARQL
DEFINE sql:log-enable 3
INSERT {
	GRAPH ?gx {
	?x dct:isReplacedBy ?y
	}
}
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?gx {
	?x rdfs:isDefinedBy ?gx
	}
	GRAPH ?gy {
	?y dct:replaces ?x
	}
}
;
ECHO "+"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
INSERT {
	GRAPH ?gy {
	?y dct:replaces ?x
	}
}
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?gy {
	?y rdfs:isDefinedBy ?gy
	}
	GRAPH ?gx {
	?x dct:isReplacedBy ?y
	}
}
;
ECHO "+"$ROWCNT"\n";
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
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
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
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier .
	}
	{
	SELECT ?x ?z
	FROM <http://data.ga-group.nl/ics/icb/2005/>
	FROM <http://data.ga-group.nl/ics/icb/2007/>
	FROM <http://data.ga-group.nl/ics/icb/2019/>
	FROM <http://data.ga-group.nl/ics/icb/2019_1/>
	WHERE {
		?x dct:isReplacedBy* ?y .
		BIND(IRI(CONCAT("http://data.ga-group.nl/ics/icb/",REPLACE(STR(?y),".*/",""))) AS ?z)
	}
	}
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
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
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
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier
	}
	GRAPH ?gy {
	?x dct:isReplacedBy* ?y .
	FILTER NOT EXISTS {
	?y dct:isReplacedBy ?othr
	}
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
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
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
USING NAMED <http://data.ga-group.nl/ics/icb/2005/>
USING NAMED <http://data.ga-group.nl/ics/icb/2007/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019/>
USING NAMED <http://data.ga-group.nl/ics/icb/2019_1/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:IndustryClassificationBenchmarkClassifier
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/icb/",REPLACE(STR(?x),".*/",""))) AS ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;
