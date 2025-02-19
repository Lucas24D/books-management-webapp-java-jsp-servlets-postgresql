<%-- Document : person/list Created on : 08/01/2022, 23:38:26 Author : edsonpaulo --%>

<%@page import="java.util.List"%>
<%@page import="ucan.dao.PersonDAO"%>
<%@page import="ucan.utils.Helpers"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="ucan.dao.GenderDAO"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="ucan.conection.DBConnection"%>
<%@page import="ucan.utils.HtmlObj" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="../partials/html-head.jsp" %>  
<html>
    <%
        DBConnection connection = null;
        try {
            String query = "SELECT pessoa.pk_pessoa AS id, pessoa.nome AS name, pessoa.sobrenome AS surname, "
                    + "sexo.nome AS gender, pessoa.bi AS bi, pessoa.data_nasc AS nasc FROM pessoa "
                    + "INNER JOIN sexo ON pessoa.fk_sexo = sexo.pk_sexo;";

            connection = new DBConnection();
            ResultSet resultSet = connection.getConnection().createStatement().executeQuery(query);
            PersonDAO personDao = new PersonDAO();
    %>

    <body>
        <%@ include file="../partials/navbar.jsp" %>  

        <a href="<%=request.getContextPath()%>" class="btn btn-primary btn-sm m-4"><< Voltar</a>
        <a href="<%=request.getContextPath()%>/person/new.jsp" class="btn btn-primary m-4 float-right">+ Adicionar nova pessoa</a>

        <div class="h-100 container-fluid d-flex justify-content-center align-items-start">
            <div class="card px-5 py-3 table-responsive-lg" style="width: 100%;">

                <h5 class="text-center mb-3">Lista de Pessoas</h5>

                <table class="table table-striped table-sm">
                    <thead>
                        <tr>
                            <th scope="col">Tipo</th>
                            <th scope="col">ID</th>
                            <th scope="col">Nome</th>                            
                            <th scope="col">Sobrenome</th>
                            <th scope="col">Sexo</th>
                            <th scope="col">Bilhete de Identidade</th>
                            <th scope="col">Data de nascimento</th>
                            <th scope="col">Accões</th>                            
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            StringBuilder htmlBuilder = new StringBuilder();
                            if (!resultSet.isBeforeFirst()) {
                                htmlBuilder.append("<tr><td colspan=\"8\"> <h6 class=\"my-5 text-muted text-center\">Sem dados!</h6></tr></td>");
                            }

                            while (resultSet.next()) {
                                htmlBuilder.append("<tr>");
                                htmlBuilder.append("<th scope=\"row\">" + (personDao.isAuthor(resultSet.getInt("id"), connection) ? "Autor" : "Leitor") + "</th>");
                                htmlBuilder.append("<th scope=\"row\">0" + resultSet.getInt("id") + "</th>");
                                htmlBuilder.append("<td>" + resultSet.getString("name") + "</td>");
                                htmlBuilder.append("<td>" + resultSet.getString("surname") + "</td>");
                                htmlBuilder.append("<td>" + resultSet.getString("gender") + "</td>");
                                htmlBuilder.append("<td>" + resultSet.getString("bi") + "</td>");
                                htmlBuilder.append("<td>" + resultSet.getTimestamp("nasc").toLocalDateTime().toLocalDate() + "</td>");

                                htmlBuilder.append("<td><a class=\"btn btn-secondary btn-sm text-white\" href=\"" + request.getContextPath() + "/person/view.jsp?id="
                                        + resultSet.getInt("id") + "\">Visualizar</a>");

                                htmlBuilder.append(" <a class=\"btn btn-warning btn-sm text-white mx-2\" href=\"" + request.getContextPath() + "/person/edit.jsp?id="
                                        + resultSet.getInt("id") + "\">Editar</a>");

                                htmlBuilder.append("<a class=\"btn btn-danger btn-sm text-white\" href=\"" + request.getContextPath() + "/person-servlet?id="
                                        + resultSet.getInt("id") + "&action=delete\">Remover</a></td>");

                                htmlBuilder.append("</tr>");
                            }
                        %>
                        <%= htmlBuilder%>
                    </tbody>
                </table>


            </div>
        </div>
    </body>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.closeConnection();
            }
        }
    %>
    <script>

    </script>

</html>