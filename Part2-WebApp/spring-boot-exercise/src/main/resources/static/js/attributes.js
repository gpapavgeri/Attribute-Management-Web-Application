$(document).ready(function(){

    // After the edit-modal component for attribute is shown
    // the attribute's fields (id, name, value) are retrieved from the attributes-modal of employee table and
    // these fields are assigned to the elements of the edit-modal for the attribute
$('#modalEditAttribute').on('shown.bs.modal', function() {
    let attrId = $('.btn-attrEdit').attr('data-attributeId');
    let attrName = $('#attrName').text();
    let attrValue = $('#attrValue').text();

    $('#attributeId-edit').val(attrId);
    $('#attributeName-edit').val(attrName);
    $('#attributeValue-edit').val(attrValue);
});

    // After the delete-modal component for attribute is shown
    // the attribute's field (id) and the employee's field (id) are retrieved from the attributes-modal of employee table and
    // these fields are assigned to the elements of the delete-modal for the attribute
$('#modalDeleteAttribute').on('shown.bs.modal', function() {
    let attrId = $('.btn-attrDelete').attr('data-attributeId');
    $('#attributeId-delete').val(attrId);

    let empId = $('.btn-attrDelete').attr('data-employeeId');
    $('#emplId-delete').val(empId);
});


    // After click on add attribute button:
    // 1) make an ajax request -> get all attributes and show their name in the dropdown list that will be created by the select element
    // 2) show the add-modal component
$("#btn-addAttr").click(function(){
    $.ajax({
        url:"/api/attributes",
        async:false
    }).then(function(data){
        const selector = document.querySelector("#allAttributes");
        selector.innerHTML = "";

        for(let i in data){
            const option = document.createElement("option");
            option.innerText= data[i].attrName + " / " + data[i].attrValue;
            selector.append(option);
        }
    });
    $("#modalAddAttribute").modal("show");
});

});
