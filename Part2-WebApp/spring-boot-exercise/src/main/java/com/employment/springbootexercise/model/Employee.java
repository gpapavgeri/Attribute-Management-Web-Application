package com.employment.springbootexercise.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;
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

    @JsonIgnore
    @ManyToOne(cascade= {CascadeType.PERSIST, CascadeType.MERGE,
            CascadeType.DETACH, CascadeType.REFRESH})
    @JoinColumn(name="EMP_Supervisor")
    private Employee empSupervisor;

    @OneToMany(mappedBy="empSupervisor",
            cascade= {CascadeType.PERSIST, CascadeType.MERGE,
                    CascadeType.DETACH, CascadeType.REFRESH})
    private List<Employee> employeesToSupervise;

    public Employee() {
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

    public List<Employee> getEmployeesToSupervise() {
        return employeesToSupervise;
    }

    public void setEmployeesToSupervise(List<Employee> employeesToSupervise) {
        this.employeesToSupervise = employeesToSupervise;
    }

    @Override
    public String toString() {
        return
                "empName= " + empName + '\'';
    }
}
