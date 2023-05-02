all:
	xmllint --schema tree.xsd result.xml > /dev/null

clean:
	rm *.xml