package com.employment.springbootexercise.services;

import com.employment.springbootexercise.model.Employee;

import java.util.List;
import java.util.UUID;

public interface EmployeeService {

    List<Employee> getAllEmployees();

    Employee getEmployeeById(UUID id);

    Employee getEmployeeByName(String name);

    void insertEmployee(Employee emp);

    void updateEmployee(Employee emp);

    void deleteEmployeeById(UUID empId);
}
