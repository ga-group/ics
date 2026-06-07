SET u{GRAPH} http://data.ga-group.nl/ics/bics/2020/;
SET u{FILE} /home/freundt/author/ics/bics2020.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
