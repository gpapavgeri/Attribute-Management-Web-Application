package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Attribute;
import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.services.AttributeService;
import com.employment.springbootexercise.services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.ListIterator;
import java.util.UUID;

@Controller
public class AttributeController {

    @Autowired
    AttributeService attrService;

    @Autowired
    EmployeeService empService;

    // Edit attribute
    @RequestMapping(value = "/attributes/edit", method = RequestMethod.POST)
    public String editEmployee( @RequestParam("attributeId-edit") String attributeId,
                                @RequestParam("attributeName-edit") String attributeName,
                                @RequestParam("attributeValue-edit") String attributeValue){
        Attribute attributeToEdit = attrService.getAttributeById(UUID.fromString(attributeId));
        attributeToEdit.setAttrName(attributeName);
        attributeToEdit.setAttrValue(attributeValue);

        attrService.updateAttribute(attributeToEdit);

        return "redirect:/employees";
    }

    // Remove attribute from Employee
    @RequestMapping(value = "/attributes/removeFromEmployee", method = RequestMethod.POST)
    public String removeFromEmployee( @RequestParam("attributeId-delete") String attributeId,
                                      @RequestParam("emplId-delete") String empId){

        UUID attrId = UUID.fromString(attributeId);
        Employee employee = empService.getEmployeeById(UUID.fromString(empId));
        List<Attribute> empList = employee.getAttributes();

        ListIterator<Attribute> iterator =empList.listIterator();
        while(iterator.hasNext()){
            Attribute attribute = iterator.next();
            if(attribute.getAttrId().equals(attrId)){
                iterator.remove();
            }
        }

        employee.setAttributes(empList);
        empService.updateEmployee(employee);

        return "redirect:/employees";
    }


}
