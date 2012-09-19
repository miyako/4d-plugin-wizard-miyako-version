<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
                exclude-result-prefixes="ex4D"
                >
				
<xsl:output method="xml" indent="yes" />
<xsl:strip-space elements="*" />

<xsl:template match="/">
<xsl:apply-templates select="/ex4D:plugin/ex4D:kmapper" />
</xsl:template>

<xsl:template match="/ex4D:plugin/ex4D:kmapper">

	<application xmlns="http://www.4d.com/namespace/reserved/FP/Constants">
	<appid><xsl:value-of select="./@appid" /></appid>	
	<fourdversmin><xsl:value-of select="./@fourdversmin" /></fourdversmin>
	<fourdversmax><xsl:value-of select="./@fourdversmax" /></fourdversmax>	

	<xsl:for-each select="./ex4D:commands/ex4D:command">
	<command name="{./@name}" str="{./@command-id}" topic="{./@theme}">	
		<xsl:for-each select="./ex4D:params/ex4D:param">
		<param position="{./@position}" k="{./@k}" />			
		</xsl:for-each> 		
	</command>	
	</xsl:for-each>	
	
	</application>
	
</xsl:template>

</xsl:stylesheet>