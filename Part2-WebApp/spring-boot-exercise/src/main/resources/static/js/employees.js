$(document).ready(function(){

    // After click on create button:
    // 1) make an ajax request -> get all employees and show their name in the dropdown list that will be created by the select element
    // 2) show the create-modal component
    $("#btn-createEmp").click(function(){
        $.ajax({
            url:"/api/employees",
            async:false
        }).then(function(data){
            const selector = document.querySelector("#supervisor");
            selector.innerHTML = "";

            const nullOption = document.createElement("option");
            nullOption.innerText="null";
            selector.append(nullOption);

            for(let i in data){
                const option = document.createElement("option");
                option.innerText= data[i].empName;
                selector.append(option);
            }
        });
        $("#modalCreateEmployee").modal("show");
    });

    // After click on edit button:
    // 1) Retrieve the ID value for the selected employee by the list 'allEmployees' that was saved to to the custom attribute 'data-employeeId'
    // 2) Assign the ID value to the hidden input element of the edit form in the edit-modal component
    // 3) make an ajax request -> get all employees and show their name in the dropdown list that will be created by the select element
    // 4) make an ajax request -> get the specific employee according to the ID value from the first step and show the employee's name in the field 'Name' and the employee's date of hire in the field 'Date of Hire as predefined values
    // 5) show the edit-modal component
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

                const nullOption = document.createElement("option");
                nullOption.innerText="null";
                selector.append(nullOption);

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
    // 1) Retrieve the ID value for the selected employee by the list 'allEmployees' that was saved to to the custom attribute 'data-employeeId'
    // 2) Assign the ID value to the hidden input element of the delete form in the delete-modal component
    // 3) make an ajax request -> get the specific employee according to the ID value from the first step and append the employee's name in the span element of the delete form in the delete-modal component
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
    // 1) Retrieve the ID value for the selected employee by the list 'allEmployees' that was saved to to the custom attribute 'data-employeeId' and assign it to a variable (employeeId)
    // 2) make an ajax request -> get the specific employee according to the ID value from the first step and retrieve the employee's list of attributes
    // 3) for each attribute append the corresponding table row with the attribute's fields (name-value)
    $(".btn-empAttributes").click(function(){
        let employeeId = $(this).attr("data-employeeId");
        $.ajax({
            url:"/api/employees/" + employeeId,
            async: false
        }).then(function(data){
            $("#attrTable").find("tr:gt(0)").remove();
            const array = data.attributes;
            for (let i in array) {
                $('#attrTable > tbody:last-child').append('<tr>\n' +
                    '                            <td>\n' +
                    '                                <p>' + array[i].attrName + '</p>\n' +
                    '                            </td>\n' +
                    '                            <td>\n' +
                    '                                <p>' + array[i].attrValue + '</p>\n' +
                    '                            </td>\n' +
                    '                        </tr>');
            }
        });
        $("#modalAttributes").modal("show");
    });


});
