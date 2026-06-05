SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
#SELECT ?x ?Xdefn
WITH <http://data.ga-group.nl/ics/trbc/2012/>
INSERT {
	?x dct:isReplacedBy ?y
}
USING <https://permid.org/ind/>
WHERE {
	?x rdfs:seeAlso ?perm ;
		skos:notation ?codxx .

	BIND(STRDT(?codxx, xsd:string) AS ?codx)
	OPTIONAL {
	?ptch rdf:subject ?perm ;
		delta:hunk [
			delta:deletion ?codx ;
			rdf:predicate trbc:BusinessClassificationCode
		] .
	}
	FILTER(!BOUND(?ptch))
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/2020/",?codxx)) AS ?y)
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;
