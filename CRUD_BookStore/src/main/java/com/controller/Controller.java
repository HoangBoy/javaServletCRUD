package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.DAO;
import com.dao.UserDAO;
import com.model.Book;
import com.model.User;

@WebServlet("/")

public class Controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public DAO bookDAO;
    public UserDAO userDao;
    public void init() {
        String jdbcURL = "jdbc:mysql://localhost:3306/Bookstore";
        String jdbcUsername ="root";
        String jdbcPassword = "24102003";
        bookDAO = new DAO(jdbcURL, jdbcUsername, jdbcPassword);
        userDao = new UserDAO(jdbcURL, jdbcUsername, jdbcPassword); 
    }
 
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	 if (session == null || session.getAttribute("username") == null) {
             // Nếu session không tồn tại hoặc không có tên người dùng được lưu trong session,
             // chuyển hướng người dùng đến trang đăng nhập
             response.sendRedirect(request.getContextPath() + "/login.jsp");
             return;
         }else {
        String action = request.getServletPath(); 
        
        try {
            switch (action) {
            case "/edit":
                showEditForm(request, response);
                break;
            case "/new":
                showNewForm(request, response);
                break;
            case "/delete":
                deleteBook(request, response);
                break;
            case "/logout":
            	logout(request, response);
                break;
            case "/SearchServlet":
            	search(request, response);
                break;
            default:
            	listBook(request, response);
            	break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
         }
    }
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
 
        try {
            switch (action) {
            case "/register":
                regester(request,response);
                break;
            case "/insert":
                insertBook(request, response);
                break;
            case "/update":
                updateBook(request, response);
                break;
            case "/login":
                login(request, response);
                break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    
    ///
    protected void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String searchType = request.getParameter("searchType");

        List<Book> searchResult = null;
        try {
            if (keyword != null && !keyword.isEmpty() && searchType != null && !searchType.isEmpty()) {
                searchResult = bookDAO.searchBooks(keyword, searchType);
            } else {
                // Nếu không có từ khóa hoặc loại tìm kiếm, xử lý theo ý định của bạn.
                // Ở đây, tôi để danh sách kết quả tìm kiếm trống.
                searchResult = new ArrayList<>();
            }

            request.setAttribute("searchResult", searchResult);
            RequestDispatcher dispatcher = request.getRequestDispatcher("List.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }


    
    protected void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xóa session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            response.sendRedirect("login.jsp");
            
            
            // Xóa toàn bộ thông tin của session
        }

        // Chuyển hướng đến trang đăng nhập
       
    }

    	// login function
    protected void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User userLog = new User(username,password);
        
       if(userDao.login(userLog)) {
    	   HttpSession session = request.getSession();
           session.setAttribute("username", username);
           response.sendRedirect("list");
       }else{
           PrintWriter out = response.getWriter();
           response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");    	   
       }
        
       
    }

    protected void regester(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        
        User newUser = new User(username, email, password);
        
        	userDao.insertUser(newUser);
        	response.sendRedirect("login.jsp");
    }
    ///
   
    	// crud func
    private void listBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Book> listBook = bookDAO.listAllBooks();
        request.setAttribute("listBook", listBook);
        RequestDispatcher dispatcher = request.getRequestDispatcher("List.jsp");
        dispatcher.forward(request, response);
    }
 
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
        dispatcher.forward(request, response);
    }
 
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        Book existingBook = bookDAO.getBook(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Form.jsp");
        request.setAttribute("book", existingBook);
        dispatcher.forward(request, response);
 
    }
 
    private void insertBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
    	 String id = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        float price = Float.parseFloat(request.getParameter("price"));
        // tao doi tuong
        Book newBook = new Book(id, title, author, price);
        bookDAO.insertBook(newBook);
        response.sendRedirect("list");
    }
 
    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        String idNew = request.getParameter("idnew");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        float price = Float.parseFloat(request.getParameter("price"));

        Book book = new Book(id, title, author, price);
        bookDAO.updateBook(book, idNew);
        response.sendRedirect("list");
    }
 
    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
    	String id = request.getParameter("id");
 
        Book book = new Book(id);
        bookDAO.deleteBook(book);
        response.sendRedirect("list");
 
    }
}


