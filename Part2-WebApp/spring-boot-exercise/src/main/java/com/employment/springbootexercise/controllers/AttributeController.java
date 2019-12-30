package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Attribute;
import com.employment.springbootexercise.services.AttributeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

@Controller
public class AttributeController {

    @Autowired
    AttributeService attrService;

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
}

