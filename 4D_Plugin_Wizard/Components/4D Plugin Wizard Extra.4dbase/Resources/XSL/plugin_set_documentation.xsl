<?xml version="1.0" encoding="utf-8"?>

<x:stylesheet version="1.0"
                xmlns:x="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform/alias"
                >

<!-- wrapper xsl to create xsl -->
				
<x:namespace-alias stylesheet-prefix="xsl" result-prefix="x" />				
<x:output method="xml" omit-xml-declaration="no" indent="yes" />
<x:template match="/">

<!-- this is the export xsl -->

	<xsl:stylesheet version="1.0"
					xmlns:ex4D="http://www.4d.com/plugin"
					exclude-result-prefixes="ex4D"
					>
					
	<xsl:output method="xml" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<ex4D:plugin plugin-id="{/ex4D:plugin/@plugin-id}" name="{/ex4D:plugin/@name}">
		<xsl:copy-of select="/ex4D:plugin/ex4D:documentation" />
		
		<x:copy-of select="/ex4D:plugin/*" />	
		</ex4D:plugin>	
	</xsl:template>
										
	</xsl:stylesheet>

</x:template>

</x:stylesheet>