package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board/boardUpdate")
public class BoardUpdateServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		//요청된 값들에 대한 인코딩
		request.setCharacterEncoding("EUC-KR");
		//응답에 대한 한글 인코딩
		response.setContentType("text/html; charset=EUC-KR");
		//세션에 bean객체를 read.jsp 저장.
		HttpSession session = request.getSession();
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String dbPass = bean.getPass();
		String inPass = request.getParameter("pass");
		if(dbPass.equals(inPass)) {
			//비번이 같은 면 수정 처리
			BoardMgr mgr = new BoardMgr();
			bean.setName(request.getParameter("name"));
			bean.setSubject(request.getParameter("subject"));
			bean.setContent(request.getParameter("content"));
			mgr.updateBoard(bean);
			String nowPage = request.getParameter("nowPage");
			String numPerPage = request.getParameter("numPerPage");
			response.sendRedirect("read.jsp?nowPage="+nowPage+
					"&numPerPage="+numPerPage+
					"&num="+bean.getNum());
		}else {
			//비번 틀렸다고 경고창
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 아닙니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}








