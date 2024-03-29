<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Trị</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
           
        }
        h1, h2 {
            text-align: center;
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
        <div class="row">
            <div class="col">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/HUNRE_Logo.png/768px-HUNRE_Logo.png" alt="Logo" class="img-fluid mx-auto d-block" style="max-width: 200px;">
            </div>
        </div>
        <div class="row">
            <div class="col">
                <h1>Quản lý Sách</h1>
                 
                <h2>
                    <a href="new" class="btn btn-primary">Thêm Sách Mới</a>
                    <a href="list" class="btn btn-secondary">Danh Sách Sách</a>
                </h2>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <c:if test="${book != null}">
                    <form action="update" method="post">
                </c:if>
                <c:if test="${book == null}">
                    <form action="insert" method="post">
                </c:if>
                 <caption style= "caption-side: top;
    font-weight: bold;
    font-size: larger;">
                            <c:if test="${book != null}">
                                Chỉnh Sửa Thông Tin Sách
                            </c:if>
                            <c:if test="${book == null}">
                                Thêm Sách Mới
                            </c:if>
                   </caption>
                <table class="table table-bordered table-striped">
                   
                      
                 
                   
                     <tr>
                        <th scope="row">Mã sách:</th>
                        <td>
                    
                <c:if test="${book != null}">
                                 <input type="text" name="idnew" class="form-control" 
               value="<c:out value='${book.id}' />" required>
                <input type="hidden" name="id" class="form-control" 
               value="<c:out value='${book.id}' />" required>
                            </c:if>
                            <c:if test="${book == null}">
                               <input type="text" name="id" class="form-control" 
               value="<c:out value='${book.id}' />" required>
                            </c:if>
               

                        </td>
                    </tr>         
                    <tr>
                        <th scope="row">Tiêu đề:</th>
                        <td>
                            <input type="text" name="title" class="form-control" 
                                value="<c:out value='${book.title}' />" required>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Tác giả:</th>
                        <td>
                            <input type="text" name="author" class="form-control" 
                                value="<c:out value='${book.author}' />" required>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Giá:</th>
                        <td>
                            <input type="number" name="price" class="form-control" 
                                value="<c:out value='${book.price}' />" required>
                        </td>
                    </tr>
               
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" value="Lưu" class="btn btn-success">
                        </td>
                    </tr>
                </table>
                </form>
            </div>
        </div>
    </div>   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
