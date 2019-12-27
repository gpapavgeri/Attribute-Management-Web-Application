<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Employees</title>

    <!--Bootstrap 4 CSS-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!--FontAwesome CDN-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <!--Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/css/employees.css">
    <!--Jquery-->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <!--Bootstrap 4 JS-->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</head>

<body>

<div id="content">
    <div class = "container mt-4 bg-light border shadow mb-5">
        <p class = "h1">Employees</p>

        <table class = "table table-hover">
            <thead>
            <tr>
                <th>Name</th>
                <th>Date of Hire</th>
                <th>Supervisor</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
            </thead>
            <tbody>
            <tr id = "btn-create" data-toggle="modal">
                <td>
                    <i class="fas fa-plus"></i>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <c:forEach items="${allEmployees}" var="employee">
                <tr>
                    <td>
                        <c:out value="${employee.empName}" />
                    </td>
                    <td>
                        <c:out value="${employee.empDateOfHire}" />
                    </td>
                    <td>
                        <c:out value="${employee.empSupervisor}" />
                    </td>
                    <td>
                        <button class = "btn-edit btn-warning btn" type = "button" data-employeeId = "${employee.empId}" data-toggle="modal">Edit</button>
                    </td>
                    <td>
                        <button class = "btn-delete btn-danger btn" type = "button" data-employeeId = "${employee.empId}" data-toggle="modal">Delete</button>
                    </td>
                </tr>
            </c:forEach>

            <div id = "modalCreateEmployee" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Create Employee</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form action="/employees/add" method="POST">
                            <div class="modal-body">

                                <div class="form-group">
                                    <label for = "employeeName">Name</label>
                                    <br>
                                    <input id = "employeeName" name = "employeeName" class = "form-control" placeholder = "Enter Name" />
                                </div>

                                <div class="form-group">
                                    <label for = "employeeDateOfHire">Date Of Hire</label>
                                    <br>
                                    <input type="date" id = "employeeDateOfHire" name = "employeeDateOfHire" />
                                </div>

                                <div class="form-group">
                                    <label for = "supervisor">Supervisor</label>
                                    <br>
                                    <select id = "supervisor" name = "supervisor">
                                    </select>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-warning">Create</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div id = "modalEditEmployee" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Employee</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <form action="/employees/edit" method="POST">
                            <div class="modal-body">

                                <input type = "hidden" id = "employeeId-edit" name = "employeeId-edit" />

                                <div class="form-group">
                                    <label for = "employeeName-edit">Name</label>
                                    <br>
                                    <input id = "employeeName-edit" name = "employeeName-edit" class = "form-control" placeholder = "Enter Name" />
                                </div>

                                <div class="form-group">
                                    <label for = "employeeDateOfHire-edit">Date Of Hire</label>
                                    <br>
                                    <input type="date" id = "employeeDateOfHire-edit" name = "employeeDateOfHire-edit" />
                                </div>

                                <div class="form-group">
                                    <label for = "supervisor-edit">Supervisor</label>
                                    <br>
                                    <%--<input type = "hidden" id = "supervisorId-edit" name = "supervisorId-edit" />--%>
                                    <select id = "supervisor-edit" name = "supervisor-edit">
                                    </select>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-warning">Update</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div id = "modalDeleteEmployee" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Employee</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form action = "/employee/delete" method = "POST">
                            <div class="modal-body">

                                <input type = "hidden" id = "employeeId-delete" name = "employeeId">

                                <p>Are you sure you want to delete employee with name: <span id = "employeeName-delete"></span> ? </p>
                            </div>

                            <div class="modal-footer">
                                <button type="submit" class="btn btn-danger">Delete</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

            <!--Custom JS-->
            <script src="/js/employees.js"></script>

            </tbody>
        </table>

    </div>
</div>

</body>

</html>
