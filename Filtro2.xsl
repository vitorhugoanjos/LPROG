<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gv="http://xml.dei.isep.ipp.pt/schema/GestaoVendas">

    <!-- XML de peças que foram compradas -->
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">

        <pecas>
            <xsl:apply-templates select="//gv:detalhes_peca">
                <xsl:sort select="gv:nome" order="ascending"/>
            </xsl:apply-templates>
        </pecas>

    </xsl:template>


    <xsl:template match="gv:detalhes_peca">

        <xsl:variable name="idPeca" select="@idPeca"/>
        <xsl:variable name="numero_pecas_vendidas" select="count(//gv:detalhes_venda/gv:peca[@id=$idPeca])"/>

        <xsl:if test="$numero_pecas_vendidas &gt; 0">
            <peca>

                <nome><xsl:value-of select="gv:nome"/></nome>
                <tipo><xsl:value-of select="gv:tipo"/></tipo>
                <marca><xsl:value-of select="gv:marca"/></marca>

                <xsl:if test="gv:modelo != ''">
                    <modelo><xsl:value-of select="gv:modelo"/></modelo>
                </xsl:if>

                <preco><xsl:value-of select="gv:preco"/></preco>
                <descricao><xsl:value-of select="gv:descricao"/></descricao>

                <xsl:if test="gv:imagem = ''">
                    <imagem><xsl:value-of select="'img/default.png'"/></imagem>
                </xsl:if>

                <stocks>
                    <xsl:apply-templates select="gv:stocks/gv:stock" />
                </stocks>

                <clientes_compraram>
                    <xsl:apply-templates select="//gv:detalhes_cliente">
                        <xsl:sort select="gv:nome" order="ascending"/>
                        <xsl:with-param name="idPeca" select="$idPeca"/>
                    </xsl:apply-templates>
                </clientes_compraram>

            </peca>

        </xsl:if>

    </xsl:template>

    <xsl:template match="gv:detalhes_cliente">
        <xsl:param name="idPeca"/>
        
        <xsl:if test="current()[@idCliente=//gv:venda[@id=//gv:detalhes_venda[gv:peca[@id=$idPeca]]/@idVenda]/gv:cliente]">

            <xsl:variable name="id" select="@idCliente"/>
            <cliente>
                <xsl:attribute name="idCliente">
                    <xsl:value-of select="@idCliente"/>
                </xsl:attribute>

                <nome><xsl:value-of select="gv:nome"/></nome>
                <idade><xsl:value-of select="gv:idade"/></idade>
                <anos_afiliacao><xsl:value-of select="gv:anos_afiliacao"/></anos_afiliacao>
                <data_registo><xsl:value-of select="gv:data_registo"/></data_registo>
                <sexo><xsl:value-of select="gv:sexo"/></sexo>
                <quantidade_comprada><xsl:value-of select="count(//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$id]/@id][gv:peca[@id=$idPeca]])"/></quantidade_comprada>
            </cliente>
        </xsl:if>        

    </xsl:template>

    <xsl:template match="gv:stock">
        <stock>           
            <xsl:attribute name="loja">
                <xsl:value-of select="@loja"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </stock>
    </xsl:template>  

</xsl:stylesheet>