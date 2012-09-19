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
		<link rel="stylesheet" type="text/css" href="{concat('./CSS/', $default-css)}" />
		<title><xsl:value-of select="/ex4D:plugin/@name" /></title>
	</head>

	<body>		

		<xsl:if test="count(./ex4D:plugin/ex4D:commands/ex4D:command-group) != 0">		
		<h3><xsl:text>Commands</xsl:text></h3>
							
		<!-- repeat for each command -->				
		<xsl:for-each select="/ex4D:plugin/ex4D:commands/ex4D:command-group">
		
		<p><a target="content" href="{concat('./', $content-html, '#command:', ./@command-group-id)}"><xsl:value-of select="./@name" /></a></p>			

			<xsl:if test="count(./ex4D:command) != 0">
			<dl>
			<xsl:for-each select="./ex4D:command">
			<xsl:sort select="./@name" order="ascending" />		
			<dd><a target="content" href="{concat('./', $content-html, '#command:', ../@command-group-id, ',', ./@command-id)}"><xsl:value-of select="./@name" /></a></dd>			
			</xsl:for-each>
			</dl>
			</xsl:if>
			
		</xsl:for-each>
		</xsl:if>

		<xsl:if test="count(./ex4D:plugin/ex4D:constants/ex4D:constant-group) != 0">			
		<h3><xsl:text>Constants</xsl:text></h3>
				
		<!-- repeat for each constant -->				
		<xsl:for-each select="/ex4D:plugin/ex4D:constants/ex4D:constant-group">
		<p><a target="content" href="{concat('./', $content-html, '#constant:', ./@constant-group-id)}"><xsl:value-of select="./@name" /></a></p>		
	
			<xsl:if test="count(./ex4D:constant) != 0">
			<dl>
			<xsl:for-each select="./ex4D:constant">
			<xsl:sort select="./@value" order="ascending" />
			<dd><a target="content" href="{concat('./', $content-html, '#constant:', ../@constant-group-id, ',', ./@constant-id)}"><xsl:value-of select="./@name" /></a></dd>																			
			</xsl:for-each>		
			</dl>
			</xsl:if>
													
		</xsl:for-each>
		</xsl:if>
																	
	</body>

</html>

</xsl:template>


</xsl:stylesheet>