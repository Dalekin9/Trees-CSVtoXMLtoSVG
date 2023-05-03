all:
	xmllint --schema tree.xsd result.xml > /dev/null
make:
	java -jar saxon-he-10.3.jar -s:result2.xml -xsl:all_width.xsl -o:out.xml
clean:
	rm *.xml