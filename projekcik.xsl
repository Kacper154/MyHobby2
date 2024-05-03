<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:template match="/anime">
<html lang="pl">
<head>	
	<title>Anime</title>
	<link rel="stylesheet" href="projekt.css"/>
</head>
<body>
	<div class="container">
		<header id="header">  
			<h1>Anime</h1>
		</header>
		
		<nav id="left">
				<img src="img/sasuke.jpg" alt="sasuke" class="img"/>
				<br/><br/>
				<img src="img/itachi.jpg" alt="itachi" class="img"/>
				<br/><br/>
				<img src="img/madara.jpg" alt="madara" class="img"/>
				
		</nav>		

			
		<article id="content">
			<h2><xsl:value-of select="tytuł"/></h2>
			<h3><xsl:value-of select="top"/></h3>
			
				<xsl:apply-templates select="co"/>
				
				<xsl:apply-templates select="links"/>
				
				<xsl:apply-templates select="media"/>
				
				<br/><br/>
				Suma odcinków: <xsl:value-of select="sum(//odc)"/>
		</article>
		
		<aside id="right">
				<a href="formularz.html" class="link">
					<div class="opcja">
						Formularz
					</div>
				</a>
				
				
				<a href="galeria.html" class="link">
					<div class="opcja">
						Galeria
					</div>
				</a>
				
				<a href="zrodla.html" class="link">
					<div class="opcja">
						Źródła
					</div>
				</a>
				<a class="link">
				<div class="opcja">
				Liczba zdjęć na stronie:
				<xsl:value-of select="count(//image)"/>
				</div>
				</a>
		</aside>
		
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
			<xsl:when test="@nazwa = 'Naruto'">
				<h2 style="color:green"><xsl:number format="1. " value="position()"/>
				<xsl:value-of select="@nazwa"/></h2>
			</xsl:when>
			<xsl:when test="@nazwa = 'Death Note'">
				<h2 style="color:blue"><xsl:number format="1. " value="position()"/>
				<xsl:value-of select="@nazwa"/></h2>
			</xsl:when>
			<xsl:otherwise>
				<h2><xsl:number format="1. " value="position()"/>
				<xsl:value-of select="@nazwa"/></h2>
			</xsl:otherwise>
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
		<ul>
			<li><xsl:value-of select="tekst"/></li>
			<li><xsl:value-of select="zalecany_odb/tekst"/></li>
		</ul>
	</xsl:if>
	<xsl:if test="@shōnen = 'no'">
		<ul>
			<li><xsl:value-of select="zalecany_odb/tekst"/></li>
		</ul>
	</xsl:if>
</xsl:template>

<xsl:template match="ile_odc">
	<xsl:if test="@ponadsto = 'tak'">
		<h4>Liczba odcinków</h4>
		<xsl:value-of select="tekst"/>
		<xsl:value-of select="format-number(odc, '#.0')"/>
	</xsl:if>
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
	<xsl:apply-templates select="link"/>
	<br/>
</xsl:template>

<xsl:template match="link">
	<xsl:number format="1) " grouping-separator="3"/>
	<a href="{@source}">
		<xsl:value-of select="."/>
	</a>
	<br/>
</xsl:template>

<xsl:template match="media">
	<xsl:apply-templates select="image[1]"/>
	<xsl:apply-templates select="image[2]"/>
	<xsl:apply-templates select="image[3]"/>
	<xsl:apply-templates select="image[last()]"/>
</xsl:template>

<xsl:template match="image[1]">
	<center>Zdjęcie przedstawiające:<br/>
	<xsl:value-of select="."/>
	<br/>
	<xsl:apply-templates select="@source"/></center>
</xsl:template>

<xsl:template match="image[2]">
	Zdjęcie przedstawiające:<br/>
	<xsl:value-of select="."/>
	<br/>
	<img src="{@source}" alt="zdj"/>
</xsl:template>

<xsl:template match="image[3]">
	<center>
	<br/>
	<xsl:value-of select="."/>
	<br/>
	<xsl:apply-templates select="@source"/>
	</center>
</xsl:template>

<xsl:template match="image[4]">
	Zdjęcie przedstawiające:<br/>
	<xsl:value-of select="."/>
	<br/>
	<img src="{@source}" alt="zdj" class="img"/>
</xsl:template>

<xsl:template match="@source">
	<img src="{.}" alt="" class="img"/>
</xsl:template>

</xsl:stylesheet>