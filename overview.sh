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

function process(    url, name, title) {
	url = $0
	name = $NF
	$NF = ""
	title = $0
	if (title != PREVIOUS)
		iteration_tick(title)
	PREVIOUS = title
	item(url, name)
}

function iteration_tick(title) {
	if (NR != 1)
		section_close()
	section_open(title)
}

function iteration_end() {
	if (NR)
		section_close()
}

function section_open(title) {
	print ""
	print "  <h3>" title "</h3>"
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
	iteration_end()
	print "</body>"
	print "</html>"
}
'
}

main
