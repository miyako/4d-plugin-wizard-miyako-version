<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
                exclude-result-prefixes="ex4D"
                >
				
<xsl:output method="xml" indent="yes" />
<xsl:strip-space elements="*" />

<xsl:template match="/">
	<ex4D:plugin>
	<xsl:copy-of select="/ex4D:plugin/ex4D:documentation" />
	</ex4D:plugin>	
</xsl:template>

</xsl:stylesheet>