<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/assignments">
        <html>
            
            <head>
                <link href='https://fonts.googleapis.com/css?family=Atkinson Hyperlegible' rel='stylesheet'/>
                <link href='https://fonts.googleapis.com/css?family=Courgette' rel='stylesheet'/>
                <link rel="stylesheet" href="CSS/index.css"/>
                <title>Assignments</title>
            </head>
            
            <body>
                <h2>Web Technologies - II Assignments &amp; Solutions</h2>
                <ul>
                    <xsl:for-each select="question">
                        <li>
                            <div class="description">
                                <div class="card">
                                    <div class="container">
                                        <h4><b>Question. <xsl:value-of select="substring(./@no,2)"></xsl:value-of> </b></h4>
                                        <p>
                                            <xsl:value-of select="."/>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <xsl:attribute name="class">
                                    <xsl:if test="./@link = 'noLink'">
                                        <xsl:text>view</xsl:text>
                                    </xsl:if>
                                    <xsl:if test="./@link != 'noLink'">
                                        <xsl:text>view redirect-link</xsl:text>
                                    </xsl:if>
                                </xsl:attribute>
                                <div class="flip-card">
                                    <div class="flip-card-inner">
                                        <div class="flip-card-front">
                                            <img src="Images/{./@image}" alt="Preview" style="width:300px;height:var(--rowWidth);"/>
                                        </div>
                                        <div class="flip-card-back">
                                            <xsl:if test="@link!='noLink'">
                                                <xsl:attribute name="onclick">window.location =  "<xsl:value-of select="./@link"></xsl:value-of>"
                                                </xsl:attribute>
                                            </xsl:if>
                                            <h1>
                                                <xsl:if test="@link!='noLink'">
                                                    View Page
                                                </xsl:if>
                                                <xsl:if test="@link='noLink'">
                                                    No Page Exists
                                                </xsl:if>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
