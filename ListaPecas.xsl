<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0" xmlns:gv="http://xml.dei.isep.ipp.pt/schema/GestaoVendas">


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
				<link href="css/font-awesome.min.css" rel="stylesheet"></link>
				<link href="css/style.css" rel="stylesheet"></link>
			</head>

			<body>
				
				<nav class="navbar navbar-inverse navbar-fixed-top " role="navigation">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-wrench"></span> Peças</a>
						</div>
						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav">
								<li id="a-a-z" class="menu-ordenacao active"><a href="#"><span class="glyphicon glyphicon-sort-by-alphabet"></span> Nome </a></li>
								<li id="a-z-a" class="menu-ordenacao"><a href="#"><span class="glyphicon glyphicon-sort-by-alphabet-alt"></span> Nome </a></li>
								<li id="a-marca-a-z" class="menu-ordenacao"><a href="#"><span class="glyphicon glyphicon-sort-by-alphabet"></span> Marca </a></li>
								<li id="a-marca-z-a" class="menu-ordenacao"><a href="#"><span class="glyphicon glyphicon-sort-by-alphabet-alt"></span> Marca </a></li>
								<li id="a-1-9" class="menu-ordenacao"><a href="#"><span class="glyphicon glyphicon-sort-by-order"></span> Preço </a></li>
								<li id="a-9-1" class="menu-ordenacao"><a href="#"><span class="glyphicon glyphicon-sort-by-order-alt"></span> Preço </a></li>				
							</ul>

							<ul class="nav navbar-nav navbar-right">
								<li><a href="ListaClientes.xml"><span class="glyphicon glyphicon-user"></span> Clientes </a></li>
								<li><a href="ListaVendas.xml"><span class="glyphicon glyphicon-barcode"></span> Vendas </a></li>	
								<li><a href="Relatorio.xml"><span class="glyphicon glyphicon-book"></span> Relatório </a></li>		
							</ul>
						</div>
					</div>
				</nav>



				<div class="container">
					<br/><br/><br/><br/>
					<xsl:apply-templates select="//gv:detalhes_peca">
						<xsl:sort select="gv:nome"/>
						<xsl:sort select="gv:preco" order="descending"/>
					</xsl:apply-templates>

					<xsl:call-template name="detalhes-peca-z-a"/>

					<xsl:call-template name="detalhes-peca-marca-a-z"/>

					<xsl:call-template name="detalhes-peca-marca-z-a"/>

					<xsl:call-template name="detalhes-peca-1-9"/>

					<xsl:call-template name="detalhes-peca-9-1"/>



				</div><!-- /container -->

				<script src="js/jquery-2.1.1.min.js"></script>
				<script src="js/bootstrap.min.js"></script>
				<script src="js/docs.min.js"></script>
				<script type="text/javascript">
					$(document).ready(function() {

					$( ".col-md-4.order_z_a,.col-md-4.order_1_9,.col-md-4.order_9_1,.col-md-4.order_marca_a_z,.col-md-4.order_marca_z_a" ).hide();

					$( ".table.tabela-detalhada" ).hide();

					var botoes_mais_detalhes = $('.mais-detalhes');

					botoes_mais_detalhes.click(function(){
					var id = $(this).attr('id').split('-')[1];
					var id_tabela = "#detalhada-" + id;
					var mais_detalhes = $(this);
					var tabela = $(id_tabela);

					tabela.slideToggle(50, function() {
					
					if(tabela.is(':visible'))
					{
					mais_detalhes.html('Menos detalhes <span class="glyphicon glyphicon-info-sign"></span> ');
					}
					else
					{
					mais_detalhes.html('Mais detalhes <span class="glyphicon glyphicon-info-sign"></span> ');
					}
					})

					});

					$("#a-a-z").click(function() {
					$( ".col-md-4.order_z_a,.col-md-4.order_1_9,.col-md-4.order_9_1,.col-md-4.order_marca_a_z,.col-md-4.order_marca_z_a" ).fadeOut();
					$( ".col-md-4.order_a_z" ).fadeIn(500);
					$(".menu-ordenacao").removeClass('active');
					$(this).addClass('active');
					});

					$("#a-z-a").click(function() {
					$( ".col-md-4.order_a_z,.col-md-4.order_1_9,.col-md-4.order_9_1,.col-md-4.order_marca_a_z,.col-md-4.order_marca_z_a" ).fadeOut();
					$( ".col-md-4.order_z_a" ).fadeIn(500);
					$(".menu-ordenacao").removeClass('active');
					$(this).addClass('active');
					});

					$("#a-1-9").click(function() {
					$( ".col-md-4.order_a_z,.col-md-4.order_z_a,.col-md-4.order_9_1,.col-md-4.order_marca_a_z,.col-md-4.order_marca_z_a" ).fadeOut();
					$( ".col-md-4.order_1_9" ).fadeIn(500);
					$(".menu-ordenacao").removeClass('active');
					$(this).addClass('active');
					});

					$("#a-9-1").click(function() {
					$( ".col-md-4.order_a_z,.col-md-4.order_1_9,.col-md-4.order_z_a,.col-md-4.order_marca_a_z,.col-md-4.order_marca_z_a" ).fadeOut();
					$( ".col-md-4.order_9_1" ).fadeIn(500);
					$(".menu-ordenacao").removeClass('active');
					$(this).addClass('active');
					});

					$("#a-marca-a-z").click(function() {
					$( ".col-md-4.order_a_z,.col-md-4.order_1_9,.col-md-4.order_9_1,.col-md-4.order_z_a,.col-md-4.order_marca_z_a" ).fadeOut();
					$( ".col-md-4.order_marca_a_z" ).fadeIn(500);
					$(".menu-ordenacao").removeClass('active');
					$(this).addClass('active');
					});

					$("#a-marca-z-a").click(function() {
					$( ".col-md-4.order_a_z,.col-md-4.order_1_9,.col-md-4.order_9_1,.col-md-4.order_z_a,.col-md-4.order_marca_a_z" ).fadeOut();
					$( ".col-md-4.order_marca_z_a" ).fadeIn(500);
					$(".menu-ordenacao").removeClass('active');
					$(this).addClass('active');
					});

					});
				</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="gv:detalhes_peca">

		<xsl:call-template name="main-logic">
			<xsl:with-param name="order" select="'order_a_z'"/>
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="detalhes-peca-z-a">

		<xsl:for-each select="//gv:detalhes_peca">
			<xsl:sort select="gv:nome" order="descending"/>
			<xsl:sort select="gv:preco" order="descending"/>
			<xsl:call-template name="main-logic">
				<xsl:with-param name="order" select="'order_z_a'"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="detalhes-peca-marca-a-z">

		<xsl:for-each select="//gv:detalhes_peca">
			<xsl:sort select="gv:marca" order="ascending"/>
			<xsl:sort select="gv:preco" order="descending"/>
			<xsl:call-template name="main-logic">
				<xsl:with-param name="order" select="'order_marca_a_z'"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="detalhes-peca-marca-z-a">

		<xsl:for-each select="//gv:detalhes_peca">
			<xsl:sort select="gv:marca" order="descending"/>
			<xsl:sort select="gv:preco" order="descending"/>
			<xsl:call-template name="main-logic">
				<xsl:with-param name="order" select="'order_marca_z_a'"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="detalhes-peca-1-9">

		<xsl:for-each select="//gv:detalhes_peca">
			<xsl:sort select="gv:preco" data-type="number" order="ascending"/>
			<xsl:sort select="gv:nome" order="ascending"/>
			<xsl:call-template name="main-logic">
				<xsl:with-param name="order" select="'order_1_9'"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="detalhes-peca-9-1">

		<xsl:for-each select="//gv:detalhes_peca">
			<xsl:sort select="gv:preco" data-type="number" order="descending"/>
			<xsl:sort select="gv:nome" order="ascending"/>
			<xsl:call-template name="main-logic">
				<xsl:with-param name="order" select="'order_9_1'"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="main-logic">
		<xsl:param name="order"/>
		<div class="col-md-4 {$order}">
			<br/>
			<div class="col-item">

				<div class="photo">
					<xsl:call-template name="tratar-imagem">
						<xsl:with-param name="imagem" select="gv:imagem"/>
					</xsl:call-template>	
				</div> <!-- /photo -->

				<div class="info">

					<div class="row">

						<div class="price col-md-6">

							<xsl:call-template name="cabecalho-peca">
								<xsl:with-param name="nome" select="gv:nome"/>
								<xsl:with-param name="preco" select="gv:preco"/>
							</xsl:call-template>

						</div><!-- /price col-md-6 -->

						<div class="rating hidden-sm col-md-6">

							<xsl:call-template name="atribuir_estrelas_a_peca">
								<xsl:with-param name="idPeca" select="@idPeca"/>
							</xsl:call-template>

						</div> <!-- /rating hidden-sm col-md-6" -->
					</div> <!-- /row -->


					<div class="separator clear-left">
						<p class="btn-details mais-detalhes" id="detalhes-{generate-id(@idPeca)}_{$order}">
							Mais detalhes <span class="glyphicon glyphicon-info-sign"></span> 
						</p>
					</div>
					<xsl:call-template name="detalhes-peca">
						<xsl:with-param name="id" select="@idPeca"/>
						<xsl:with-param name="order" select="$order"/>
					</xsl:call-template>

					<div class="clearfix">
					</div> <!-- /clearfix -->

				</div> <!-- /info -->
			</div> <!-- /col-item -->
		</div><!-- /col-md-4 -->
	</xsl:template>

	<!-- Atribui o rating a peca (com estrelas) -->
	<xsl:template name="atribuir_estrelas_a_peca">

		<xsl:param name="idPeca"/>

		<xsl:variable name="numero_pecas_vendidas" select="count(//gv:detalhes_venda/gv:peca[@id=$idPeca])" />

		<!-- atribuir estrelas consoante o numero de pecas vendidas-->
		<xsl:choose>
			<xsl:when test="$numero_pecas_vendidas=0">
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
			</xsl:when>

			<xsl:when test="$numero_pecas_vendidas=1">
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
			</xsl:when>

			<xsl:when test="$numero_pecas_vendidas=2">
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
			</xsl:when>

			<xsl:when test="$numero_pecas_vendidas=3">
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star"/>
				<span class="glyphicon glyphicon-star"/>
			</xsl:when>

			<xsl:when test="$numero_pecas_vendidas=4">
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star"/>
			</xsl:when>

			<xsl:otherwise>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
				<span class="glyphicon glyphicon-star blue"/>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

	<xsl:template name="tratar-imagem">
		<xsl:param name="imagem"/>

		<xsl:choose>
			<xsl:when test="$imagem != ''" >
				<img class="img-circle">
					<xsl:attribute name="src">
						<xsl:value-of select="$imagem"/>
					</xsl:attribute>
				</img>
			</xsl:when>

			<xsl:otherwise>
				<img src="img/default.png"/>			
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="cabecalho-peca">
		<h5>
			<xsl:value-of select="gv:nome"/>
		</h5>

		<h5 class="price-text-color">
			€<xsl:value-of select="gv:preco"/>
		</h5>

	</xsl:template>

	<xsl:template name="detalhes-peca">
		<xsl:param name="id"/>
		<xsl:param name="order"/>
		<div class="separator clear-left">

			<table class="table tabela-detalhada" id="detalhada-{generate-id($id)}_{$order}">
				<tr>
					<td><strong>Tipo</strong></td>
					<xsl:call-template name="tratar-label-tipo">
						<xsl:with-param name="tipo" select="//gv:detalhes_peca[@idPeca=$id]/gv:tipo"/>
					</xsl:call-template>
				</tr>
				<tr>
					<td><strong>Marca</strong></td>
					<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:marca"/></td> 
				</tr>
				<tr>
					<td><strong>Modelo</strong></td>
					<xsl:call-template name="tratar-modelo">
						<xsl:with-param name="id" select="$id"/>
					</xsl:call-template>					
				</tr>			
				<tr>
					<td><strong>Pecas vendidas</strong></td>
					<td><xsl:value-of select="count(//gv:detalhes_venda/gv:peca[@id=$id])"/></td> 
				</tr>
				<tr>
					<td><strong>Dinheiro gerado</strong></td>
					<td><xsl:value-of select="format-number(count(//gv:detalhes_venda/gv:peca[@id=$id])*//gv:detalhes_peca[@idPeca=$id]/gv:preco,'#,##0.00')"/> €</td> 
				</tr>
				<tr>
					<td><strong>Descrição</strong></td>
					<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:descricao"/></td>

				</tr>
				<tr>
					<td><a href="#"  data-toggle="modal" data-target="#{generate-id($id)}_{$order}">Ver disponibilidade <span class="glyphicon glyphicon-zoom-in"></span></a></td>
					<td></td>

				</tr>
			</table>

		</div> <!-- /separator clear-left -->

		<xsl:call-template name="ver-disponibilidade">
			<xsl:with-param name="id" select="$id"/>
			<xsl:with-param name="order" select="$order"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="tratar-modelo">
		<xsl:param name="id"/>
		<xsl:variable name="modelo" select="//gv:detalhes_peca[@idPeca=$id]/gv:modelo"/>

		<xsl:choose>
			<xsl:when test="$modelo != ''">
				<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:modelo"/></td>
			</xsl:when>
			<xsl:otherwise>
				<td class="text-danger">Desconhecido</td>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ver-disponibilidade">
		<xsl:param name="id"/>
		<xsl:param name="order"/>

		<div class="modal fade" id="{generate-id($id)}_{$order}">
			<div class="modal-dialog">
				<div class="modal-content" >
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						<h4 class="modal-title">Disponibilidade de <xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:nome"/></h4>
					</div>
					<div class="modal-body"> 
						<div class="row">

							<div class="col-md-12">
								<table class="table table-hover">
									<xsl:for-each select="//gv:detalhes_peca[@idPeca=$id]/gv:stocks/gv:stock">
										<tr>
											<td><strong><xsl:value-of select="@loja"/></strong></td>
											<xsl:choose>
												<xsl:when test=". &gt; 0">
													<td><xsl:value-of select="."/></td> 
												</xsl:when>

												<xsl:otherwise>
													<td><span class="label label-danger">indisponivel</span></td> 
												</xsl:otherwise>
											</xsl:choose>
										</tr>
									</xsl:for-each>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->


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

</xsl:stylesheet>