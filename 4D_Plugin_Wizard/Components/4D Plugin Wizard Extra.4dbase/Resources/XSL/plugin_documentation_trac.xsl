<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex4D="http://www.4d.com/plugin"
				xmlns:date="http://exslt.org/dates-and-times"
				xmlns:str="http://exslt.org/strings"
                exclude-result-prefixes="ex4D"
                >
				
<xsl:output method="text" />

<!-- the documentation and kmapper are optional -->

<xsl:key name="kmapper-commands" match="/ex4D:plugin/ex4D:kmapper/ex4D:commands/ex4D:command[@plugin-id = /ex4D:plugin/@plugin-id]/ex4D:params/ex4D:param" use="concat(../../@name, ':', ./@position)" />
<xsl:key name="command-argument-documentation" match="/ex4D:plugin/ex4D:documentation/ex4D:commands/ex4D:command-group/ex4D:command/ex4D:argument" use="concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id)" />
<xsl:key name="command-return-value-documentation" match="/ex4D:plugin/ex4D:documentation/ex4D:commands/ex4D:command-group/ex4D:command/ex4D:return-value" use="concat(../../@command-group-id, ':' , ../@command-id)" />

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


<xsl:param name="source_url" select="'http://sources.4d.com/trac/4d_keisuke/browser/SOURCES/'" />
<xsl:param name="download_url" select="'http://sources.4d.com/trac/4d_keisuke/browser/PLUGINS/'" />
<xsl:param name="support_platform" select="'Mac OS/Windows'" />
<xsl:param name="minimum_version" select="'v11'" />
<xsl:param name="current_version" select="'0.1'" />

<xsl:template match="/">

	<xsl:text>| [wiki:WikiStart Home] | [</xsl:text><xsl:value-of select="concat($source_url, str:encode-uri(/ex4D:plugin/@name, true()))" /><xsl:text> Browse source] | [</xsl:text><xsl:value-of select="concat($download_url, str:encode-uri(/ex4D:plugin/@name, true()))" /><xsl:text>.bundle.zip Download]</xsl:text>
