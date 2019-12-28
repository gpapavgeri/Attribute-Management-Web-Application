package com.employment.springbootexercise.model;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
public class Employee implements Serializable {

    @Id
    @NotNull
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    private UUID empId;

    @NotNull
    private String empName;

    @NotNull
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime empDateOfHire;

    @ManyToOne
    @JoinColumn(name="EMP_Supervisor")
    private Employee empSupervisor;

    public Employee() {
    }

    public Employee(String empName, LocalDateTime empDateOfHire, Employee empSupervisor) {
        this.empName = empName;
        this.empDateOfHire = empDateOfHire;
        this.empSupervisor = empSupervisor;
    }

    public UUID getEmpId() {
        return empId;
    }

    public void setEmpId(UUID empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public LocalDateTime getEmpDateOfHire() {
        return empDateOfHire;
    }

    public void setEmpDateOfHire(LocalDateTime empDateOfHire) {
        this.empDateOfHire = empDateOfHire;
    }

    public Employee getEmpSupervisor() { return empSupervisor; }

    public void setEmpSupervisor(Employee empSupervisor) {
        this.empSupervisor = empSupervisor;
    }
}
