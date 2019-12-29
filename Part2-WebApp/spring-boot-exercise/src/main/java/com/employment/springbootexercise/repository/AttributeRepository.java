package com.employment.springbootexercise.repository;

import com.employment.springbootexercise.model.Attribute;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface AttributeRepository extends JpaRepository<Attribute, UUID> {

    @Query("SELECT a from Attribute a WHERE a.attrId=?1")
    Attribute findAttributeById(UUID attrId);

    @Query("SELECT a FROM Attribute a WHERE a.attrName = ?1")
    Attribute findAttributeByName (String attrName);

}
