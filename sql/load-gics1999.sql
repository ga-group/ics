SET u{GRAPH} http://data.ga-group.nl/ics/gics/1999/;
SET u{FILE} /home/freundt/author/ics/gics1999.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
