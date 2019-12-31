package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Attribute;
import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.services.AttributeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("api")
public class RestAttributeController {

    @Autowired
    AttributeService attrService;

    // Get all attributes
    @GetMapping("/attributes")
    public Iterable<Attribute> showAllAttributes(){
        Iterable<Attribute> attributes = attrService.getAllAttributes();
        return attributes;
    }

    // Create a new Attribute
    @PostMapping("/attributes")
    public void createAttribute(@Valid @RequestBody Attribute attribute){
        attrService.insertAttribute(attribute);
    }

    // Get a single Attribute By ID
    @GetMapping("/attributes/{id}")
    public Attribute getAttributeById(@PathVariable(value="id") String id){
        UUID attrId = UUID.fromString(id);
        return attrService.getAttributeById(attrId);
    }

    // Update an Attribute By ID
    @PutMapping("/attributes/{id}")
    public Attribute updateAttribute(@PathVariable(value="id") String id,
                                   @Valid @RequestBody Attribute attribute) {
        UUID attrId = UUID.fromString(id);
        Attribute attr = attrService.getAttributeById(attrId);
        attr.setAttrName(attribute.getAttrName());
        attr.setAttrValue(attribute.getAttrValue());

        List<Employee> empList = attribute.getEmployees();
        attr.setEmployees(empList);

        attrService.updateAttribute(attr);
        return attr;
    }

    // Delete an Attribute By ID
    @DeleteMapping("/attributes/{id}")
    public ResponseEntity<Attribute> deleteAttribute(@PathVariable(value="id") String id){
        UUID attrId = UUID.fromString(id);
        attrService.deleteAttributeById(attrId);
        return ResponseEntity.ok().build();
    }

}
