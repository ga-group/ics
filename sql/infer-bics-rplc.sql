ECHO "generating a chain of replacements between revisions using BICS code ... ";
SPARQL
DEFINE sql:log-enable 3
INSERT {
	GRAPH ?gx {
	?x dct:isReplacedBy ?y
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
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
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
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
PREFIX bics: <http://data.ga-group.nl/ics/bics/>
DELETE {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX bics: <http://data.ga-group.nl/ics/bics/>
INSERT {
	GRAPH ?g {
	?x dct:isVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	GRAPH ?g {
	?x a bics:Classifier .
	}
	{
	SELECT ?x ?z
	FROM <http://data.ga-group.nl/ics/bics/2014/>
	FROM <http://data.ga-group.nl/ics/bics/2020/>
	FROM <http://data.ga-group.nl/ics/bics/2024/>
	WHERE {
		?x dct:isReplacedBy* ?y .
		BIND(IRI(CONCAT("http://data.ga-group.nl/ics/bics/",REPLACE(STR(?y),".*/",""))) AS ?z)
	}
	}
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic anachronous individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX bics: <http://data.ga-group.nl/ics/bics/>
DELETE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX bics: <http://data.ga-group.nl/ics/bics/>
INSERT {
	GRAPH ?g {
	?x dct:isAnachronousVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	GRAPH ?g {
	?x a bics:Classifier
	}
	GRAPH ?gy {
	?x dct:isReplacedBy* ?y .
	FILTER NOT EXISTS {
	?y dct:isReplacedBy ?othr
	}
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/bics/",REPLACE(STR(?x),".*/",""))) AS ?u)
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/bics/",REPLACE(STR(?y),".*/",""))) AS ?z)
	FILTER(?u != ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;

ECHO "constructing a revision-agnostic contemporary individual ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX bics: <http://data.ga-group.nl/ics/bics/>
DELETE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
;
ECHO "-"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX bics: <http://data.ga-group.nl/ics/bics/>
INSERT {
	GRAPH ?g {
	?x dct:isContemporaryVersionOf ?z
	}
}
USING NAMED <http://data.ga-group.nl/ics/bics/2014/>
USING NAMED <http://data.ga-group.nl/ics/bics/2020/>
USING NAMED <http://data.ga-group.nl/ics/bics/2024/>
WHERE {
	GRAPH ?g {
	?x a bics:Classifier
	}
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/bics/",REPLACE(STR(?x),".*/",""))) AS ?z)
}
;
ECHO "+"$ROWCNT"\n";
CHECKPOINT;
