<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
				xmlns:date="http://exslt.org/dates-and-times"
                exclude-result-prefixes="ex4D"
                >
				
<xsl:output method="html" indent="yes" />
<xsl:strip-space elements="*" />

<!-- the name of the content file -->

<xsl:param name="index-html" select="'index.html'" />
<xsl:param name="content-html" select="'content.html'" />
<xsl:param name="toc-html" select="'toc.html'" />
<xsl:param name="default-css" select="'default.css'" />

<xsl:template match="/">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="refresh" content="{concat('0;url=../Resources/Documentation/', $index-html)}" />
	</head>
	<body />
</html>

</xsl:template>


</xsl:stylesheet>