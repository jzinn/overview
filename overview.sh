#!/bin/sh
set -eu

find . -mindepth 2 -name '*.html' |
     sort |
     awk '
BEGIN {
	OFS = FS = "/"
	print "<!-- keebee3eing9iem6chiepourooSiequ8ezookaewoocoh0aophei4EeSh5auheij -->"
	print "<!doctype html>"
	print "<html lang=\"en\">"
	print "<head>"
	print "  <meta charset=\"utf-8\">"
	print "  <title>Overview</title>"
	print "</head>"
	print "<body>"
	print "  <h1>Overview</h1>"
}

{
	url = $0
	name = clean($NF)
	$NF = ""
	section = $0
	if (last != section)
		ol(last = section)
	li(url, name)
}

function clean(name) {
	sub(/\.html$/, "", name)
	gsub(/[._]/, " ", name)
	return name
}

function ol(section) {
	if (NR != 1)
		print "  </ol>"
	print "  <h2>" section "</h2>"
	print "  <ol>"
}

function li(section, name) {
	print "    <li><a href=\"" url "\">" name "</a></li>"
}

END {
	if (NR != 0)
		print "  </ol>"
	print "</body>"
	print "</html>"
}
'
