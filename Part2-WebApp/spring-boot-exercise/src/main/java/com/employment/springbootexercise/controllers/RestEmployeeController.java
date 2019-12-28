package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

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

    // Get a single Employee
    @GetMapping("/employees/{name}")
    public Employee getEmployeeByName(@PathVariable(value="name") String name){
        return empService.getEmployeeByName(name);
    }

    // Update an Employee
    @PutMapping("/employees/{name}")
    public Employee updateEmployee(@PathVariable(value="name") String name,
                                   @Valid @RequestBody Employee employee) {
        Employee emp = empService.getEmployeeByName(name);
        emp.setEmpName(employee.getEmpName());
        emp.setEmpDateOfHire(employee.getEmpDateOfHire());
        emp.setEmpSupervisor(employee.getEmpSupervisor());

        empService.insertEmployee(emp);
        return emp;
    }

    // Delete an Employee
    @DeleteMapping("/employees/{name}")
    public ResponseEntity<Employee> deleteEmployee(@PathVariable(value="name") String name){
        Employee employee = empService.getEmployeeByName(name);
        empService.deleteEmployeeById(employee.getEmpId());
        return ResponseEntity.ok().build();
    }


}
