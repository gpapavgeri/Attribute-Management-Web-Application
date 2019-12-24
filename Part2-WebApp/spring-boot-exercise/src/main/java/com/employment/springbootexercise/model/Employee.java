package com.employment.springbootexercise.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "employee")
public class Employee implements Serializable {

    @Id
    @Column(name = "EMP_ID")
    private String emp_id;

    @Column(name = "EMP_Name")
    private String emp_name;

    @Column(name = "EMP_DateOfHire")
    @DateTimeFormat(iso=DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime emp_dateOfHire;

    @Column(name = "EMP_Supervisor")
    private String emp_supervisor;

    public Employee(){

    }

    public Employee(String emp_id) {
        this.emp_id = emp_id;
    }

    public Employee(String emp_id, String emp_name, LocalDateTime emp_dateOfHire, String emp_supervisor) {
        this.emp_id = emp_id;
        this.emp_name = emp_name;
        this.emp_dateOfHire = emp_dateOfHire;
        this.emp_supervisor = emp_supervisor;
    }

    public String getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public String getEmp_name() {
        return emp_name;
    }

    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
    }

    public LocalDateTime getEmp_dateOfHire() {
        return emp_dateOfHire;
    }

    public void setEmp_dateOfHire(LocalDateTime emp_dateOfHire) {
        this.emp_dateOfHire = emp_dateOfHire;
    }

    public String getEmp_supervisor() {
        return emp_supervisor;
    }

    public void setEmp_supervisor(String emp_supervisor) {
        this.emp_supervisor = emp_supervisor;
    }
}
