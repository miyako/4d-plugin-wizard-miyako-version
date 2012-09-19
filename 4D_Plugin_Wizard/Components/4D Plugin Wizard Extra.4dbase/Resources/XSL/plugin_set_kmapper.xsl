<?xml version="1.0" encoding="utf-8"?>

<x:stylesheet version="1.0"
                xmlns:x="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform/alias"
				xmlns:kmapper="http://www.4d.com/namespace/reserved/FP/Constants"				
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
		
			<x:copy-of select="/ex4D:plugin/*" />	

			<x:variable name="name" select="'{./@name}'" />
			<x:variable name="position" select="'{./@position}'" />
			<x:variable name="k" select="'{./@k}'" />
			<x:variable name="str" select="'{./@str}'" />
			<x:variable name="topic" select="'{./@topic}'" />
			<x:variable name="fourdversmin" select="'{/kmapper:application/kmapper:fourdversmin}'" />
			<x:variable name="fourdversmax" select="'{/kmapper:application/kmapper:fourdversmax}'" />
			<x:variable name="appid" select="'{/kmapper:application/kmapper:appid}'" />
																				
			<xsl:if test="/kmapper:application">
			<ex4D:kmapper fourdversmin="{$fourdversmin}" fourdversmax="{$fourdversmax}" appid="{$appid}">
			<ex4D:commands>
			<xsl:for-each select="/kmapper:application/kmapper:command">
				<ex4D:command name="{$name}" plugin-id="{$str}" theme="{$topic}">
				<ex4D:params>
				<xsl:for-each select="./kmapper:param">
				<ex4D:param position="{$position}" k="{$k}" />		
				</xsl:for-each>
				</ex4D:params>	
				</ex4D:command>					
			</xsl:for-each>
			</ex4D:commands>				
			</ex4D:kmapper>		
			</xsl:if>	
					
		</ex4D:plugin>	
	</xsl:template>
										
	</xsl:stylesheet>

</x:template>

</x:stylesheet>