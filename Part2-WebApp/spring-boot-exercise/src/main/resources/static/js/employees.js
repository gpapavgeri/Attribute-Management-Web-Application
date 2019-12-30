$(document).ready(function(){

    // After click on create button:
    // 1) make an ajax request -> get all employees and show their name
         // in the dropdown list that will be created by the select element
    // 2) show the create-modal component
    $("#btn-create").click(function(){
        $.ajax({
            url:"/api/employees",
            async:false
        }).then(function(data){
            const selector = document.querySelector("#supervisor");
            selector.innerHTML = "";
            for(let i in data){
                const option = document.createElement("option");
                option.innerText= data[i].empName;
                selector.append(option);
            }
        });
        $("#modalCreateEmployee").modal("show");
    });

    // After click on edit button:
    // 1) assign the ID value (that was retrieved by the list 'allEmployees' for the specific employee
        // and was saved to to the custom attribute 'data-employeeId') to the hidden input element
        // of the edit form in the edit-modal component
    // 2) make an ajax request -> get all employees and show their name
        // in the dropdown list that will be created by the select element
    // 3) make an ajax request -> get the specific employee according to the ID value from the first step
        // and show the employee's name in the field 'Name' and the employee's date of hire in the field 'Date of Hire'
        // as predefined values
    $(".btn-edit").click(function(){
        let employeeId = $(this).attr("data-employeeId");
        $("#employeeId-edit").val(employeeId);
        $.ajax({
            url:"/api/employees/",
            async:false
        }).then(function(data){
            $.ajax({
                url:"/api/employees/" + employeeId,
                async:false
            }).then(function(data1){
                const selector = document.querySelector("#supervisor-edit");
                selector.innerHTML = "";
                for(let i in data){
                    const option = document.createElement("option");
                    option.innerText= data[i].empName;
                    selector.append(option);
                }
                $("#employeeName-edit").val(data1.empName);
                $("#employeeDateOfHire-edit").val(data1.empDateOfHire.substring(0,10));
            });
        });
        $("#modalEditEmployee").modal("show");
    });

    // After click on delete button:
    // 1) assign the ID value (that was retrieved by the list 'allEmployees' for the specific employee
        // and was saved to to the custom attribute 'data-employeeId') to the hidden input element
        // of the delete form in the delete-modal component
    // 2) make an ajax request -> get the specific employee according to the ID value from the first step
        // and append the employee's name in the span element of the delete form in the delete-modal component
    $(".btn-delete").click(function(){
        let employeeId = $(this).attr("data-employeeId");
        $("#employeeId-delete").val(employeeId);
        $.ajax({
            url:"/api/employees/" + employeeId,
            async: false
        }).then(function(data){
            $("#employeeName-delete").html("");
            $("#employeeName-delete").append(data.empName);
        });
        $("#modalDeleteEmployee").modal("show");
    });

    // After click on attributes button:
    // 1) get the ID value (that was retrieved by the list 'allEmployees' for the specific employee
    // and was saved to to the custom attribute 'data-employeeId') and assing it to a variable (employeeId)
    // 2) make an ajax request -> get the specific employee according to the ID value from the first step
    // and retrieve the employee's list of attributes
    // 3) for each attribute append the corresponding table row with the attribute's fields (name-value-edit-delete)
    $(".btn-attributes").click(function(){
        let employeeId = $(this).attr("data-employeeId");
        $.ajax({
            url:"/api/employees/" + employeeId,
            async: false
        }).then(function(data){
            $("#attrTable").find("tr:gt(1)").remove();
            const array = data.attributes;
                for (let i in array) {
                    $('#attrTable > tbody:last-child').append('<tr>\n' +
                        '                            <td>\n' +
                        '                                <p>' + array[i].attrName + '</p>\n' +
                        '                            </td>\n' +
                        '                            <td>\n' +
                        '                                <p>' + array[i].attrValue + '</p>\n' +
                        '                            </td>\n' +
                        '                            <td>\n' +
                        '                                <button class = "btn-attrEdit btn-warning btn" data-attributeId = ' + array[i].attrId + ' type = "button" data-toggle="modal" >Edit</button>\n' +
                        '                            </td>\n' +
                        '                            <td>\n' +
                        '                                <button class = "btn-delete btn-danger btn" data-attributeId = ' + array[i].attrId + ' type = "button" data-toggle="modal">Delete</button>\n' +
                        '                            </td>\n' +
                        '                        </tr>');
                }
            });
        $("#modalAttributes").modal("show");
    });
        // After click on attribute's edit button:
        // 1) assign the attribute ID value (that was retrieved by the list 'attributes' for the specific employee
        // and was saved to to the custom attribute 'data-attributeId') to the hidden input element
        // of the edit form in the edit-modal component
        // 2) make an ajax request -> get the specific attribute according to the ID value from the first step
        // and show the attribute's name in the field 'Name' and the attribute's value in the field 'Value'
        // as predefined values


    $( "#modalAttributes" ).on('shown', function(){
        $('.btn-attrEdit').click(function () {
            let attributeId = $(this).data('attributeId');
            // let attributeId = $(this).attr("data-attributeId");
            $('#attributeId-edit').val(attributeId);
            $.ajax({
                url: '/api/attributes/' + attributeId,
                async: false
            }).then(function (data) {
                $('#attributeName-edit').val(data.attrName);
                $('#attributeValue-edit').val(data.attrValue);
            });
            $('#modalEditAttribute').modal('show');
        });
    });


});
