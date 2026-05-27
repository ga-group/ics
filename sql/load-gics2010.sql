SET u{GRAPH} http://data.ga-group.nl/ics/gics/2010/;
SET u{FILE} /home/freundt/author/ics/gics2010.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
