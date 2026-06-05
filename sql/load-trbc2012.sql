SET u{GRAPH} http://data.ga-group.nl/ics/trbc/2012/;
SET u{FILE} /home/freundt/author/ics/trbc2012.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
