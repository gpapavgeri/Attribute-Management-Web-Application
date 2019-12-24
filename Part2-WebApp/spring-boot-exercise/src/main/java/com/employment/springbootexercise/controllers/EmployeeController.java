package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api")
public class EmployeeController {

    @Autowired
    EmployeeRepository employeeRepository;

    @GetMapping("/employees")
    public List<Employee> showEmployees(){
        List<Employee> employees = employeeRepository.findAll();
        return employees;
    }
}
