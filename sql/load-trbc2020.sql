SET u{GRAPH} http://data.ga-group.nl/ics/trbc/2020/;
SET u{FILE} /home/freundt/author/ics/trbc2020.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
