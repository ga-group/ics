SET u{GRAPH} http://data.ga-group.nl/ics/gics/;
SET u{FILE} /home/freundt/author/ics/gics.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
