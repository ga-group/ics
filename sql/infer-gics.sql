SET u{TGTGR} http://data.ga-group.nl/ics/gics/;
SPARQL CREATE SILENT GRAPH <$u{TGTGR}>;
SPARQL CLEAR GRAPH <$u{TGTGR}>;
CHECKPOINT;

ECHO "determining validity within code/label/definition ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?x a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier , owl:NamedIndividual ;
	pav:derivedFrom [
		a	fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
		rdfs:label ?lbl ;
		skos:definition ?defn ;
		skos:notation ?code ;
		tempo:validFrom ?from ;
		tempo:validTill ?till ;
		pav:derivedFrom ?z ;
	]
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
WHERE {
	{
	SELECT *
	WHERE {
		?z a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
			rdfs:label ?lbl ;
			skos:notation ?code .
		OPTIONAL {
		?z skos:definition ?defn
		}
		OPTIONAL {
		?z tempo:validFrom ?from
		}
		OPTIONAL {
		?z tempo:validTill ?till
		}

		BIND(IRI(CONCAT("http://data.ga-group.nl/ics/gics/",REPLACE(STR(?z),".*/",""))) AS ?x)
	}
	ORDER BY ?x ?from ?z
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "condensing chains of validity 1 ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?minsub a delta:keep ;
		pav:derivedFrom ?z ;
		tempo:validFrom ?from ;
		tempo:validTill ?till
}
WHERE {
	{
	SELECT ?x ?code ?lbl ?defn MIN(?sub) AS ?minsub
	WHERE {
		?x pav:derivedFrom ?sub .
		?sub a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
			rdfs:label ?lbl ;
			skos:notation ?code ;
			skos:definition ?defn .
		FILTER(ISBLANK(?sub))
	}
	GROUP BY ?x ?code ?lbl ?defn
	}

	?x pav:derivedFrom ?sub .
	FILTER(ISBLANK(?sub))
	?sub a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
		rdfs:label ?lbl ;
		skos:notation ?code ;
		skos:definition ?defn .

	OPTIONAL {
	?sub pav:derivedFrom ?z
	}
	OPTIONAL {
	?sub tempo:validFrom ?from
	}
	OPTIONAL {
	?sub tempo:validTill ?till
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "condensing chains of validity 2 ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
PREFIX delta: <http://www.w3.org/2004/delta#>

WITH <$u{TGTGR}>
INSERT {
	?minsub a delta:keep ;
		pav:derivedFrom ?z ;
		tempo:validFrom ?from ;
		tempo:validTill ?till
}
WHERE {
	{
	SELECT ?x ?code ?lbl MIN(?sub) AS ?minsub
	WHERE {
		?x pav:derivedFrom ?sub .
		FILTER(ISBLANK(?sub))
		?sub a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
			rdfs:label ?lbl ;
			skos:notation ?code .
		FILTER NOT EXISTS {
		?sub skos:definition ?defn
		}
	}
	GROUP BY ?x ?code ?lbl ?defn
	}

	?x pav:derivedFrom ?sub .
	FILTER(ISBLANK(?sub))
	?sub a fibo-sec-sec-cls:GlobalIndustryClassificationStandardsClassifier ;
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
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

ECHO "pruning ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
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
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
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

-- ECHO "adding beef ... ";
-- SPARQL
-- DEFINE sql:log-enable 3
-- DEFINE input:same-as "yes"
-- PREFIX lcc-cr: <https://www.omg.org/spec/LCC/Countries/CountryRepresentation/>
-- PREFIX rgn: <http://data.ga-group.nl/region/>
-- 
-- WITH <$u{TGTGR}>
-- INSERT {
-- 	?z
-- 		rdfs:label ?lbl ;
-- 		foaf:name ?nam ;
-- 		lcc-cr:isClassifiedBy ?cls ;
-- 		dct:source ?src ;
-- 		skos:definition ?def
-- }
-- USING <$u{SRCGR}>
-- WHERE {
-- 	?z a rgn:keep ;
-- 		pav:derivedFrom ?x .
-- 
-- 	OPTIONAL {
-- 	?x rdfs:label ?lbl
-- 	}
-- 	OPTIONAL {
-- 	?x dct:source ?src
-- 	}
-- 	OPTIONAL {
-- 	?x foaf:name ?nam
-- 	}
-- 	OPTIONAL {
-- 	?x skos:definition ?def
-- 	}
-- 	OPTIONAL {
-- 	?x lcc-cr:isClassifiedBy ?cls
-- 	}
-- }
-- ;
-- ECHO $ROWCNT"\n";
-- CHECKPOINT;

ECHO "cleaning up ... ";
SPARQL
DEFINE sql:log-enable 3
PREFIX fibo-sec-sec-cls: <https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/>
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
