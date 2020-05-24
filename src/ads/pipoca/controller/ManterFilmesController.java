package ads.pipoca.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.NoSuchElementException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ads.pipoca.model.entity.Filme;
import ads.pipoca.model.entity.Genero;
import ads.pipoca.model.service.FilmeService;
import ads.pipoca.model.service.GeneroService;

@WebServlet("/manter_filmes.do")
public class ManterFilmesController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String acao = request.getParameter("acao");
		Filme filme = null;
		Genero genero = null;
		FilmeService fService = new FilmeService();
		GeneroService gService = new GeneroService();
		String saida = "";
		String id_filme = null;
		int idFilme = -1;
		
		switch(acao) {
		case "listar":
			ArrayList<Filme> lista = fService.listarFilmes();
			request.setAttribute("filmes", lista);
			saida = "ListarFilmes.jsp";
			break;
		case "generos":
			ArrayList<Genero> generos = gService.listarGeneros();
			request.setAttribute("generos", generos);
			saida = "InserirFilme.jsp";
			break;
		case "mostrar":
			id_filme = request.getParameter("id_filme");
			idFilme = Integer.parseInt(id_filme);
			filme = fService.buscarFilme(idFilme);
			System.out.println(filme);
			request.setAttribute("filme", filme);
			saida = "Filme.jsp";
			break;
		case "inserir":
			String titulo = request.getParameter("titulo");
			String descricao = request.getParameter("descricao");
			String diretor = request.getParameter("diretor");
			String idGenero = request.getParameter("genero");
			String data = request.getParameter("data_lancamento");
			String popularidade = request.getParameter("popularidade");
			String posterPath = request.getParameter("poster_path");
			filme = new Filme();
			filme.setTitulo(titulo);
			filme.setDescricao(descricao);
			filme.setDiretor(diretor);
			SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date dataLanc = null;
			try {
				dataLanc = formater.parse(data);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			filme.setDataLancamento(dataLanc);
			filme.setPopularidade(Double.parseDouble(popularidade));
			filme.setPosterPath(posterPath);
			genero = gService.buscarGenero(Integer.parseInt(idGenero));
			filme.setGenero(genero);
			int id = fService.inserirFilme(filme);
			filme.setId(id);
			System.out.println(filme);
			request.setAttribute("filme", filme);
			saida = "Filme.jsp";
			break;
		case "atualizar":
			break;
		case "excluir":
			id_filme = request.getParameter("id_filme");
			idFilme = Integer.parseInt(id_filme);
			fService.excluirFilme(idFilme);
			saida = "index.jsp";
			break;
		case "Excluir":
			System.out.println("Mandou excluir");
			Enumeration<String> pars = request.getParameterNames();
			ArrayList<Integer> listaIds = new ArrayList<>();
			String[] vals;
			String par;
			try {
				while((par = pars.nextElement()) != null) {
					if (par.startsWith("box")) {
						vals = request.getParameterValues(par);
						if (vals != null && vals.length > 0 && vals[0].equals("on")){
							listaIds.add(Integer.parseInt(par.substring(3)));
						}
					}
				}
			} catch (NoSuchElementException nsee) {
				
			}
			System.out.println("Lista ids: "+listaIds);
			fService.excluirVariosFilmes(listaIds);
		}
		RequestDispatcher view = request.getRequestDispatcher(saida);
		view.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
