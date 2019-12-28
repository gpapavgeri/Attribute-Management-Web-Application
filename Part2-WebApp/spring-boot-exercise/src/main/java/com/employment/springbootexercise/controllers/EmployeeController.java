package com.employment.springbootexercise.controllers;

import com.employment.springbootexercise.model.Employee;
import com.employment.springbootexercise.services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService empService;

    // Load all employees
    @RequestMapping(value = "/employees", method = RequestMethod.GET)
    public String getAllEmployees(ModelMap mm){
        List<Employee> employees = empService.getAllEmployees();
        mm.addAttribute("allEmployees", employees);
        return "viewPage";
    }

    // Create employee
    @RequestMapping(value = "/employees/add", method = RequestMethod.POST)
    public String createEmployee(@RequestParam("employeeName") String employeeName,
                                 @RequestParam("employeeDateOfHire")String employeeDateOfHire,
                                 @RequestParam("supervisor") String supervisorName){

        LocalDateTime dateTimeHire = convertStringDateToLocalDateTime(employeeDateOfHire);
        Employee supervisor = empService.getEmployeeByName(supervisorName);

        Employee emp = new Employee(employeeName, dateTimeHire, supervisor);
        empService.insertEmployee(emp);
        return "redirect:/employees";
    }

    // Delete employee
    @RequestMapping(value = "/employee/delete", method = RequestMethod.POST)
    public String deleteEmployee(@RequestParam("employeeId") UUID employeeId){
        empService.deleteEmployeeById(employeeId);
        return "redirect:/employees";
    }

    // Edit employee
    @RequestMapping(value = "/employees/edit", method = RequestMethod.POST)
    public String editEmployee( @RequestParam("employeeId-edit") String employeeId,
                                @RequestParam("employeeName-edit") String employeeName,
                                @RequestParam("employeeDateOfHire-edit") String employeeDateOfHire,
                                @RequestParam("supervisor-edit") String supervisorName){

        LocalDateTime dateTimeHire = convertStringDateToLocalDateTime(employeeDateOfHire);
        Employee supervisor = empService.getEmployeeByName(supervisorName);

        Employee employeeToEdit = empService.getEmployeeById(UUID.fromString(employeeId));
        employeeToEdit.setEmpName(employeeName);
        employeeToEdit.setEmpDateOfHire(dateTimeHire);
        employeeToEdit.setEmpSupervisor(supervisor);

        empService.updateEmployee(employeeToEdit);

        return "redirect:/employees";
    }


    // Method to convert String of Date format in LocalDateTime
    public LocalDateTime convertStringDateToLocalDateTime(String inputDate){

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate dateOfHire = LocalDate.parse(inputDate, formatter);
        LocalDateTime dateTimeHire = dateOfHire.atStartOfDay();
        System.out.println("newDate of Hire is: " + dateTimeHire);

        return dateTimeHire;
    }






}
