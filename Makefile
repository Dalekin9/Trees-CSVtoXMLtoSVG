all:
	xmllint --schema tree.xsd xmlFromCSV2.xml > /dev/null
	java -jar saxon-he-10.3.jar -s:xmlFromCSV2.xml -xsl:all_width.xsl -o:out.xml
	java -jar saxon-he-10.3.jar -s:out.xml -xsl:xmlToRectangularSVG.xsl -o:Rectangle.svg
	java -jar saxon-he-10.3.jar -s:out.xml -xsl:xmlToCircularSVG.xsl -o:Circle.svg

clean:
	rm *.xml