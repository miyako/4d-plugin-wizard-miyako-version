<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
				xmlns:date="http://exslt.org/dates-and-times"
                exclude-result-prefixes="ex4D"
                >
				
<xsl:output method="html" indent="yes" />
<xsl:strip-space elements="*" />

<xsl:param name="index-html" select="'index.html'" />
<xsl:param name="content-html" select="'content.html'" />
<xsl:param name="toc-html" select="'toc.html'" />
<xsl:param name="default-css" select="'default.css'" />

<xsl:template match="/">

<html>

	<head>
		<link rel="stylesheet" type="text/css" href="{concat('./CSS/', $default-css)}" />	
		<title><xsl:value-of select="/ex4D:plugin/@name" /></title>
	</head>
	<frameset cols="25%,75%" border="0">
		<frame name="toc" src="{$toc-html}"></frame>
		<frame name="content" src="{$content-html}"></frame>
	</frameset>
</html>

</xsl:template>

</xsl:stylesheet>