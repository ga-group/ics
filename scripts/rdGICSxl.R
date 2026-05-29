#!/home/freundt/usr/bin/Rscript --vanilla

library(readxl)
library(data.table)
library(edges)

if (sys.nframe() == 0L) {
	args <- commandArgs(trailingOnly=TRUE)
	outf <- "/dev/stdout"

	if ("--help" %in% args || "-h" %in% args) {
		cat("Usage: rdxl.R XLSX...\n");
		quit();
	}
	if (!is.na(tmp <- match("--asof", args))) {
		args <- args[-tmp]
		asof <- as.IDate(args[tmp])
		args <- args[-tmp]
	}
	if (with_filename <- !is.na(tmp <- match("--with-filename", args))) {
		args <- args[-tmp]
	}

	a <- as.POSIXct(sapply(args, file.mtime), origin="1970-01-01")
	a <- sapply(a, strftime, format="%FT%TZ")
	X <- lapply(args, read_excel, na="", col_types="text", col_names=FALSE)

	for (i in seq_len(length(X))) {
		X[[i]]$accd <- a[[i]]
	}
	if (with_filename) {
		for (i in seq_len(length(X))) {
			X[[i]]$file <- args[[i]]
		}
	}
	X <- unique(rbindlist(X, use.names=TRUE, fill=TRUE))

	## massaging
	if (exists("asof")) {
		X[, from:=asof]
	} else {
		X[, from:=NA_character_]
	}
	## readxl can't skip nicely, we do it for him
	grep("^[0-9]+$",X$`...1`)[[1L]] -> skip
	X[-(1L:(skip-1L))] -> X

	## last one is special because every other line contains the definition
	X[, .(gics=`...7`,stuf=`...8`,`accd`,`from`)] -> Y
	Y[seq(1L,.N-.N%%2L,by=2), gics] -> G
	Y[seq(1L,.N-.N%%2L,by=2), var:="A"]
	Y[seq(2L,.N,by=2), gics:=G]
	Y[seq(2L,.N,by=2), var:="B"]

	rbind(X[, .(gics=`...1`,text=`...2`,desc=NA_character_, `accd`,`from`)],
		X[, .(gics=`...3`,text=`...4`,desc=NA_character_,`accd`,`from`)],
		X[, .(gics=`...5`,text=`...6`,desc=NA_character_,`accd`,`from`)],
		dcast(Y[gics>" "],gics+accd+from~var,value.var="stuf")[,.(gics,A,B,accd,from)],
		use.names=FALSE) -> X

	X[, lang:="en"]

	## discontinued stuff
	X[!grepl("iscontin",text,fixed=TRUE)] -> X
	## definition update, new code, etc.
	X[, text:=gsub(" \\([DN]e.*","",text)]
	## footnotes
	X[, text:=gsub("\\*$","",text)]
	## newlines in text
	X[, text:=gsub("[\r\n]+"," ",text)]
	## newlines in defn
	X[, desc:=gsub("[\r]","",desc)]
	X[, desc:=gsub("[\n]","\\\\n",desc)]

	fwrite(X, outf, sep="\t", na="", quote="auto")
}
