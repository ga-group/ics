SET u{TGTGR} http://data.ga-group.nl/ics/trbc/;
SPARQL CREATE SILENT GRAPH <$u{TGTGR}>;
SPARQL CLEAR GRAPH <$u{TGTGR}>;
CHECKPOINT;

ECHO "determining validity within code/label/definition ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?x a trbc:BusinessClassification , owl:NamedIndividual , ?tier ;
	rdfs:isDefinedBy ics-trbc: ;
	pav:derivedFrom [
		a	trbc:BusinessClassification , ?typ ;
		rdfs:label ?lbl ;
		skos:definition ?defn ;
		skos:notation ?code ;
		pav:sourceAccessedOn ?acc1 ;
		pav:sourceLastAccessedOn ?accl ;
		tempo:validFrom ?from ;
		tempo:validTill ?till ;
		pav:derivedFrom ?z ;
	]
}
USING <http://data.ga-group.nl/ics/rbss/2004/>
USING <http://data.ga-group.nl/ics/trbc/2008/>
USING <http://data.ga-group.nl/ics/trbc/2012/>
USING <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	{
	SELECT *
	WHERE {
		?z a trbc:BusinessClassification ;
			rdfs:label ?lbl ;
			skos:notation ?code ;
			dct:isVersionOf ?x .
		FILTER(LANG(?lbl) = "en")

		OPTIONAL {
		?z dct:isContemporaryVersionOf ?cvx
		}
		OPTIONAL {
		?z dct:isAnachronousVersionOf ?avx
		}
		BIND(IRI(IF(?cvx = ?x, prov:ContemporaryDerivation, IF(?avx = ?x, prov:AnachronousDerivation, prov:Derivation))) AS ?typ)

		OPTIONAL {
		?z a ?tier
		FILTER(?tier != trbc:BusinessClassification)
		FILTER(STRSTARTS(STR(?tier),STR(trbc:)))
		}

		OPTIONAL {
		?z skos:definition ?defn
		FILTER(LANG(?defn) = "en")
		}
		OPTIONAL {
		?z tempo:validFrom ?from
		}
		OPTIONAL {
		?z tempo:validTill ?till
		}
		OPTIONAL {
		?z pav:sourceAccessedOn ?acc1
		}
		OPTIONAL {
		?z pav:sourceLastAccessedOn ?accl
		}
	}
	ORDER BY ?x ?from ?z
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "determining parents and replacements ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?x
	dct:isReplacedBy ?w ;
	?hasparent ?parx
}
USING <http://data.ga-group.nl/ics/rbss/2004/>
USING <http://data.ga-group.nl/ics/trbc/2008/>
USING <http://data.ga-group.nl/ics/trbc/2012/>
USING <http://data.ga-group.nl/ics/trbc/2020/>
WHERE {
	?z a trbc:BusinessClassification ;
		dct:isContemporaryVersionOf ?x .

	OPTIONAL {
		?z dct:isReplacedBy ?u .
		?z dct:isContemporaryVersionOf ?v .
		?u dct:isContemporaryVersionOf ?w .
		FILTER(?v != ?w)
	}
	VALUES ?hasparent {
		trbc:isBusinessSectorOf
		trbc:isIndustryGroupOf
		trbc:isIndustryOf
		trbc:isActivityOf
	}
	?z ?hasparent ?parz .
	?parz dct:isContemporaryVersionOf ?parx .
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;


ECHO "condensing chains of validity 1 ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?minsub a delta:keep ;
		pav:derivedFrom ?z ;
		pav:sourceAccessedOn ?acc1 ;
		pav:sourceLastAccessedOn ?accl ;
		tempo:validFrom ?from ;
		tempo:validTill ?till .
}
WHERE {
	{
	SELECT ?x ?code ?lbl ?defn MIN(?sub) AS ?minsub
	WHERE {
		?x pav:derivedFrom ?sub .
		?sub a trbc:BusinessClassification ;
			rdfs:label ?lbl ;
			skos:notation ?code ;
			skos:definition ?defn .
		FILTER(ISBLANK(?sub))
	}
	GROUP BY ?x ?code ?lbl ?defn
	}

	?x pav:derivedFrom ?sub .
	FILTER(ISBLANK(?sub))
	?sub a trbc:BusinessClassification ;
		rdfs:label ?lbl ;
		skos:notation ?code ;
		skos:definition ?defn .

	OPTIONAL {
	?sub dct:isReplacedBy ?w
	}
	OPTIONAL {
	?sub pav:derivedFrom ?z
	}
	OPTIONAL {
	?sub tempo:validFrom ?from
	}
	OPTIONAL {
	?sub tempo:validTill ?till
	}
	OPTIONAL {
	?sub pav:sourceAccessedOn ?acc1
	}
	OPTIONAL {
	?sub pav:sourceLastAccessedOn ?accl
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "condensing chains of validity 2 ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?minsub a delta:keep ;
		pav:derivedFrom ?z ;
		pav:sourceAccessedOn ?acc1 ;
		pav:sourceLastAccessedOn ?accl ;
		tempo:validFrom ?from ;
		tempo:validTill ?till
}
WHERE {
	{
	SELECT ?x ?code ?lbl MIN(?sub) AS ?minsub
	WHERE {
		?x pav:derivedFrom ?sub .
		FILTER(ISBLANK(?sub))
		?sub a trbc:BusinessClassification ;
			rdfs:label ?lbl ;
			skos:notation ?code .
		FILTER NOT EXISTS {
		?sub skos:definition ?defn
		}
	}
	GROUP BY ?x ?code ?lbl
	}

	?x pav:derivedFrom ?sub .
	FILTER(ISBLANK(?sub))
	?sub a trbc:BusinessClassification ;
		rdfs:label ?lbl ;
		skos:notation ?code .

	OPTIONAL {
	?sub pav:derivedFrom ?z
	}
	OPTIONAL {
	?sub tempo:validFrom ?from
	}
	OPTIONAL {
	?sub tempo:validTill ?till
	}
	OPTIONAL {
	?sub pav:sourceAccessedOn ?acc1
	}
	OPTIONAL {
	?sub pav:sourceLastAccessedOn ?accl
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "pruning ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
DELETE {
	?z ?p ?o .
	?x pav:derivedFrom ?z .
}
WHERE {
	?x pav:derivedFrom ?z .
	FILTER(ISBLANK(?z))
	FILTER NOT EXISTS {
	?z a delta:keep
	}
	?z ?p ?o .
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "condensing validity ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
DELETE {
	?x
		tempo:validFrom ?z ;
		tempo:validTill ?z .
}
WHERE {
	?x
		tempo:validFrom ?z ;
		tempo:validTill ?z .
}
;
ECHO $ROWCNT"\n";

ECHO "condensing source access ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
DELETE {
	?x
		pav:sourceAccessedOn ?acco
}
WHERE {
	?x pav:sourceAccessedOn ?acc1 , ?acco .
	FILTER(?acco > ?acc1)
}
;
ECHO $ROWCNT" + ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
DELETE {
	?x
		pav:sourceLastAccessedOn ?acco
}
WHERE {
	?x pav:sourceLastAccessedOn ?accl , ?acco .
	FILTER(?acco < ?accl)
}
;
ECHO $ROWCNT"\n";

ECHO "condensing replacements ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
DELETE {
	?x dct:isReplacedBy ?x .
}
WHERE {
	?x dct:isReplacedBy ?x .
}
;
ECHO "+"$ROWCNT" ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?y dct:replaces ?x .
}
WHERE {
	?x dct:isReplacedBy ?y .
}
;
ECHO "+"$ROWCNT"\n";

ECHO "adding beef ... ";
SPARQL
DEFINE sql:log-enable 3
DEFINE input:same-as "yes"
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?x
		pav:createdWith <file:infer-trbc.sql> ;
		pav:sourceAccessedOn ?acc1 ;
		pav:sourceLastAccessedOn ?accl ;
		tempo:validFrom ?minfrom ;
		tempo:validTill ?maxtill ;
		rdfs:label ?lbl ;
		skos:definition ?defn ;
		skos:notation ?code .
}
WHERE {
	?x a trbc:BusinessClassification .
	FILTER(!ISBLANK(?x))

	{
	SELECT ?x MIN(?from) AS ?minfrom MAX(?from) AS ?maxfrom
	WHERE {
	?x a trbc:BusinessClassification ;
		pav:derivedFrom ?z .
	?z a prov:ContemporaryDerivation ;
		tempo:validFrom ?from
	}
	GROUP BY ?x
	}

	## find the guy with minfrom validity
	?x pav:derivedFrom ?minz .
	?minz tempo:validFrom ?fromn .
	FILTER(STR(?fromn) = STR(?minfrom))
	OPTIONAL {
	?minz pav:sourceAccessedOn ?acc1
	}

	## find the guy with maxfrom validity
	?x pav:derivedFrom ?maxz .
	?maxz tempo:validFrom ?fromx .
	FILTER(STR(?fromx) = STR(?maxfrom))

	## and maxz''s beef
	?maxz
		rdfs:label ?lbl ;
		skos:notation ?code .
	OPTIONAL {
	?maxz skos:definition ?defn
	}
	OPTIONAL {
	?maxz tempo:validTill ?maxtill
	FILTER(STR(?maxtill) > STR(?maxfrom))
	}
	OPTIONAL {
	?maxz pav:sourceLastAccessedOn ?accl
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "cleaning up ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
PREFIX ics-trbc: <http://data.ga-group.nl/ics/trbc/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
DELETE {
	?x a delta:keep 
}
WHERE {
	?x a delta:keep
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;
