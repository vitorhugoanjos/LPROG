<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0" xmlns:r="http://www.dei.isep.ipp.pt/lprog">


	<xsl:output method="html" />

	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html>
			<head>
				<title><xsl:value-of select="//r:páginaRosto/r:tema"/></title>
				<meta charset="utf-8"/>
				<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<link href="css/bootstrap.min.css" rel="stylesheet"></link>
				<link href="css/style.css" rel="stylesheet"></link>
			</head>

			<body>
				<nav class="navbar navbar-inverse navbar-fixed-top " role="navigation">
					<div class="container-fluid">
						
						<div class="navbar-header">
							<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-book"></span> Relatório </a>
						</div>
						
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">							

							<ul class="nav navbar-nav navbar-right">
								<li><a href="ListaPecas.xml"><span class="glyphicon glyphicon-wrench"></span> Peças </a></li>
								<li><a href="ListaClientes.xml"><span class="glyphicon glyphicon-wrench"></span> Clientes </a></li>
								<li><a href="ListaVendas.xml"><span class="glyphicon glyphicon-barcode"></span> Vendas </a></li>				
							</ul>
						</div>
					</div>
				</nav>

				<div class="container">
					<hr/><hr/>

					<xsl:apply-templates select="//r:páginaRosto"/>

					<xsl:call-template name="indice"/>


				</div>

				<script src="js/jquery-2.1.1.min.js"></script>
				<script src="js/bootstrap.min.js"></script>
				<script src="js/docs.min.js"></script>

			</body>

		</html>

	</xsl:template>

	<xsl:template match="r:páginaRosto">
		<div class="row well">
			<img class="img-responsive center-block" width="700">

				<xsl:attribute name="src">
					<xsl:value-of select="r:logotipoDEI"/>
				</xsl:attribute>
			</img>
			

			<h1 class="text-center"><xsl:value-of select="r:tema"/><br/><small><xsl:value-of select="../@id"/></small></h1>
			
			<hr/>
			<hr/>
			<hr/>

			<address>
				<strong><xsl:value-of select="r:disciplina/r:designação"/></strong><br/>		
				<xsl:value-of select="r:data"/><br/>
				<xsl:value-of select="r:turmaPL"/><br/>
			</address>
			
			<address>
				<strong><xsl:value-of select="r:profPL"/></strong><br/>
			</address>

			<xsl:apply-templates select="r:autor" mode="pagina_rosto"/>

		</div>
	</xsl:template>

	<xsl:template match="r:autor" mode="pagina_rosto">
		<address>
			<strong><xsl:value-of select="r:nome"/></strong><br/>
			<xsl:value-of select="r:número"/><br/>
			<a href="mailto:{r:mail}"><xsl:value-of select="r:mail"/></a><br/>
		</address>
	</xsl:template>

	<xsl:template name="indice">
		<div class="row well">
			<div class="page-header"><h1>Índice</h1></div>

			<ul class="pager">

				<xsl:for-each select="//*[@tituloSecção]">

					<xsl:if test="position() = last()"> <!-- se estiver nos anexos -->
						<xsl:variable name="ref" select="//r:referências"/>
						<li><a href="#{generate-id($ref)}">Referências</a></li> <!-- adiciono Referências que é o unico que não tem tituloSeccao-->						
						
					</xsl:if>
					
					<li><a href="#{generate-id(@tituloSecção)}"><xsl:value-of select="@tituloSecção"/></a></li>

					<xsl:for-each select="*[@tituloSecção]">
						<li><a href="#{generate-id(@tituloSecção)}"><xsl:value-of select="@tituloSecção"/></a></li>
					</xsl:for-each>

					

				</xsl:for-each>

			</ul>
		</div>

		

		<xsl:apply-templates select="//r:corpo"/>
	</xsl:template>


	<xsl:template match="r:corpo">		
		
		<xsl:apply-templates select="r:introdução" />	
		<xsl:apply-templates select="r:secções" />		
		<xsl:apply-templates select="r:conclusão" />	
		<xsl:apply-templates select="r:referências" />

	</xsl:template>

	<xsl:template match="r:introdução">

		<div class="row well" id="{generate-id(@tituloSecção)}">
			<div class="page-header"><h1><xsl:value-of select="@tituloSecção"/><small class="pull-right"><xsl:value-of select="@id"/></small></h1></div>
			<xsl:apply-templates select="r:bloco"/>
		</div>

	</xsl:template>

	<xsl:template match="r:secções">

		<xsl:for-each select="child::*">
			<xsl:apply-templates select="."/>
		</xsl:for-each>

	</xsl:template>

	<xsl:template match="r:análise">

		<div class="row well" id="{generate-id(@tituloSecção)}">
			<div class="page-header"><h1><xsl:value-of select="@tituloSecção"/><small class="pull-right"><xsl:value-of select="@id"/></small></h1></div>
			<xsl:apply-templates select="r:bloco"/>		
		</div>

	</xsl:template>

	<xsl:template match="r:linguagem">

		<div class="row well" id="{generate-id(@tituloSecção)}">
			<div class="page-header"><h1><xsl:value-of select="@tituloSecção"/><small class="pull-right"><xsl:value-of select="@id"/></small></h1></div>
			<xsl:apply-templates select="r:bloco"/>
		</div>

	</xsl:template>

	<xsl:template match="r:transformações">

		<div class="row well" id="{generate-id(@tituloSecção)}">
			<div class="page-header"><h1><xsl:value-of select="@tituloSecção"/><small class="pull-right"><xsl:value-of select="@id"/></small></h1></div>
			<xsl:apply-templates select="r:bloco"/>
		</div>

	</xsl:template>

	<xsl:template match="r:conclusão">
		<div class="row well" id="{generate-id(@tituloSecção)}">
			<div class="page-header"><h1><xsl:value-of select="@tituloSecção"/><small class="pull-right"><xsl:value-of select="@id"/></small></h1></div>
			<xsl:apply-templates select="r:bloco"/>
		</div>
	</xsl:template>

	<xsl:template match="r:referências">
		<div class="row well" id="{generate-id(current())}"> 
			<div class="page-header"><h1>Referências</h1></div>
			<h4>Referências Bibliográficas</h4><br/>
			<xsl:apply-templates select="r:refBibliográfica"/>
			<br/>
			<h4>Referências Web</h4><br/>
			<xsl:apply-templates select="r:refWeb"/>
		</div>
		<xsl:apply-templates select="//r:anexos"/>
	</xsl:template>

	<xsl:template match="r:refBibliográfica">
		<p>
			<xsl:apply-templates select="r:autor"/>
			<xsl:apply-templates select="r:título"/>
			<xsl:apply-templates select="r:dataPublicação"/>
		</p>
		<br/>
		
	</xsl:template>

	<xsl:template match="r:refWeb">
		<p>
			<xsl:apply-templates select="r:descrição"/>
			<xsl:text> [Consultado em: </xsl:text>
			<xsl:apply-templates select="r:consultadoEm"/>
			<xsl:text>].</xsl:text>
		</p>
		<p>
			<xsl:text>Disponível em: &lt;</xsl:text>
			<xsl:apply-templates select="r:URL"/>	
			<xsl:text>&gt;</xsl:text>
		</p>
		<br/>
	</xsl:template>

	<xsl:template match="r:autor">
		<xsl:value-of select="."/>

		<xsl:if test="position() &lt; last()">
			<xsl:text>, </xsl:text>
		</xsl:if>

		<xsl:if test="position() = last()">
			<xsl:text>. </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="r:título">
		<xsl:value-of select="."/>
		<xsl:text>; </xsl:text>
	</xsl:template>

	<xsl:template match="r:dataPublicação">
		<xsl:value-of select="."/>
		<xsl:text>.</xsl:text>
	</xsl:template>

	<xsl:template match="r:descrição">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="r:consultadoEm">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="r:URL">
		<a href="{.}"><xsl:value-of select="."/></a>
	</xsl:template>

	<xsl:template match="r:bloco">
		<hr/>
		<xsl:apply-templates select="r:paragráfo|r:listaItems|r:figura|r:codigo"/>
	</xsl:template>

	<xsl:template match="r:paragráfo">
		<p class="text-justify um_ponto_cinco_entre_linhas">
			<xsl:apply-templates select="text()|r:bold|r:sublinhado|r:itálico|r:citação"/>
		</p>
	</xsl:template>

	<xsl:template match="r:listaItems">
		<ul>
			<xsl:apply-templates select="r:item"/>
		</ul>
	</xsl:template>

	<xsl:template match="r:item">
		
		<xsl:choose>
			<xsl:when test="@label">
				<li>
					<xsl:value-of select="@label"/>
				</li>

				<ul>
					<li><xsl:value-of select="."/></li>
				</ul>


			</xsl:when>

			<xsl:otherwise>
				<li>
					<xsl:value-of select="."/>
				</li>
			</xsl:otherwise>

		</xsl:choose>

	</xsl:template>

	<xsl:template match="r:item[contains(@label,'autor')]">
		<hr/>
		<blockquote class="blockquote-reverse">
			<p><xsl:value-of select="."/></p>
			<footer><xsl:value-of select="substring(@label,7)"/></footer>
		</blockquote>
	</xsl:template>

	<xsl:template match="r:figura">
		<img class="img-responsive">

			<xsl:attribute name="src">
				<xsl:value-of select="@src"/>
			</xsl:attribute>

			<xsl:attribute name="alt">
				<xsl:value-of select="@descrição"/>
			</xsl:attribute>

		</img>
	</xsl:template>

	<xsl:template match="r:codigo">
		<xsl:choose>
			<xsl:when test="count(r:linha) &gt; 1">
				<pre class="text-danger">
					<xsl:apply-templates select="r:linha" mode="multiplas_linhas"/>
				</pre>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="r:linha"/>
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>

	<xsl:template match="r:linha" mode="multiplas_linhas">
		<xsl:value-of select="."/>
	</xsl:template>

	<xsl:template match="r:linha">
		<p>
			<code class="bg-warning"><xsl:value-of select="."/></code>
		</p>
	</xsl:template>
	
	<xsl:template match="r:citação"> 
		<xsl:text> (</xsl:text>
		<xsl:value-of select="//r:refWeb[@idRef=current()]/r:descrição"/>
		<xsl:text>, </xsl:text>
		<xsl:value-of select="//r:refWeb[@idRef=current()]/r:consultadoEm"/>
		<xsl:text>)</xsl:text>
	</xsl:template>

	<xsl:template match="r:bold">
		<strong><xsl:value-of select="."/></strong>
	</xsl:template>

	<xsl:template match="r:itálico">
		<em><xsl:value-of select="."/></em>
	</xsl:template>

	<xsl:template match="r:sublinhado">
		<sublinhado><xsl:value-of select="."/></sublinhado>
	</xsl:template>

	<xsl:template match="r:anexos">
		<div class="row well" id="{generate-id(@tituloSecção)}">
			<div class="page-header"><h1><xsl:value-of select="@tituloSecção"/><small class="pull-right"><xsl:value-of select="@id"/></small></h1></div>
			<xsl:apply-templates select="r:bloco"/>
		</div>
	</xsl:template>

	<xsl:template match="*"></xsl:template>


</xsl:stylesheet>