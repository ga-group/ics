SPARQL
DEFINE sql:log-enable 3
PREFIX trbc: <http://permid.org/ontology/trbc/>
#SELECT *
WITH <http://data.ga-group.nl/ics/trbc/2020/>
INSERT {
	?Xtrbc a ?typ , owl:NamedIndividual ;
		rdfs:isDefinedBy <http://data.ga-group.nl/ics/trbc/2020/> ;
		rdfs:label ?Xlbl ;
		rdfs:seeAlso ?perm ;
		skos:definition ?Xdefn ;
		skos:notation ?code ;
		tempo:validFrom "2020"^^xsd:gYear ;
		?hasparent ?Xptrbc ;
		## provenance
		pav:importedOn ?imp1 ;
		pav:lastRefreshedOn ?impl ;
		pav:sourceAccessedOn ?acc1 ;
		pav:sourceLastAccessedOn ?accl .
}
USING <https://permid.org/ind/>
WHERE {
	?perm a trbc:BusinessClassification , ?typ ;
		skos:prefLabel ?lbl ;
		trbc:BusinessClassificationCode ?code .

	BIND(STRLANG(STR(?lbl),"en") AS ?Xlbl)

	OPTIONAL {
	?perm rdfs:comment ?defn
	}
	BIND(STRLANG(STR(?defn),"en") AS ?Xdefn)

	OPTIONAL {
	?perm pav:sourceAccessedOn ?acc1 .
	?perm pav:sourceLastAccessedOn ?accl .
	}
	OPTIONAL {
	?perm pav:importedOn ?imp1 .
	?perm pav:lastRefreshedOn ?impl .
	}

	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/2020/",?code)) AS ?Xtrbc)
	BIND(IRI(CONCAT("http://data.ga-group.nl/ics/trbc/2020/",SUBSTR(?code,1,STRLEN(?code)-2))) AS ?Xptrbc)

	BIND(STRLEN(?code) AS ?clen)
	VALUES (?clen ?hasparent) {
	(2 UNDEF)
	(4 trbc:isBusinessSectorOf)
	(6 trbc:isIndustryGroupOf)
	(8 trbc:isIndustryOf)
	(10 trbc:isActivityOf)
	}
}
;
ECHO $ROWCNT"\n";
CHECKPOINT;
