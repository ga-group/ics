SHELL := /bin/zsh

include .make.env

all: .imported.gics1999 .imported.gics2002 .imported.gics2003 .imported.gics2004 .imported.gics2005 .imported.gics2006 .imported.gics2008 .imported.gics2010 .imported.gics2014 .imported.gics2016 .imported.gics2018 .imported.gics2023
check: check.gics

TODAY := $(shell dateconv today)


check.%: %.ttl shacl/%.shacl.ttl
	truncate -s 0 /tmp/$@.ttl
	$(stardog) data add --remove-all -g "http://data.ga-group.nl/ics/" ics $< $(ADDITIONAL)
	$(stardog) icv report --output-format PRETTY_TURTLE -g "http://data.ga-group.nl/ics/" -r -l -1 ics shacl/$*.shacl.ttl \
        >> /tmp/$@.ttl || true
	$(MAKE) $*.rpt

check.%: %.ttl shacl/%.shacl.sql
	$(RM) tmp/shacl-*.qry
	mawk 'BEGIN{f=0}/\f/{f++;next}{print>"tmp/shacl-"f".qry"}' $(filter %.sql, $^)
	truncate -s 0 /tmp/$@.ttl
	$(stardog) data add --remove-all -g "http://data.ga-group.nl/ics/" iso $< $(ADDITIONAL)
	for i in tmp/shacl-*.qry; do \
		$(stardog) query execute --format PRETTY_TURTLE -g "http://data.ga-group.nl/ics/" -r -l -1 ics $${i}; \
	done \
        >> /tmp/$@.ttl || true
	$(MAKE) $*.rpt

%.rpt: /tmp/check.%.ttl
	$(sparql) --results text --data $< --query sql/valrpt.sql

.imported.%:: %.ttl.repl sql/repl-%.sql
	$(ttlck) $<
	$(csvsql) < sql/repl-$*.sql \
	&& touch $@ && $(RM) -- $<

.imported.%:: %.ttl sql/load-%.sql
	$(ttlck) $<
	$(csvsql) < sql/load-$*.sql \
	&& touch $@

export.%: sql/dump-%.sql .imported.%
	m4 $< | $(csvsql)
	$(RM) $@
	$(RSYNC)/tmp/$*.ttl /tmp/$*.ttl
	-mawk '(x+=$$0=="")<=3&&($$0==""||(x=0)||1)' $*.ttl > $@
	sed 's/rdf:type/a/' /tmp/$*.ttl \
	| ttl2ttl --sortable --expand-generic \
	| sort -u \
	| ttl2ttl -BQU \
	| sed '/^@/d;s@rdf:predicate\ta@rdf:predicate\trdf:type@' \
	>> $@
	mv $@ $*.ttl
	touch .imported.$*

setup-stardog:
	$(stardog)-admin db create -o reasoning.sameas=OFF -n ics
	$(stardog) namespace add --prefix fibo-sec-sec-cls --uri https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/ ics
	$(stardog) namespace add --prefix fibo-cls --uri https://spec.edmcouncil.org/fibo/ontology/SEC/Securities/SecuritiesClassification/ ics

unsetup-stardog:
	$(stardog)-admin db drop ics
