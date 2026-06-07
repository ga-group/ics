SET u{GRAPH} http://data.ga-group.nl/ics/bics/2024/;
SET u{FILE} /home/freundt/author/ics/bics2024.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
