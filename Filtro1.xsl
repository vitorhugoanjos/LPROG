<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gv="http://xml.dei.isep.ipp.pt/schema/GestaoVendas">

    <!-- XML de clientes com 5 ou mais anos de afiliacao, que tenham gasto mais que 10 euros em compras, e as compras dos respetivos clientes -->
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">

        <clientes>
            <xsl:apply-templates select="//gv:detalhes_cliente"/>
        </clientes>

    </xsl:template>


    <xsl:template match="gv:detalhes_cliente">



        <xsl:if test="gv:anos_afiliacao &gt;= 5">

           <xsl:variable name="idCliente" select="@idCliente"/>

           <xsl:variable name="total_gasto" >
            <xsl:call-template name="soma-recursiva-montante-gasto">
                <xsl:with-param name="nos" select="//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$idCliente]/@id]" />
            </xsl:call-template>    
        </xsl:variable>

        <xsl:if test="$total_gasto &gt; 10">
            <cliente idCliente="{$idCliente}">

                <nome>   
                    <xsl:value-of select="gv:nome"/>
                </nome>

                <anos_afiliado>
                    <xsl:value-of select="gv:anos_afiliacao"/>
                </anos_afiliado>

                <registado_em>  
                    <xsl:value-of select="gv:data_registo"/>
                </registado_em>

                <compras_efetuadas>
                    <xsl:call-template name="contagem-compras-efetuadas">
                        <xsl:with-param name="cliente" select="@idCliente"/>
                    </xsl:call-template>
                </compras_efetuadas>

                <montanto_total_gasto><xsl:value-of select="$total_gasto"/></montanto_total_gasto>

                <compras>
                   <xsl:apply-templates select="//gv:venda[gv:cliente=$idCliente]">
                    <xsl:sort select="gv:data" order="descending"/>
                </xsl:apply-templates>
            </compras>

        </cliente>
    </xsl:if>
</xsl:if>

</xsl:template>

<xsl:template match="gv:venda" >

    <xsl:variable name="id_venda" select="@id"/>

    <compra id="{$id_venda}" data="{gv:data}" loja="{gv:loja}">
        <xsl:call-template name="listar_pecas">
            <xsl:with-param name="id_peca" select="//gv:detalhes_venda[@idVenda=$id_venda]/gv:peca/@id"/>
        </xsl:call-template>
    </compra>



</xsl:template>

<xsl:template name="contagem-compras-efetuadas">
    <xsl:param name="cliente"/>
    <xsl:value-of select="count(//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$cliente]/@id])"/>
</xsl:template>

<xsl:template name="soma-recursiva-montante-gasto">
    <xsl:param name="nos"/>
    <xsl:param name="total" select="0"/>

    <xsl:variable name="atual" select="$nos[1]" />
    <xsl:choose>
        <xsl:when test="$atual">                
            <xsl:variable name="peca" select="//gv:detalhes_peca[@idPeca=$atual/gv:peca/@id]"/>
            <xsl:call-template name="soma-recursiva-montante-gasto">

                <xsl:with-param name="nos" select="$nos[position() &gt; 1]"/>
                <xsl:with-param name="total" select="$total + $peca/gv:preco"/>

            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="$total"/></xsl:otherwise>
    </xsl:choose>

</xsl:template>

<xsl:template name="listar_pecas">
    <xsl:param name="id_peca"/>
     <xsl:variable name="peca" select="//gv:detalhes_peca[@idPeca=$id_peca]"/>

    <peca idPeca="{$id_peca}">
        <nome><xsl:value-of select="$peca/gv:nome"/></nome>
        <tipo><xsl:value-of select="$peca/gv:tipo"/></tipo>
        <marca><xsl:value-of select="$peca/gv:marca"/></marca>
        <preco><xsl:value-of select="$peca/gv:preco"/></preco>
    </peca>

</xsl:template>


</xsl:stylesheet>