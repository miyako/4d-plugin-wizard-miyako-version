<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
                >
				
<xsl:output method="xml" indent="yes" />
<xsl:strip-space elements="*" />

<!-- localizable -->

<xsl:param name="paramtype_L" select="'LONGINT'" />
<xsl:param name="paramtype_T" select="'TEXT'" />
<xsl:param name="paramtype_Y" select="'ARRAY'" />
<xsl:param name="paramtype_N" select="'UNDEFINED'" />
<xsl:param name="paramtype_D" select="'DATE'" />
<xsl:param name="paramtype_H" select="'TIME'" />
<xsl:param name="paramtype_I" select="'INTEGER'" />
<xsl:param name="paramtype_O" select="'BLOB'" />
<xsl:param name="paramtype_P" select="'PICTURE'" />
<xsl:param name="paramtype_8" select="'REAL'" />
<xsl:param name="paramtype_Z" select="'POINTER'" />

<xsl:template match="/">

<ex4D:plugin>
	<xsl:comment><xsl:value-of select="/ex4D:plugin/@name" /></xsl:comment>
	
	<ex4D:documentation name="{/ex4D:plugin/@name}" plugin-id="{/ex4D:plugin/@plugin-id}">

	<ex4D:plugin-description>				
	<xsl:comment> write documentation for <xsl:value-of select="/ex4D:plugin/@name" /> here </xsl:comment>	
	</ex4D:plugin-description>		

	<xsl:if test="/ex4D:plugin/ex4D:commands">
		<ex4D:commands>
		<xsl:for-each select="/ex4D:plugin/ex4D:commands/ex4D:command-group">
			<ex4D:command-group command-group-id="{./@command-group-id}" name="{./@name}">
			<xsl:for-each select="./ex4D:command">			
				<ex4D:command command-id="{./@command-id}" name="{./@name}">
					<ex4D:command-description>				
					<xsl:comment> write documentation for <xsl:value-of select="./@name" /> here </xsl:comment>	
					</ex4D:command-description>					
					<xsl:for-each select="./ex4D:argument">
					<ex4D:argument argument-id="{./@argument-id}" type="{./@type}" label="">
					<xsl:comment> write documentation for $<xsl:value-of select="./@argument-id" /> (<xsl:call-template name="argument-type"><xsl:with-param name="type" select="./@type" /></xsl:call-template>) here</xsl:comment>			
					</ex4D:argument>		
					</xsl:for-each>	
					<xsl:if test="./@type != '' and ./@type != 'N'" >
					<ex4D:return-value type="{./@type}" label="">
					<xsl:comment> write documentation for return value (<xsl:call-template name="argument-type"><xsl:with-param name="type" select="./@type" /></xsl:call-template>) here</xsl:comment>
					</ex4D:return-value>
					</xsl:if>
				</ex4D:command>			
			</xsl:for-each>			
			</ex4D:command-group>			
		</xsl:for-each>	
		</ex4D:commands>	
	</xsl:if>			
		
	<xsl:if test="/ex4D:plugin/ex4D:constants">
		<ex4D:constants>
		<xsl:for-each select="/ex4D:plugin/ex4D:constants/ex4D:constant-group">
			<ex4D:constant-group constant-group-id="{./@constant-group-id}" name="{./@name}" number="{./@number}">
			<xsl:for-each select="./ex4D:constant">
				<ex4D:constant constant-id="{./@constant-id}" name="{./@name}" type="{./@type}" value="{./@value}">
				<xsl:comment> write documentation for <xsl:value-of select="./@name" /> (<xsl:value-of select="./@value" />) here</xsl:comment>	
				</ex4D:constant>	
			</xsl:for-each>			
			</ex4D:constant-group>			
		</xsl:for-each>	
		</ex4D:constants>	
	</xsl:if>	
	
	</ex4D:documentation>

</ex4D:plugin>

</xsl:template>


<xsl:template name="argument-type">
<xsl:param name="type" />
<xsl:choose>
<xsl:when test="$type = 'Y'">
<xsl:value-of select="$paramtype_Y" />
</xsl:when>
<xsl:when test="$type = 'T'">
<xsl:value-of select="$paramtype_T" />
</xsl:when>
<xsl:when test="$type = 'L'">
<xsl:value-of select="$paramtype_L" />
</xsl:when>
<xsl:when test="$type = 'D'">
<xsl:value-of select="$paramtype_D" />
</xsl:when>
<xsl:when test="$type = 'H'">
<xsl:value-of select="$paramtype_H" />
</xsl:when>
<xsl:when test="$type = 'I'">
<xsl:value-of select="$paramtype_I" />
</xsl:when>
<xsl:when test="$type = 'O'">
<xsl:value-of select="$paramtype_O" />
</xsl:when>
<xsl:when test="$type = 'P'">
<xsl:value-of select="$paramtype_P" />
</xsl:when>
<xsl:when test="$type = '8'">
<xsl:value-of select="$paramtype_8" />
</xsl:when>		
<xsl:when test="$type = 'Z'">
<xsl:value-of select="$paramtype_Z" />
</xsl:when>	
<xsl:otherwise>
<xsl:value-of select="$paramtype_N" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>