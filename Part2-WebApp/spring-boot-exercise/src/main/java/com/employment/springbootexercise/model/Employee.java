package com.employment.springbootexercise.model;

import com.fasterxml.jackson.annotation.JsonProperty;
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

    @JsonProperty
    @ManyToOne
    @JoinColumn(name="EMP_Supervisor")
    private Employee empSupervisor;

    @JsonProperty
    @OneToMany(mappedBy="empSupervisor", fetch = FetchType.LAZY)
    private List<Employee> employeesToSupervise;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name="employeeattribute",
            joinColumns = @JoinColumn(name="EMPATTR_EmployeeID"),
            inverseJoinColumns = @JoinColumn(name="EMPATTR_AttributeID"))
    private List<Attribute> attributes;

    public Employee() {
    }

    @PreRemove
    private void preRemove() {
        for (Employee e : employeesToSupervise) {
            e.setEmpSupervisor(null);
        }
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

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    public Employee getEmpSupervisor() { return empSupervisor; }

    public void setEmpSupervisor(Employee empSupervisor) {
        this.empSupervisor = empSupervisor;
    }

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    public List<Employee> getEmployeesToSupervise() {
        return employeesToSupervise;
    }

    public List<Attribute> getAttributes() {
        return attributes;
    }

    public void setAttributes(List<Attribute> attributes) {
        this.attributes = attributes;
    }

    public void setEmployeesToSupervise(List<Employee> employeesToSupervise) {
        this.employeesToSupervise = employeesToSupervise;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empName='" + empName + '\'' +
                ", empDateOfHire=" + empDateOfHire +
                ", empSupervisor=" + empSupervisor +
                '}';
    }


}
