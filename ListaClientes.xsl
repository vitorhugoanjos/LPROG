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
				<link href="css/style.css" rel="stylesheet"></link>
			</head>

			<body>
				<nav class="navbar navbar-inverse navbar-fixed-top " role="navigation">
					<div class="container-fluid">
						
						<div class="navbar-header">
							<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-user"></span> Clientes</a>
						</div>
						
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">							

							<ul class="nav navbar-nav navbar-right">
								<li><a href="ListaPecas.xml"><span class="glyphicon glyphicon-wrench"></span> Peças </a></li>
								<li><a href="ListaVendas.xml"><span class="glyphicon glyphicon-barcode"></span> Vendas </a></li>		
								<li><a href="Relatorio.xml"><span class="glyphicon glyphicon-book"></span> Relatório </a></li>		
							</ul>
						</div>
					</div>
				</nav>

				<div class="container">
					<br />	<br /><br />	<br />

					<xsl:apply-templates select="//gv:detalhes_cliente">
						<xsl:sort select="gv:nome"/>
						<xsl:sort select="gv:anos_afiliacao" order="descending"/>
					</xsl:apply-templates>

					<xsl:for-each select="//gv:detalhes_cliente">
						<xsl:call-template name="modal-vendas">
							<xsl:with-param name="idCliente" select="@idCliente"/>
						</xsl:call-template>
					</xsl:for-each>
				</div>

				<script src="js/jquery-2.1.1.min.js"></script>
				<script src="js/bootstrap.min.js"></script>
				<script src="js/docs.min.js"></script>
				<script type="text/javascript">
					$(document).ready(function() {

					$( ".table.tabela-compras" ).addClass('hidden');
					var panels = $('.user-infos');
					var panelsButton = $('.dropdown-user');
					panels.hide();

					//Click dropdown
					panelsButton.click(function() {
					//get data-for attribute
					var dataFor = $(this).attr('data-for');
					var idFor = $(dataFor);

					//current button
					var currentButton = $(this);
					idFor.slideToggle(400, function() {
					//Completed slidetoggle
					if(idFor.is(':visible'))
					{
					currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
					}
					else
					{
					currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
					}
					})
					});


					$('[data-toggle="tooltip"]').tooltip();

					$('button').click(function(e) {
					e.preventDefault();

					});
					var id = $(location).attr('href');
					if(id.indexOf('#id-cliente-') != -1){
					var procuro = '.id-cliente-' + id.split('#id-cliente-')[1];
					$( ".dropdown-user" ).each(function( index ) {
					var dataFor = $(this).attr('data-for');
					var idFor = $(dataFor);
					if(dataFor==procuro){
					//current button
					var currentButton = $(this);
					idFor.slideToggle(400, function() {
					//Completed slidetoggle
					if(idFor.is(':visible'))
					{
					currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
					}
					else
					{
					currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
					}
					})

					}
					})
					}
					});

					$(document).on('click', 'a', function(e){
					var $this = $(this);
					if($(this).hasClass('link-compras')){
					e.preventDefault(); 

					if($(this).next().hasClass('hidden')) {
					$(this).next().slideDown();
					$(this).next().removeClass('hidden');
					$(this).html('Esconder compras <span class="glyphicon glyphicon-chevron-up"/>');

					}else
					{
					$(this).next().slideUp();
					$(this).next().addClass('hidden');
					$(this).html('Ver compras <span class="glyphicon glyphicon-chevron-down"/>');	
					}
					}
					
					});

					/*$("tr").not(':first')
					.hover(function () {


					var currentId = $(this).attr('id');
					$( "tbody.peca-info" ).each(function( index ) {
					if ($(this).attr('id')==currentId){
					if($(this).hasClass('hidden')){					
					$(this).removeClass('hidden');
					}
					}
					});
					}).mouseleave(function() {
					var currentId = $(this).attr('id');
					$( "tbody.peca-info" ).each(function( index ) {
					if ($(this).attr('id')==currentId){
					if(!$(this).hasClass('hidden')){
					$(this).addClass('hidden');
					}
					}
					});
					});*/

				</script>
			</body>

		</html>

	</xsl:template>


	<!-- Detalhes dos clientes -->
	<xsl:template match="gv:detalhes_cliente">

		<div class="well col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xs-offset-2 col-sm-offset-2 col-md-offset-2 col-lg-offset-2">
			<xsl:attribute name="id">id-cliente-<xsl:value-of select="@idCliente"/></xsl:attribute>

			<xsl:call-template name="header-cliente-main">
				<xsl:with-param name="id" select="@idCliente"/>
				<xsl:with-param name="nome" select="gv:nome"/>
				<xsl:with-param name="anos_afiliacao" select="gv:anos_afiliacao"/>
				<xsl:with-param name="sexo" select="gv:sexo"/>
			</xsl:call-template>

			<div>
				<xsl:attribute name="class">row user-infos id-cliente-<xsl:value-of select="@idCliente"/></xsl:attribute>
				<div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3 class="panel-title">Informacao do cliente</h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class=" col-md-12 col-lg-12">

									<strong><xsl:value-of select="gv:nome"/></strong><br/>

									<table class="table table-user-information">
										<xsl:call-template name="tabela-user-information">
											<xsl:with-param name="nome" select="gv:nome"/>
											<xsl:with-param name="idade" select="gv:idade"/>
											<xsl:with-param name="anos_afiliacao" select="gv:anos_afiliacao"/>
											<xsl:with-param name="cliente" select="current()/@idCliente"/>
										</xsl:call-template>
									</table>

									<a class="pull-right link-compras">Ver compras <span class="glyphicon glyphicon-chevron-down"/></a>
									<table class="table tabela-compras table-hover" >
										<tbody>
											<tr>
												<th>Data</th>
												<th>Loja</th>
												<th>Peca</th>
												<th>Montante</th>
											</tr>

											<xsl:variable name="idCliente" select="current()/@idCliente"/>

											<xsl:call-template name="tabela-vendas">
												<xsl:with-param name="idCliente" select="$idCliente"/>
											</xsl:call-template> 


										</tbody>
									</table>


								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="header-cliente-main">
		<xsl:param name="id"/>
		<xsl:param name="nome"/>
		<xsl:param name="anos_afiliacao"/>
		<xsl:param name="sexo"/>


		<div class="row user-row">
			<div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
				<img class="img-circle" src="img/{$sexo}.png" alt="User Pic"/>
			</div> <!-- /col-xs-3 col-sm-2 col-md-1 col-lg-1 -->

			<div class="col-xs-8 col-sm-9 col-md-10 col-lg-10">
				<strong><xsl:value-of select="$nome"/></strong><br/>
				<span class="text-muted">Anos de afiliacao: <xsl:value-of select="$anos_afiliacao"/></span>
			</div> <!-- /col-xs-8 col-sm-9 col-md-10 col-lg-10 -->

			<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 dropdown-user">
				<xsl:attribute name="data-for">.id-cliente-<xsl:value-of select="$id"/></xsl:attribute>
				<i class="glyphicon glyphicon-chevron-down text-muted"></i>
			</div> <!-- /col-xs-1 col-sm-1 col-md-1 col-lg-1 dropdown-user -->

		</div> <!-- /row user-row -->

	</xsl:template>

	<xsl:template name="tabela-user-information">
		<xsl:param name="nome"/>
		<xsl:param name="idade"/>
		<xsl:param name="anos_afiliacao"/>
		<xsl:param name="cliente"/>

		<tbody>
			<tr>
				<td>Idade:</td>
				<td><xsl:value-of select="gv:idade"/></td>
			</tr>
			<tr>
				<td>Anos afiliacao:</td>
				<td><xsl:value-of select="gv:anos_afiliacao"/></td>
			</tr>
			<tr>
				<td>Registado desde:</td>
				<td><xsl:value-of select="gv:data_registo"/></td>
			</tr>
			<tr>
				<td>Compras efetuadas:</td>
				<td>
					<xsl:call-template name="contagem-compras-efetuadas">
						<xsl:with-param name="idCliente" select="current()/@idCliente"/>
					</xsl:call-template>
				</td>
			</tr>
			<tr>
				<td>Montante gasto:</td>
				<td>

					<xsl:variable name="idCliente" select="current()/@idCliente"/>

					<xsl:call-template name="soma-recursiva-montante-gasto">
						<xsl:with-param name="nos" select="//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$idCliente]/@id]" />
					</xsl:call-template>					
					€
				</td>
			</tr>
		</tbody>


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

	<xsl:template name="contagem-compras-efetuadas">
		<xsl:param name="idCliente"/>
		<!--<xsl:value-of select="count(//gv:detalhes_peca[@idPeca=//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$idCliente]/@id]/gv:peca/@id]/gv:preco)"/>-->
		<xsl:value-of select="count(//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$idCliente]/@id])"/>
	</xsl:template>

	<!--<xsl:template name="contagem-montante-gasto">
		<xsl:param name="idCliente"/>

		<xsl:value-of select="sum(//gv:detalhes_peca[@idPeca=//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$idCliente]/@id]/gv:peca/@id]/gv:preco)"/>
	</xsl:template>-->

	<xsl:template name="tabela-vendas">
		<xsl:param name="idCliente"/>
		<xsl:for-each select="//gv:venda[gv:cliente=current()/@idCliente]">
			<xsl:sort select="gv:data" order="ascending"/>
			<xsl:sort select="//gv:detalhes_peca[@idPeca=//gv:detalhes_venda[@idVenda=current()/@id]/gv:peca/@id]/gv:preco" order="descending"/>
			<xsl:variable name="idPeca" select="//gv:detalhes_venda[@idVenda=current()/@id]/gv:peca/@id"/>

			<tr id="{generate-id(//gv:detalhes_peca[@idPeca=$idPeca]/gv:nome)}">

				<td><xsl:value-of select="gv:data"/></td>
				<td><xsl:value-of select="gv:loja"/></td>
				<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$idPeca]/gv:nome"/></td>
				<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$idPeca]/gv:preco"/> €</td>
				<td><span class="pull-right pointer glyphicon glyphicon-info-sign" data-toggle="modal" data-target="#{generate-id($idPeca)}"></span>
			</td>
		</tr>
		<xsl:call-template name="info-peca">
			<xsl:with-param name="id" select="$idPeca"/>
		</xsl:call-template>



		<xsl:if test="position() = last()">
			<tr>
				<th>Total</th>
				<td></td>
				<td></td>
				<td>
					<xsl:call-template name="soma-recursiva-montante-gasto">
						<xsl:with-param name="nos" select="//gv:detalhes_venda[@idVenda=//gv:venda[gv:cliente=$idCliente]/@id]" />
					</xsl:call-template>
					€
				</td>

			</tr>
		</xsl:if>

	</xsl:for-each>
