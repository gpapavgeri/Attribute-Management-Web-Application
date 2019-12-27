package com.employment.springbootexercise.repository;

import com.employment.springbootexercise.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, UUID> {

    @Query("SELECT e from Employee e WHERE e.empId=?1")
    Employee findEmployeeById(UUID empId);

    @Query("SELECT e FROM Employee e WHERE e.empName = ?1")
    Employee findEmployeeByName (String empName);


}
