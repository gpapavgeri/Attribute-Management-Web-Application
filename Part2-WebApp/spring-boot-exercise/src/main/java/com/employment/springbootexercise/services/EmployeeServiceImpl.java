package com.employment.springbootexercise.services;

import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    EmployeeRepository empRepo;

    @Override
    public List<Employee> getAllEmployees() {
        List<Employee> employeesList = empRepo.findAll(Sort.by(Sort.Direction.ASC, "empName"));
        return employeesList;
    }

    @Override
    public void insertEmployee(Employee emp) {
        empRepo.save(emp);
    }

    @Override
    public Employee getEmployeeByName(String name) {
        Employee employee = empRepo.findEmployeeByName(name);
        return employee;
    }

    @Override
    public Employee getEmployeeById(UUID id) {
        Employee employee = empRepo.findEmployeeById(id);
        return employee;
    }

    @Override
    public void deleteEmployeeById(UUID empId) {
        Employee emp = empRepo.findEmployeeById(empId);
        empRepo.delete(emp);
    }

    @Override
    public void updateEmployee(Employee emp) {
        if(empRepo.existsById(emp.getEmpId()))
        empRepo.save(emp);
    }
}
