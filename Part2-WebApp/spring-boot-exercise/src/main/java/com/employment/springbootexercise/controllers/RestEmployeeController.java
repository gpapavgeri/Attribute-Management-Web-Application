package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Attribute;
import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("api")
public class RestEmployeeController {

    @Autowired
    EmployeeService empService;

    // Get all employees
    @GetMapping("/employees")
    public Iterable<Employee> showAllEmployees(){
        Iterable<Employee> employees = empService.getAllEmployees();
        return employees;
    }

    // Create a new Employee
    @PostMapping("/employees")
    public void createEmployee(@Valid @RequestBody Employee employee){
        empService.insertEmployee(employee);
    }

    // Get a single Employee By ID
    @GetMapping("/employees/{id}")
    public Employee getEmployeeById(@PathVariable(value="id") String id){
        UUID empId = UUID.fromString(id);
        return empService.getEmployeeById(empId);
    }

    // Update an Employee By ID
    @PutMapping("/employees/{id}")
    public Employee updateEmployee(@PathVariable(value="id") String id,
                                   @Valid @RequestBody Employee employee) {
        UUID empId = UUID.fromString(id);
        Employee emp = empService.getEmployeeById(empId);
        emp.setEmpName(employee.getEmpName());
        emp.setEmpDateOfHire(employee.getEmpDateOfHire());
        emp.setEmpSupervisor(employee.getEmpSupervisor());

        List<Employee> empList = employee.getEmployeesToSupervise();
        emp.setEmployeesToSupervise(empList);
        List<Attribute> empAttributesList = employee.getAttributes();
        emp.setAttributes(empAttributesList);

        empService.updateEmployee(emp);
        return emp;
    }

    // Delete an Employee By ID
    @DeleteMapping("/employees/{id}")
    public ResponseEntity<Employee> deleteEmployee(@PathVariable(value="id") String id){
        UUID empId = UUID.fromString(id);
        empService.deleteEmployeeById(empId);
        return ResponseEntity.ok().build();
    }


}

