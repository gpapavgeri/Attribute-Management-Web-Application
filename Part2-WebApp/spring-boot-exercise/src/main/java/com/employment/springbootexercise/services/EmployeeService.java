package com.employment.springbootexercise.services;

import com.employment.springbootexercise.model.Employee;

import java.util.List;
import java.util.UUID;

public interface EmployeeService {

    List<Employee> getAllEmployees();

    void insertEmployee(Employee emp);

    Employee getEmployeeByName(String name);

    Employee getEmployeeById(UUID id);

    void deleteEmployeeById(UUID empId);

    void updateEmployee(Employee emp);
}
