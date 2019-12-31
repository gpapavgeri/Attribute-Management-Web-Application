package com.employment.springbootexercise.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.UUID;

@Entity
public class Attribute {

    @Id
    @NotNull
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    private UUID attrId;

    @NotNull
    private String attrName;

    @NotNull
    private String attrValue;

    @JsonProperty
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name="employeeattribute",
            joinColumns = @JoinColumn(name="EMPATTR_AttributeID"),
            inverseJoinColumns = @JoinColumn(name="EMPATTR_EmployeeID"))
    private List<Employee> employees;

    public Attribute() {
    }

    public UUID getAttrId() {
        return attrId;
    }

    public void setAttrId(UUID attrId) {
        this.attrId = attrId;
    }

    public String getAttrName() {
        return attrName;
    }

    public void setAttrName(String attrName) {
        this.attrName = attrName;
    }

    public String getAttrValue() {
        return attrValue;
    }

    public void setAttrValue(String attrValue) {
        this.attrValue = attrValue;
    }

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    public List<Employee> getEmployees() {
        return employees;
    }


    public void setEmployees(List<Employee> employees) {
        this.employees = employees;
    }

    @Override
    public String toString() {
        return "Attribute{" +
                "attrName='" + attrName + '\'' +
                ", attrValue='" + attrValue + '\'' +
                '}';
    }
}
