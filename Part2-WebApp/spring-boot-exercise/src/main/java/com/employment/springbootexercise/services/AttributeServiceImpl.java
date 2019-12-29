package com.employment.springbootexercise.services;

import com.employment.springbootexercise.model.Attribute;
import com.employment.springbootexercise.repository.AttributeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class AttributeServiceImpl implements AttributeService {

    @Autowired
    AttributeRepository attrRepo;

    @Override
    public List<Attribute> getAllAttributes() {
        List<Attribute> attributeList = attrRepo.findAll(Sort.by(Sort.Direction.ASC, "attrName"));
        return attributeList;
    }

    @Override
    public void insertAttribute(Attribute attribute) {
        attrRepo.save(attribute);

    }

    @Override
    public Attribute getAttributeByName(String name) {
        Attribute attribute = attrRepo.findAttributeByName(name);
        return attribute;
    }

    @Override
    public Attribute getAttributeById(UUID id) {
        Attribute attribute = attrRepo.findAttributeById(id);
        return attribute;
    }

    @Override
    public void deleteAttributeById(UUID attrId) {
        Attribute attribute = attrRepo.findAttributeById(attrId);
        attrRepo.delete(attribute);
    }

    @Override
    public void updateAttribute(Attribute attribute) {
        if(attrRepo.existsById(attribute.getAttrId()))
        attrRepo.save(attribute);
    }
    
}
