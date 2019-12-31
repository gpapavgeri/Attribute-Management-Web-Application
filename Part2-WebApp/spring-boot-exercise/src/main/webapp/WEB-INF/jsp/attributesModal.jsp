<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Employees</title>

    <!--Bootstrap 4 CSS-->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!--FontAwesome CDN-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    <!--Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/css/employees.css">
    <!--Jquery-->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <!--Bootstrap 4 JS-->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <!--Custom JS-->
    <script async src="/js/employees.js"></script>
    <script async src="/js/attributes.js"></script>
</head>

<body>

<div id="modalEditAttribute" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Attribute</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <form action="/attributes/edit" method="POST">
                <div class="modal-body">

                    <input type="hidden" id="attributeId-edit" name="attributeId-edit"/>

                    <div class="form-group">
                        <label for="attributeName-edit">Name</label>
                        <br>
                        <input id="attributeName-edit" name="attributeName-edit" class="form-control"
                               placeholder="Enter Name"/>
                    </div>

                    <div class="form-group">
                        <label for="attributeValue-edit">Name</label>
                        <br>
                        <input id="attributeValue-edit" name="attributeValue-edit" class="form-control"
                               placeholder="Enter Name"/>
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

<div id="modalDeleteAttribute" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Remove Attribute from Employee</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="/attributes/removeFromEmployee" method="POST">
                <div class="modal-body">

                    <input type="hidden" id="attributeId-delete" name="attributeId-delete">
                    <input type="hidden" id="emplId-delete" name="emplId-delete">

                    <p>Are you sure you want to remove the attribute from the employee ?</p>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Delete</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>

            </form>
        </div>
    </div>
</div>

<div id="modalAddAttribute" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add Attribute to Employee</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="/employees" method="GET">
                <div class="modal-body">

                    <input type="hidden" id="attributeId-add" name="attributeId-add"/>

                    <div class="form-group">
                        <label for="allAttributes">Attributes</label>
                        <br>
                        <select id="allAttributes" name="selectedAttribute">
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-warning">Add</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>

</html>