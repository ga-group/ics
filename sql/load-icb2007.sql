SET u{GRAPH} http://data.ga-group.nl/ics/icb/2007/;
SET u{FILE} /home/freundt/author/ics/icb2007.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
