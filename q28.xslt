<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <body>
                <form action="checkAnswer.jsp">
                    <xsl:apply-templates />
                </form>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="question">
        <p>
            <xsl:value-of select="@no"/>. <xsl:value-of select="text"/>
        </p>
        <xsl:apply-templates select="optionA | optionB | optionC | optionD"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="optionA | optionB | optionC | optionD">
        <input type="radio" name="{../@no}" value="{.}"/>
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>
</xsl:stylesheet>
