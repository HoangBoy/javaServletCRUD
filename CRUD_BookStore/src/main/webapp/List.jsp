<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Ứng dụng Quản lý Sách</title>
    <!-- Thêm link CSS của Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- CSS tùy chỉnh -->
    <style>
        /* Định dạng cho trang */
        body {         
        
        }
        .starter-template {
            padding: 3rem 1.5rem;
            text-align: center;
        }
        /* Định dạng cho thẻ caption của table */
        caption {
            caption-side: top;
            font-weight: bold;
            font-size: larger;
        }
    </style>
</head>
<body>
<header class="navbar navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Trang Quản Trị</a>
        <div class="navbar-nav ml-auto">
            <a href="logout" class="btn btn-light ml-2" onclick="logout()">Đăng xuất</a>
        </div>
    </div>
</header>
    <div class="container">
        <div class="starter-template">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" alt="Logo" width="200" height="200"> <!-- Thêm hình ảnh logo -->
            
            <h2>
                <a href="new" class="btn btn-primary">Thêm Sách Mới</a> <!-- Sử dụng bootstrap button -->
                &nbsp;&nbsp;&nbsp;
                <a href="list" class="btn btn-success">Danh Sách Tất Cả Sách</a> <!-- Sử dụng bootstrap button -->
            </h2>
        </div>
 <!-- Form tìm kiếm -->
<form id="searchForm" action="SearchServlet" method="get">
    <div class="row justify-content-center mb-3">
        <div class="col-md-6">
            <div class="input-group">
                <!-- Dropdown list cho loại tìm kiếm -->
                <select class="form-control" id="searchType" name="searchType">
                	 <option value="id">Mã sách</option>
                    <option value="title">Tiêu đề</option>
                    <option value="author">Tác giả</option>
                    <option value="price">Giá</option>
                    <!-- Thêm các loại tìm kiếm khác nếu cần -->
                </select>
                <input type="text" id="searchInput" name="keyword" class="form-control" placeholder="Nhập từ khóa...">
                <div class="input-group-append">
                    <button class="btn btn-primary" type="submit">Tìm kiếm</button>
                </div>
            </div>
        </div>
    </div>
</form>

        
        <div class="row justify-content-center">
            <div class="col-md-10">
                <table class="table table-bordered table-striped">
                    <caption>Danh Sách Sách</caption>
                    <thead class="thead-dark">
                        <tr>
                            <th>Mã sách</th>
                            <th>Tiêu Đề</th>
                            <th>Tác Giả</th>
                            <th>Giá</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <c:if test="${searchResult != null}">
                               <tbody>
                        <c:forEach var="book" items="${searchResult}">
                            <tr>
                                <td><c:out value="${book.id}" /></td>
                                <td><c:out value="${book.title}" /></td>	
                                <td><c:out value="${book.author}" /></td>
                                <td><c:out value="${book.price}" /></td>
                         
                                <td>
                                    <a href="edit?id=<c:out value='${book.id}' />" class="btn btn-info">Chỉnh Sửa</a> <!-- Sử dụng bootstrap button -->
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="delete?id=<c:out value='${book.id}' />" class="btn btn-danger">Xóa</a> <!-- Sử dụng bootstrap button -->                     
                                </td>
                            </tr>
                        </c:forEach>
                  			  </tbody> 
                     </c:if>
                   
                    <tbody>
                        <c:forEach var="book" items="${listBook}">
                            <tr>
                                <td><c:out value="${book.id}" /></td>
                                <td><c:out value="${book.title}" /></td>	
                                <td><c:out value="${book.author}" /></td>
                                <td><c:out value="${book.price}" /></td>
                         
                                <td>
                                    <a href="edit?id=<c:out value='${book.id}' />" class="btn btn-info">Chỉnh Sửa</a> <!-- Sử dụng bootstrap button -->
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="delete?id=<c:out value='${book.id}' />" class="btn btn-danger">Xóa</a> <!-- Sử dụng bootstrap button -->                     
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Thêm script JS của Bootstrap -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
</body>
</html>
