SET u{GRAPH} http://data.ga-group.nl/ics/gics/2008/;
SET u{FILE} /home/freundt/author/ics/gics2008.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
