ECHO "generating a chain of replacements between revisions using TRBC code ... ";
SPARQL
DEFINE sql:log-enable 3
INSERT {
	GRAPH ?gx {
	?x dct:isReplacedBy ?y
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
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
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
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
PREFIX trbc: <http://permid.org/ontology/trbc/>
DELETE {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
INSERT {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	GRAPH ?g {
	?x a trbc:BusinessClassification .
	}
	{
	SELECT ?x ?z
	FROM <http://data.ga-group.nl/ics/trbc/2012/>
	FROM <http://data.ga-group.nl/ics/trbc/2020/>
	WHERE {
		?x dct:isReplacedBy* ?y .
		BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/",REPLACE(STR(?y),".*/",""))) AS ?z)
	}
	}
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic anachronous individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
DELETE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
INSERT {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	GRAPH ?g {
	?x a trbc:BusinessClassification .
	}
	GRAPH ?gy {
	?x dct:isReplacedBy* ?y .
	FILTER NOT EXISTS {
	?y dct:isReplacedBy ?othr
	}
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/",REPLACE(STR(?x),".*/",""))) AS ?u)
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/",REPLACE(STR(?y),".*/",""))) AS ?z)
	FILTER(?u != ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic contemporary individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
DELETE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
INSERT {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/trbc/2012/>
USING NAMED <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	GRAPH ?g {
	?x a trbc:BusinessClassification .
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/",REPLACE(STR(?x),".*/",""))) AS ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;
