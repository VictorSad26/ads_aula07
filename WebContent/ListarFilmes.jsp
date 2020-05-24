<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Lista de Filmes</title>
	<!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body>
	<c:import url="Menu.jsp"/>
	<div class="container">
		<div class="row">
			<h1>Lista de Filmes</h1>
		</div>
		<hr>
		<form action="manter_filmes.do" method="GET">
		<!-- modal -->
			<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">Excluir Filme</h4>
			      </div>
			      <div class="modal-body">
			        <p>Confirma a exclusão do(s) filme(s)?</p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
			        <input type="submit" name="acao" value="Excluir" class="btn btn-danger">
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			<div class = "row">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>&nbsp;</th>
							<th>Pôster</th>
							<th>Id</th>
							<th>Título</th>
							<th>Gênero</th>
							<th>Diretor</th>
							<th>Lançamento</th>					
						</tr>
					</thead>
					<tbody>
						<c:forEach var="filme" items="${filmes}">
							<tr>
								<td>
									<div class="checkbox">
										<label>
											<input type="checkbox" name="box${filme.id}" onClick="tratarBotoes(this)">
										</label>
									</div>
								</td>
								<td><img src="${filme.posterPath}" class="img-thumbnail" width="70"></td>
								<td>${filme.id}</td>
								<td>${filme.titulo}</td>
								<td>${filme.genero.nome}</td>
								<td>${filme.diretor}</td>
								<td><fmt:formatDate value="${filme.dataLancamento}" dateStyle="SHORT"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<hr>
			<div class = "row">
				<div class="col-md-12">
					<input type="submit" id="btnEditar" name="acao" value="Editar" class="btn btn-primary" disabled>
					<input type="submit" id="btnVisualizar" name="acao" value="Visualizar" class="btn btn-info" disabled>
					<input type="button" id="btnExcluir" value="Excluir" data-toggle="modal" data-target="#delete-modal" class="btn btn-danger" disabled>
					<a href="index.jsp" class="btn btn-default">Voltar</a>
				</div>
			</div>
			<br><br><br>
		</form>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="js/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script>
    	var caixa = [];
    	function tratarBotoes(element){
    		if (element.checked){
    			caixa.push(element);
    		} else {
    			caixa.pop();
    		}
    		if (caixa.length == 0){
    			document.getElementById("btnEditar").disabled = true;
    			document.getElementById("btnVisualizar").disabled = true;
    			document.getElementById("btnExcluir").disabled = true;
    		} else if (caixa.length == 1){
    			document.getElementById("btnEditar").disabled = false;
    			document.getElementById("btnVisualizar").disabled = false;
    			document.getElementById("btnExcluir").disabled = false;
    		} else {
    			document.getElementById("btnEditar").disabled = true;
    			document.getElementById("btnVisualizar").disabled = true;
    			document.getElementById("btnExcluir").disabled = false;
    		}
    	}
    </script>
</body>
</html>