package com.employment.springbootexercise.services;

import com.employment.springbootexercise.model.Attribute;

import java.util.List;
import java.util.UUID;

public interface AttributeService {

    List<Attribute> getAllAttributes();

    void insertAttribute(Attribute attribute);

    Attribute getAttributeByName(String name);

    Attribute getAttributeById(UUID id);

    void deleteAttributeById(UUID attrId);

    void updateAttribute(Attribute attribute);
}
