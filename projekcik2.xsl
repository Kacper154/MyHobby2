<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="/anime">
<html lang="pl">
<head>	
	<title>Anime</title>
	<link rel="stylesheet" href="p2.css"/>
</head>
<body>
	<div class="container">
		<header id="header">  
			<h1><xsl:value-of select="tytuł"/></h1>
		</header>
		
			
		<article id="content">
			
			
				
				<xsl:apply-templates select="links"/>
				
				<xsl:apply-templates select="media"/>
				
				
				<h3><xsl:value-of select="top"/></h3>
				<xsl:apply-templates select="co"/>
				
		</article>
		
		<div style="clear:both"></div>
		
		<footer id="footer">
			<xsl:call-template name="szablon_nazwa"/>
		</footer>
	</div>
</body>
</html>
</xsl:template>	

<xsl:template name="szablon_nazwa">
	<xsl:copy-of select="$stopka"/>
	<br/><br/>
	<xsl:copy-of select="$stopka2"/> 
	<xsl:copy-of select="$stopka3"/>
</xsl:template>

<xsl:variable name="stopka3" select="/anime/dzk"/>
<xsl:variable name="stopka2" select="/anime/ser"/>

<xsl:variable name="stopka">
Kacper Kulaszewicz Wszelkie prawa zastrzeżone
</xsl:variable>

<xsl:template match="co">
	<xsl:for-each select="nazwa_anime">
		<xsl:sort select="@nazwa"/>
		<xsl:choose>
			<xsl:when test="@nazwa = 'Death Note'">
				<h2 style="color:blue">
				<xsl:value-of select="@nazwa"/></h2>
			</xsl:when>
		</xsl:choose>
		<xsl:apply-templates select="opis"/>
	</xsl:for-each>
</xsl:template>

<xsl:template match="opis">
	<h3>
		<xsl:value-of select="name(gatunek)"/>
	</h3>
	<xsl:apply-templates select="gatunek"/>
	<xsl:apply-templates select="ile_odc"/>
	<br/>
	<xsl:apply-templates select="pierwowzór"/>
	<h4>Opis</h4>
	<xsl:value-of select="tekst"/>
</xsl:template>

<xsl:template match="gatunek">
	<xsl:if test="@shōnen = 'yes'">
		<xsl:value-of select="tekst"/>
		<xsl:value-of select="zalecany_odb/tekst"/>
	</xsl:if>
</xsl:template>

<xsl:template match="ile_odc">
	<xsl:if test="@ponadsto = 'nie'">
		<h4>Liczba odcinków</h4>
		<xsl:value-of select="tekst[2]"/>
	</xsl:if>
</xsl:template>

<xsl:template match="pierwowzór">
	<h4>
		<xsl:value-of select="translate(substring(name(@pierw),0,5), 'pier', 'Pier')"/>wowzór
	</h4>
	<xsl:value-of select="tekst"/>
</xsl:template>

<xsl:template match="links">
	<h2>Linki</h2>
	<xsl:apply-templates select="link[3]"/>
	<br/>
</xsl:template>

<xsl:template match="link[3]">
	<a href="{@source}">
		<xsl:value-of select="."/>
	</a>
	<br/>
</xsl:template>

<xsl:template match="media">
	<xsl:apply-templates select="image[last()]"/>
</xsl:template>


<xsl:template match="image[4]">
	Zdjęcie przedstawiające:<br/>
	<xsl:value-of select="."/>
	<br/>
	<img src="{@source}" alt="zdj" class="img"/>
</xsl:template>


</xsl:stylesheet>