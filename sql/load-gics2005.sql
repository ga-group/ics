SET u{GRAPH} http://data.ga-group.nl/ics/gics/2005/;
SET u{FILE} /home/freundt/author/ics/gics2005.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
