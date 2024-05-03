<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:output omit-xml-declaration="yes" indent="yes"/>
<xsl:strip-space elements="*"/>


<xsl:template match="/anime">
	<xsl:element name="manga">
		<xsl:element name="chinska_bajka">
			<xsl:apply-templates select="co/nazwa_anime[1]"/>
		</xsl:element>
		<xsl:element name="Linki">
			<xsl:apply-templates select="links"/>
		</xsl:element>
		<xsl:element name="Your_Name">
			<xsl:apply-templates select="media"/>
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="nazwa_anime[1]">
	<xsl:element name="{nazwa}">
		Jakaś wartość
	</xsl:element>
	<xsl:element name="o_bajce">
		<xsl:value-of select="opis/tekst"/>
	</xsl:element>
</xsl:template>

<xsl:template match="links">
	<xsl:element name="url">
		<xsl:element name="{name(link/@source)}">
			<xsl:value-of select="link"/>
		</xsl:element>
		<xsl:element name="strona">
			<xsl:attribute name="source">
			<xsl:value-of select="link/@source"/>
			</xsl:attribute>
			Link
		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="media">
	<xsl:copy>
		<xsl:copy-of select="image"/>
	</xsl:copy>
</xsl:template>

</xsl:stylesheet>