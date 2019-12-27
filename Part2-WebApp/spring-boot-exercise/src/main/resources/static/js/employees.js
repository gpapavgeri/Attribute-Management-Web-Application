$(document).ready(function(){

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
                    if(data1.empSupervisor === data[i].empId) {
                        option.setAttribute("selected", "true");
                    }
                    selector.append(option);
                }
                $("#employeeName-edit").val(data1.empName);
                $("#employeeDateOfHire-edit").val(data1.empDateOfHire.substring(0,10));
            });
        });
        $("#modalEditEmployee").modal("show");
    });


    $(".btn-delete").click(function(){
        let employeeId = $(this).attr("data-employeeId");
        $.ajax({
            url:"/api/employees/" + employeeId,
            async: false
        }).then(function(data){
            $("#employeeId-delete").val(data.empId);
            $("#employeeName-delete").html("");
            $("#employeeName-delete").append(data.empName);
        });
        $("#modalDeleteEmployee").modal("show");
    });

});