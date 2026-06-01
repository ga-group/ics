SET u{GRAPH} http://data.ga-group.nl/ics/icb/2019/;
SET u{FILE} /home/freundt/author/ics/icb2019.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
