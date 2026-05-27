changequote()changequote([,])
DB.DBA.XML_SET_NS_DECL('dct','http://purl.org/dc/terms/', 1);
DB.DBA.XML_SET_NS_DECL('delta','http://www.w3.org/2004/delta#', 1);
DB.DBA.XML_SET_NS_DECL('fibo-fnd-rel-rel','https://spec.edmcouncil.org/fibo/ontology/FND/Relations/Relations/', 1);
DB.DBA.XML_SET_NS_DECL('fibo-fnd-utl-av', 'https://spec.edmcouncil.org/fibo/ontology/FND/Utilities/AnnotationVocabulary/', 1);
DB.DBA.XML_SET_NS_DECL('fibo-sec-sec-cls','https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/', 1);
DB.DBA.XML_SET_NS_DECL('lcc-3166-1-adj','https://www.omg.org/spec/LCC/Countries/ISO3166-1-CountryCodes-Adjunct/', 1);
DB.DBA.XML_SET_NS_DECL('lcc-lr','https://www.omg.org/spec/LCC/Languages/LanguageRepresentation/', 1);
DB.DBA.XML_SET_NS_DECL('owl','http://www.w3.org/2002/07/owl#', 1);
DB.DBA.XML_SET_NS_DECL('pav','http://purl.org/pav/', 1);
DB.DBA.XML_SET_NS_DECL('prov','http://www.w3.org/ns/prov#', 1);
DB.DBA.XML_SET_NS_DECL('rdf','http://www.w3.org/1999/02/22-rdf-syntax-ns#', 1);
DB.DBA.XML_SET_NS_DECL('rdfs','http://www.w3.org/2000/01/rdf-schema#', 1);
DB.DBA.XML_SET_NS_DECL('skos','http://www.w3.org/2004/02/skos/core#', 1);
DB.DBA.XML_SET_NS_DECL('sm','http://www.omg.org/techprocess/ab/SpecificationMetadata/', 1);
DB.DBA.XML_SET_NS_DECL('tempo','http://purl.org/tempo/', 1);
DB.DBA.XML_SET_NS_DECL('vann', 'http://purl.org/vocab/vann/', 1);
DB.DBA.XML_SET_NS_DECL('xsd','http://www.w3.org/2001/XMLSchema#', 1);

DB.DBA.XML_REMOVE_NS_BY_PREFIX('dbpedia',3);
DB.DBA.XML_SET_NS_DECL('wd','http://www.wikidata.org/entity/', 1);

include(sql/dump-generic.sql)
CREATE DUMP_PROCEDURE(dump_gics1999,
SPARQL
DEFINE input:storage ""
PREFIX owl: <http://www.w3.org/2002/07/owl#>
SELECT ?s ?p ?o
FROM <http://data.ga-group.nl/ics/gics/1999/>
WHERE {
	?s a ?t ; ?p ?o .
	FILTER(?t != owl:Ontology)
}
);

dump_gics1999('/tmp/gics1999.ttl');
CHECKPOINT;
