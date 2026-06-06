SET u{GRAPH} http://data.ga-group.nl/ics/rbss/2004/;
SET u{FILE} /home/freundt/author/ics/rbss2004.ttl;
LOAD 'sql/load-generic.sql';
LOAD 'sql/prov-massage.sql';
CHECKPOINT;
