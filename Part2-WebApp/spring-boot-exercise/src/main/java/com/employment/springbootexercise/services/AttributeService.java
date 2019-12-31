package com.employment.springbootexercise.services;

import com.employment.springbootexercise.model.Attribute;

import java.util.List;
import java.util.UUID;

public interface AttributeService {

    List<Attribute> getAllAttributes();

    Attribute getAttributeById(UUID id);

    void insertAttribute(Attribute attribute);

    void updateAttribute(Attribute attribute);

    void deleteAttributeById(UUID attrId);
}
