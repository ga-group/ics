ECHO "generating a chain of replacements between revisions using GICS code ... ";
SPARQL
DEFINE sql:log-enable 3
INSERT {
	GRAPH ?gx {
	?x dct:isReplacedBy ?y
	}
}
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier .
	}
	{
	SELECT ?x ?z
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
		?x dct:isReplacedBy* ?y .
		BIND(IRI(CONCAT("http://data.ga-group.nl/ics/gics/",REPLACE(STR(?y),".*/",""))) AS ?z)
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier
	}
	GRAPH ?gy {
	?x dct:isReplacedBy* ?y .
	FILTER NOT EXISTS {
	?y dct:isReplacedBy ?othr
	}
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/gics/",REPLACE(STR(?x),".*/",""))) AS ?u)
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/gics/",REPLACE(STR(?y),".*/",""))) AS ?z)
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
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
USING NAMED <http://data.ga-group.nl/ics/gics/1999/>
USING NAMED <http://data.ga-group.nl/ics/gics/2002/>
USING NAMED <http://data.ga-group.nl/ics/gics/2003/>
USING NAMED <http://data.ga-group.nl/ics/gics/2004/>
USING NAMED <http://data.ga-group.nl/ics/gics/2005/>
USING NAMED <http://data.ga-group.nl/ics/gics/2006/>
USING NAMED <http://data.ga-group.nl/ics/gics/2008/>
USING NAMED <http://data.ga-group.nl/ics/gics/2010/>
USING NAMED <http://data.ga-group.nl/ics/gics/2014/>
USING NAMED <http://data.ga-group.nl/ics/gics/2016/>
USING NAMED <http://data.ga-group.nl/ics/gics/2018/>
USING NAMED <http://data.ga-group.nl/ics/gics/2023/>
WHERE {
	GRAPH ?g {
	?x a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/gics/",REPLACE(STR(?x),".*/",""))) AS ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;