</xsl:template>

<xsl:template name="info-peca">
	<xsl:param name="id"/>
	<tbody class="peca-info hidden" id="{generate-id(//gv:detalhes_peca[@idPeca=$id]/gv:nome)}">					
		<tr>
			<th>Peca</th>
			<th>Tipo</th>
			<th>Marca</th>
			<th>Preco</th>
		</tr>
		<tr>
			<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:nome"/></td>
			<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:tipo"/></td>
			<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:marca"/></td>
			<td><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:preco"/></td>
		</tr>
	</tbody>	
</xsl:template>

<xsl:template name="modal-vendas">
	<xsl:param name="idCliente"/>
	<xsl:for-each select="//gv:venda[gv:cliente=current()/@idCliente]">
		<xsl:sort select="gv:data" order="ascending"/>
		<xsl:sort select="//gv:detalhes_peca[@idPeca=//gv:detalhes_venda[@idVenda=current()/@id]/gv:peca/@id]/gv:preco" order="descending"/>
		<xsl:variable name="idPeca" select="//gv:detalhes_venda[@idVenda=current()/@id]/gv:peca/@id"/>


		<xsl:call-template name="info-peca-modal">
			<xsl:with-param name="id" select="$idPeca"/>
		</xsl:call-template>



	</xsl:for-each>
