#!/usr/bin/awk -f

BEGIN {
	FS = "\t";
	OFS = "\t";
	lang = "en"

	if (from) {
		print "from", "gics", "text", "lang", "desc"
		from = from OFS
	} else {
		print "gics", "text", "lang", "desc"
	}
}
($1 > " " && $2) {
	print from $1, $2, lang, ""
}
($3 > " " && $4) {
	print from $3, $4, lang, ""
}
($5 > " " && $6) {
	print from $5, $6, lang, ""
}
($7 > " " && $8) {
	l7 = $7
	l8 = $8
}
($7 <= " " && l7 && $8) {
	print from l7, l8, lang, $8
}