<!--<xsl:text>&#xD; * '''Date''': </xsl:text><xsl:value-of select="date:date-time()" />-->
	<xsl:text>&#xD; * '''Platform''': </xsl:text><xsl:value-of select="$support_platform" />
	<xsl:text>&#xD; * '''Version''': </xsl:text><xsl:value-of select="$minimum_version" />
	<xsl:text>&#xD; * '''Type''': Plugin</xsl:text>
	<xsl:text>&#xD; * '''Current Version''': </xsl:text><xsl:value-of select="$current_version" />
	<xsl:text>[[BR]][[BR]]</xsl:text>

	<xsl:text>&#xD;== </xsl:text><xsl:value-of select="/ex4D:plugin/@name" /><xsl:text> ==&#xD;</xsl:text>			
	<xsl:text> * '''Summary'''[[BR]][[BR]]</xsl:text>
 
	<xsl:text>&#xD;{{{&#xD;#!html&#xD;</xsl:text>
	<xsl:copy-of select="/ex4D:plugin/ex4D:documentation/ex4D:plugin-description" />
	<xsl:text>&#xD;}}}&#xD;</xsl:text>
								
	<!-- repeat for each command -->				
	<xsl:for-each select="/ex4D:plugin/ex4D:commands/ex4D:command-group">
	<!--<a name="{concat('command:', ./@command-group-id)}" />-->				

	<xsl:text>=== </xsl:text><xsl:value-of select="./@name" /> Commands<xsl:text> ===&#xD;</xsl:text>
		
	<xsl:for-each select="./ex4D:command">
		<xsl:sort select="./@name" order="ascending" />		
		<!--<a name="{concat('command:', ../@command-group-id, ',', ./@command-id)}" />-->
		
		<xsl:text>==== </xsl:text><xsl:value-of select="./@name" /><xsl:text> ====&#xD;</xsl:text>
				
		
		<!-- if the plugin command has a return value -->
		<xsl:if test="./@type != '' and ./@type != 'N'" >	
		<xsl:text>{{{</xsl:text>
			<!-- print labels if documentation exist, otherwise the type -->			
			<xsl:choose>
			<xsl:when test="key('command-return-value-documentation', concat(../@command-group-id, ':' , ./@command-id))/@label != ''">
				<xsl:value-of select="key('command-return-value-documentation', concat(../@command-group-id, ':' , ./@command-id))/@label" />
			</xsl:when>	
			<xsl:otherwise>
				<xsl:call-template name="argument-type">
					<xsl:with-param name="type" select="./@type" />
				</xsl:call-template>		
			</xsl:otherwise>															
			</xsl:choose>
			<xsl:text>:=</xsl:text>	
			<xsl:text>}}}</xsl:text>	
		</xsl:if>
		
		<!-- the command name -->
		<xsl:text>'''''</xsl:text><xsl:value-of select="./@name" /><xsl:text>'''''</xsl:text>
		
		<!-- repeat for each argument -->
		<xsl:if test="count(./ex4D:argument)!=0">
			<xsl:text> (</xsl:text>
			
			<xsl:for-each select="./ex4D:argument">
			<xsl:text>{{{</xsl:text>
			<!-- print labels if documentation exist, otherwise the type -->
			<xsl:choose>
			<xsl:when test="key('command-argument-documentation', concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id))/@label != ''">
				<xsl:value-of select="key('command-argument-documentation', concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id))/@label" />
			</xsl:when>	
			<xsl:otherwise>
				<xsl:call-template name="argument-type">
					<xsl:with-param name="type" select="./@type" />
				</xsl:call-template>
				<xsl:value-of select="./@label" />										
			</xsl:otherwise>															
			</xsl:choose>
			
			<xsl:if test="position()!=last()" ><xsl:text>; </xsl:text></xsl:if>	 
			<xsl:text>}}}</xsl:text>	
			</xsl:for-each>
			
			<xsl:text>)</xsl:text>
		</xsl:if>	
		<xsl:text>[[BR]]</xsl:text>
		
		<!-- repeat for each argument -->
		<xsl:if test="count(./ex4D:argument)!=0 or (./@type != '' and ./@type != 'N')">
		<xsl:text>[[BR]]</xsl:text>		
			<xsl:for-each select="./ex4D:argument">					

			<!-- print labels if documentation exist -->
			<xsl:choose>								
			<xsl:when test="key('command-argument-documentation', concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id))/@label != ''">
			<xsl:text>{{{</xsl:text>
				<xsl:value-of select="key('command-argument-documentation', concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id))/@label" />
				<xsl:text> (</xsl:text>
				<xsl:call-template name="argument-type">
					<xsl:with-param name="type" select="./@type" />
				</xsl:call-template>
				<xsl:text>)</xsl:text>
			<xsl:text>}}}&#xD;</xsl:text>
									
			<!-- print documentation -->
			<xsl:variable name="command-group" select="../../@command-group-id" />
			<xsl:variable name="command" select="../@command-id" />
			<xsl:variable name="argument" select="./@argument-id" />	
					
			<xsl:text>{{{&#xD;#!html&#xD;</xsl:text>																		
			<xsl:copy-of select="/ex4D:plugin/ex4D:documentation/ex4D:commands/ex4D:command-group[@command-group-id = $command-group]/ex4D:command[@command-id = $command]/ex4D:argument[@argument-id = $argument]" />						
			<xsl:text>&#xD;}}}&#xD;</xsl:text>
			<!-- link to the associated constant group -->
			<xsl:if test="key('kmapper-commands', concat(../@name, ':', ./@argument-id))">
				<xsl:variable name="k" select="key('kmapper-commands', concat(../@name, ':', ./@argument-id))/@k" />					
				<xsl:variable name="constant-group" select="/ex4D:plugin/ex4D:constants/ex4D:constant-group[@number = $k]" />	
				<xsl:if test="$constant-group/@name">

				<xsl:text>You can use a </xsl:text>
				<!--<a href="{concat('#constant:', $constant-group/@constant-group-id)}">-->
				<xsl:value-of select="$constant-group/@name" />
				<!--</a>-->	
				<xsl:text> constant for </xsl:text>
				<xsl:text>{{{</xsl:text>
				<!-- print labels if documentation exist, otherwise the type -->
				<xsl:choose>
				<xsl:when test="key('command-argument-documentation', concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id))/@label != ''">
					<xsl:value-of select="key('command-argument-documentation', concat(../../@command-group-id, ':' , ../@command-id, ':', ./@argument-id))/@label" />
				</xsl:when>	
				<xsl:otherwise>
					<xsl:value-of select="concat('$', ./@argument-id)" />	
				</xsl:otherwise>															
				</xsl:choose>
				<xsl:text>}}}</xsl:text><xsl:text>.[[BR]][[BR]]</xsl:text>	
		
				</xsl:if>								
			</xsl:if>					

		</xsl:when>	
																	
		</xsl:choose>

		</xsl:for-each>	
	</xsl:if>
							
			<!-- if the plugin command has a return value -->									
				
			<xsl:if test="./@type != '' and ./@type != 'N'" >	
				<xsl:text>{{{</xsl:text>
				<xsl:choose>
				<xsl:when test="key('command-return-value-documentation', concat(../@command-group-id, ':' , ./@command-id))/@label != ''">
					<xsl:value-of select="key('command-return-value-documentation', concat(../@command-group-id, ':' , ./@command-id))/@label" />
				</xsl:when>	
				<xsl:otherwise>
					<xsl:value-of select="'returnValue'" />
				</xsl:otherwise>															
				</xsl:choose>
				
				<xsl:text> (</xsl:text>
				<xsl:call-template name="argument-type">
						<xsl:with-param name="type" select="./@type" />
				</xsl:call-template>
				<xsl:text>)</xsl:text>
				
				<xsl:text>}}}</xsl:text>				
				
				<xsl:text>[[BR]]</xsl:text>
				<!-- print documentation -->
				<xsl:variable name="command-group" select="../@command-group-id" />
				<xsl:variable name="command" select="./@command-id" />
				<xsl:text>&#xD;{{{&#xD;#!html&#xD;</xsl:text>	
				<xsl:copy-of select="/ex4D:plugin/ex4D:documentation/ex4D:commands/ex4D:command-group[@command-group-id = $command-group]/ex4D:command[@command-id = $command]/ex4D:return-value" />						
				<xsl:text>&#xD;}}}&#xD;</xsl:text>
			</xsl:if>					
									
			<!-- print documentation -->
			<xsl:text>&#xD; * '''</xsl:text>Discussion<xsl:text>'''&#xD;</xsl:text>
		
			<xsl:variable name="command-group" select="../@command-group-id" />
			<xsl:variable name="command" select="./@command-id" />				
			<xsl:text>&#xD;{{{&#xD;#!html&#xD;</xsl:text>	
			<xsl:copy-of select="/ex4D:plugin/ex4D:documentation/ex4D:commands/ex4D:command-group[@command-group-id = $command-group]/ex4D:command[@command-id = $command]/ex4D:command-description" />						
			<xsl:text>&#xD;}}}&#xD;</xsl:text>
			</xsl:for-each>
		</xsl:for-each>
		
		
		<!-- repeat for each constant -->				
		<xsl:for-each select="/ex4D:plugin/ex4D:constants/ex4D:constant-group">
		<!--<a name="{concat('constant:', ./@constant-group-id)}" />-->
		<xsl:text>==== </xsl:text><xsl:value-of select="./@name" /> Constants<xsl:text> ====&#xD;</xsl:text>
			<xsl:for-each select="./ex4D:constant">
			<xsl:sort select="./@value" order="ascending" />
			<xsl:text>{{{</xsl:text>
			<!--<a name="{concat('constant:', ../@constant-group-id, ',', ./@constant-id)}" />-->		
				<xsl:value-of select="./@name" />
				<xsl:text> (</xsl:text>
				<xsl:value-of select="./@value" />
				<xsl:text>)</xsl:text>	
			<xsl:text>}}}&#xD;</xsl:text>
					
			<xsl:variable name="constant-group" select="../@constant-group-id" />
			<xsl:variable name="constant" select="./@constant-id" />
			<xsl:text>&#xD;{{{&#xD;#!html</xsl:text>					
			<xsl:copy-of select="/ex4D:plugin/ex4D:documentation/ex4D:constants/ex4D:constant-group[@constant-group-id = $constant-group]/ex4D:constant[@constant-id = $constant]" />						
			<xsl:text>&#xD;}}}&#xD;</xsl:text>																																																																																																																																		
			</xsl:for-each>		
											
		</xsl:for-each>
		

		<!-- repeat for each string resource -->				
		<xsl:for-each select="/ex4D:plugin/ex4D:strings/ex4D:string-group">
		<xsl:text>=== </xsl:text><xsl:value-of select="./@name" /><xsl:text> ===&#xD;</xsl:text>
			<xsl:for-each select="./ex4D:string">
			<xsl:sort select="./@value" order="ascending" />
			
			<xsl:text>{{{</xsl:text>
				<xsl:value-of select="./@value" />
				<xsl:text> (</xsl:text>
				<xsl:value-of select="concat(../@string-group-id, ',', ./@string-id)" />
				<xsl:text>)</xsl:text>			
				<xsl:text>[[BR]]</xsl:text>			
			<xsl:text>}}}</xsl:text>	
																						
			</xsl:for-each>		
											
		</xsl:for-each>
		
<!--		<xsl:text>&#xD; * '''Documentation Update: '''</xsl:text>
		<xsl:value-of select="date:date-time()" />
-->
				
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