</xsl:template>

<xsl:template name="info-peca-modal">
	<xsl:param name="id"/>

	<div class="modal fade" id="{generate-id($id)}">
		<div class="modal-dialog">
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h4 class="modal-title"><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:nome"/></h4>
				</div>
				<div class="modal-body"> 
					<div class="row">
						<div class="col-md-2">

							<xsl:call-template name="tratar-imagem">
								<xsl:with-param name="imagem" select="//gv:detalhes_peca[@idPeca=$id]/gv:imagem"/>
								<xsl:with-param name="width" select="'150'"/>
							</xsl:call-template>

						</div>

						<div class="col-md-10">
							<dl class="dl-horizontal">
								<dt>Peca</dt>
								<dd><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:nome"/></dd>
								<dt>Tipo</dt>
								<dd><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:tipo"/></dd>
								<dt>Marca</dt>
								<dd><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:marca"/></dd>

								<dt>Preco</dt>
								<dd><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:preco"/></dd>
								<dt>Descricao</dt>
								<dd><xsl:value-of select="//gv:detalhes_peca[@idPeca=$id]/gv:descricao"/></dd>
								<dt>Pecas vendidas</dt>
								<dd><xsl:value-of select="count(//gv:detalhes_venda/gv:peca[@id=$id])"/></dd>
							</dl>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

</xsl:template>

<xsl:template name="tratar-imagem">
	<xsl:param name="imagem"/>
	<xsl:param name="width"/>

	<xsl:choose>
		<xsl:when test="$imagem != ''" >
			<img width="{$width}" class="img-circle">
				<xsl:attribute name="src">
					<xsl:value-of select="$imagem"/>
				</xsl:attribute>
			</img>
		</xsl:when>

		<xsl:otherwise>
			<img width="{$width}" src="img/default.png" />			
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template match="*">

</xsl:template>




</xsl:stylesheet>