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
            <form action = "/employees/delete" method = "POST">
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

<div id = "modalAttributes" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Employee's Attributes</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

                <div class="modal-body">
                    <table id="attrTable" class = "table table-hover">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Value</th>
                            <th>Edit</th>
                            <th>Remove</th>
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
                        </tbody>
                    </table>
                </div>

        </div>
    </div>
</div>


<div id = "modalEditAttribute" class="modal fade" tabindex="-1" role="dialog">
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

                    <input type = "hidden" id = "attributeId-edit" name = "attributeId-edit" />

                    <div class="form-group">
                        <label for = "attributeName-edit">Name</label>
                        <br>
                        <input id = "attributeName-edit" name = "attributeName-edit" class = "form-control" placeholder = "Enter Attribute's Name" />
                    </div>

                    <div class="form-group">
                        <label for = "attributeValue-edit">Value</label>
                        <br>
                        <input id = "attributeValue-edit" name = "attributeValue-edit" class = "form-control" placeholder = "Enter Attribute's Value" />
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
