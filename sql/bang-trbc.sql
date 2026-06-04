SPARQL
DEFINE sql:log-enable 3
#SELECT ?x ?Xdefn
WITH <http://data.ga-group.nl/ics/trbc/2012/>
INSERT {
	?x rdfs:label ?Xlbl
}
USING <https://permid.org/ind/>
WHERE {
	?x rdfs:seeAlso ?perm .
	?perm skos:prefLabel ?lbl .
	
	OPTIONAL {
	?ptch rdf:subject ?perm ;
		delta:hunk [
			delta:deletion ?lbl2012 ;
			rdf:predicate skos:prefLabel
		] .
	}
	BIND(STRLANG(COALESCE(?lbl2012,?lbl),"en") AS ?Xlbl)
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

SPARQL
DEFINE sql:log-enable 3
#SELECT ?x ?Xdefn
WITH <http://data.ga-group.nl/ics/trbc/2012/>
INSERT {
	?x skos:definition ?Xdefn
}
USING <https://permid.org/ind/>
WHERE {
	?x rdfs:seeAlso ?perm .
	?perm rdfs:comment ?defn .
	
	OPTIONAL {
	?ptch rdf:subject ?perm ;
		delta:hunk [
			delta:deletion ?defn2012 ;
			rdf:predicate rdfs:comment
		] .
	}
	BIND(STRLANG(COALESCE(?defn2012,?defn),"en") AS ?Xdefn)
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;

SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
#SELECT ?x ?Xdefn
WITH <http://data.ga-group.nl/ics/trbc/2012/>
INSERT {
	?x skos:notation ?Xcode
}
USING <https://permid.org/ind/>
WHERE {
	?x rdfs:seeAlso ?perm .
	?perm trbc:BusinessClassificationCode ?code .
	
	OPTIONAL {
	?ptch rdf:subject ?perm ;
		delta:hunk [
			delta:deletion ?code2012 ;
			rdf:predicate trbc:BusinessClassificationCode
		] .
	}
	BIND(STR(COALESCE(?code2012,?code)) AS ?Xcode)
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;
