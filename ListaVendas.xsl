<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:gv="http://xml.dei.isep.ipp.pt/schema/GestaoVendas">
	<xsl:output method="html" />


	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html>
			<head>
				<title>Gestao de Vendas</title>
				<meta charset="utf-8"/>
				<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<link href="css/bootstrap.min.css" rel="stylesheet"></link>
				<link href="css/style.css" rel="stylesheet"></link>
			</head>

			<body>
				<nav class="navbar navbar-inverse navbar-fixed-top " role="navigation">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							 <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-barcode"></span> Vendas</a>
						</div>
						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="ListaClientes.xml"><span class="glyphicon glyphicon-user"></span> Clientes </a></li>
								<li><a href="ListaPecas.xml"><span class="glyphicon glyphicon-wrench"></span> Peças </a></li>		
								<li><a href="Relatorio.xml"><span class="glyphicon glyphicon-book"></span> Relatório </a></li>	
							</ul>
						</div>
					</div>
				</nav>


				<div class="container">
					<br/><br/><br/><br/>
					<xsl:apply-templates select="//gv:venda">
						<xsl:sort select="gv:data" data-type="text" order="ascending"/>
					</xsl:apply-templates>

				</div>

				<script src="js/jquery-2.1.1.min.js"></script>
				<script src="js/bootstrap.min.js"></script>
				<script src="js/docs.min.js"></script>
				<script type="text/javascript">
					$(document).ready(function() {
					$( ".panel-heading" ).each(function( index ) {
					if(!$(this).hasClass('panel-collapsed')){
					$(this).parents('.panel').find('.panel-body').slideUp();
					$(this).addClass('panel-collapsed');
					}
					});
					});

					$(document).on('click', '.panel-heading', function(e){
					var $this = $(this);
					if(!$this.hasClass('panel-collapsed')) {
					$this.parents('.panel').find('.panel-body').slideUp();
					$this.addClass('panel-collapsed');

					} else {

					$this.parents('.panel').find('.panel-body').slideDown();
					$this.removeClass('panel-collapsed');
					}
					})
				</script>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="gv:venda">

		<xsl:variable name="id_venda" select="@id"/>
		<xsl:variable name="id_cliente" select="gv:cliente"/>



		<xsl:apply-templates select="//gv:detalhes_venda[@idVenda=$id_venda]">
			<xsl:with-param name="data_venda" select="gv:data"/>
			<xsl:with-param name="loja_venda" select="gv:loja"/>
			<xsl:with-param name="cliente_venda" select="gv:cliente"/>
			<xsl:with-param name="id_venda" select="$id_venda"/>
			<xsl:with-param name="id_cliente" select="$id_cliente"/>
		</xsl:apply-templates>

	</xsl:template>

	<!-- Detalhes dos clientes -->
	<xsl:template match="gv:detalhes_cliente">
		<a>
			<xsl:attribute name="href">ListaClientes.xml#id-cliente-<xsl:value-of select="@idCliente"/></xsl:attribute>
			<xsl:value-of select="gv:nome"/>
		</a>
	</xsl:template>

	<!-- Faz a relacao entre a peca vendida e a peca no stock -->
	<xsl:template match="gv:detalhes_venda">

		<xsl:param name="data_venda"/>
		<xsl:param name="loja_venda"/>
		<xsl:param name="cliente_venda"/>
		<xsl:param name="id_venda"/>
		<xsl:param name="id_cliente"/>

		<xsl:variable name="id_peca" select="gv:peca/@id"/>	
		<xsl:apply-templates select="//gv:detalhes_peca[@idPeca=$id_peca]">

			<xsl:with-param name="data_venda" select="$data_venda"/>
			<xsl:with-param name="loja_venda" select="$loja_venda"/>
			<xsl:with-param name="cliente_venda" select="$cliente_venda"/>
			<xsl:with-param name="id_venda" select="$id_venda"/>
			<xsl:with-param name="id_cliente" select="$id_cliente"/>

		</xsl:apply-templates>

	</xsl:template>

	<!-- Os detalhes das pecas -->
	<xsl:template match="gv:detalhes_peca">

		<xsl:param name="data_venda"/>
		<xsl:param name="loja_venda"/>
		<xsl:param name="cliente_venda"/>
		<xsl:param name="id_venda"/>
		<xsl:param name="id_cliente"/>

		<div class="row">
			<div class="col-xs-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<xsl:call-template name="header-venda">
							<xsl:with-param name="data" select="$data_venda"/>
							<xsl:with-param name="preco" select="gv:preco"/>
						</xsl:call-template>
					</div>

					<div class="panel-body">
						<row>
							<div class="col-md-8">
								<xsl:call-template name="tabela-venda">
									<xsl:with-param name="loja_venda" select="$loja_venda"/>
									<xsl:with-param name="tipo" select="gv:tipo"/>
									<xsl:with-param name="nome" select="gv:nome"/>
									<xsl:with-param name="marca" select="gv:marca"/>
									<xsl:with-param name="descricao" select="gv:descricao"/>
									<xsl:with-param name="cliente" select="$id_cliente"/>
								</xsl:call-template>

							</div>

							<div class="col-md-4">

								<xsl:call-template name="tratar-imagem">
									<xsl:with-param name="imagem" select="gv:imagem"/>
								</xsl:call-template>

							</div>

						</row>

					</div>
				</div>
			</div>
		</div>


	</xsl:template>

	<xsl:template name="tabela-venda">
		<xsl:param name="loja_venda"/>
		<xsl:param name="tipo"/>
		<xsl:param name="nome"/>
		<xsl:param name="marca"/>
		<xsl:param name="descricao"/>
		<xsl:param name="cliente"/>

		<table class="table">
			<tr>
				<td><strong>Cliente</strong></td>
				<td>
					<xsl:apply-templates select="//gv:detalhes_cliente[@idCliente=$cliente]"/></td> 
				</tr>
				<tr>
					<td><strong>Loja</strong></td>
					<td><xsl:value-of select="$loja_venda"/></td> 
				</tr>
				<tr>

					<td><strong>Tipo</strong></td>
					<xsl:call-template name="tratar-label-tipo">
						<xsl:with-param name="tipo" select="$tipo"/>
					</xsl:call-template>


				</tr>
				<tr>
					<td><strong>Peca</strong></td>
					<td><xsl:value-of select="$nome"/></td> 
				</tr>
				<tr>
					<td><strong>Marca</strong></td>
					<td><xsl:value-of select="$marca"/></td> 
				</tr>
				<tr>
					<td><strong>Descricao</strong></td>
					<td><xsl:value-of select="$descricao"/></td> 
				</tr>
			</table>
		</xsl:template>

		<!-- Atribui uma cor por tipo de peca -->
		<xsl:template name="tratar-label-tipo">
			<xsl:param name="tipo"/>

			<xsl:choose>
				<xsl:when test="contains($tipo, 'Travagem')">
					<td><span class="label label-danger"><xsl:value-of select="$tipo"/></span></td> 
				</xsl:when>
				<xsl:when test="contains($tipo, 'Transmissao')">
					<td><span class="label label-primary"><xsl:value-of select="$tipo"/></span></td> 
				</xsl:when>
				<xsl:when test="contains($tipo, 'Suspensao')">
					<td><span class="label label-success"><xsl:value-of select="$tipo"/></span></td> 
				</xsl:when>
				<xsl:when test="contains($tipo, 'Filtracao')">
					<td><span class="label label-warning"><xsl:value-of select="$tipo"/></span></td> 
				</xsl:when>
				<xsl:when test="contains($tipo, 'Escape')">
					<td><span class="label label-info"><xsl:value-of select="$tipo"/></span></td> 
				</xsl:when>
				<xsl:otherwise>
					<td><span class="label label-default"><xsl:value-of select="$tipo"/></span></td> 
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>

		<!-- header de cada venda com data e preco -->
		<xsl:template name="header-venda">
			<xsl:param name="data"/>
			<xsl:param name="preco"/>

			<h3 class="panel-title"><strong><xsl:value-of select="$data"/></strong>
			<span class="badge pull-right" style="font-size:12px"><xsl:value-of select="$preco"/>

			<span class="glyphicon glyphicon glyphicon-euro" style="font-size:10px"></span></span>
		</h3>
	</xsl:template>

	<xsl:template name="tratar-imagem">
		<xsl:param name="imagem"/>

		<xsl:choose>
			<xsl:when test="$imagem != ''" >
				<img width="300" class="img-circle">
					<xsl:attribute name="src">
						<xsl:value-of select="$imagem"/>
					</xsl:attribute>
				</img>
			</xsl:when>

			<xsl:otherwise>
				<img width="300" src="img/default.png" />			
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>

