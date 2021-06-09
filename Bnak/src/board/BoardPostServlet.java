package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//post.jsp에서 입력한 게시물 저장을 위한 서블릿
@WebServlet("/board/boardPost")
public class BoardPostServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		BoardMgr mgr = new BoardMgr();
		mgr.insertBoard(request);

		response.sendRedirect("list.jsp");
	}
}







