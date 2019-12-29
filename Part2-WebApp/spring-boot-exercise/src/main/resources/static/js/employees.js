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

});