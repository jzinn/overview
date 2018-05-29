#!/bin/sh
set -eu

main() {
	files | sort | html
}

files() {
	find . -mindepth 2 -name '*.html'
}

html() {
	awk '
BEGIN {
	OFS = FS = "/"
	print "<!doctype html>"
	print "<!-- keebee3eing9iem6chiepourooSiequ8ezookaewoocoh0aophei4EeSh5auheij -->"
	print "<html lang=\"en\">"
	print "<head>"
	print "  <meta charset=\"utf-8\">"
	print "  <title>Overview</title>"
	print "</head>"
	print "<body>"
	print "  <h1>Overview</h1>"
}

{ process() }

function process(    url, name, section) {
	url = $0
	name = $NF
	$NF = ""
	section = $0
	if (section != LAST) {
		if (NR != 1)
			section_close()
		section_open(section)
	}
	LAST = section
	item(url, name)
}

function section_open(section) {
	print ""
	print "  <h3>" section "</h3>"
	print "  <ol>"
}

function section_close() {
	print "  </ol>"
}

function item(url, name) {
	print "    <li><a href=\"" url "\">" clean(name) "</a></li>"
}

function clean(name) {
	sub(/\.html$/, "", name)
	gsub(/[._]/, " ", name)
	return name
}

END {
	if (NR != 0)
		section_close()
	print "</body>"
	print "</html>"
}
'
}

main
