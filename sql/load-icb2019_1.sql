SET u{GRAPH} http://data.ga-group.nl/ics/icb/2019_1/;
SET u{FILE} /home/freundt/author/ics/icb2019_1.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
