SET u{GRAPH} http://data.ga-group.nl/ics/gics/2018/;
SET u{FILE} /home/freundt/author/ics/gics2018.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
