<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
                exclude-result-prefixes="ex4D"
                >
				
<xsl:output method="text" />

<xsl:template match="/">
	<xsl:value-of select="/ex4D:plugin/@name" />
</xsl:template>

</xsl:stylesheet>