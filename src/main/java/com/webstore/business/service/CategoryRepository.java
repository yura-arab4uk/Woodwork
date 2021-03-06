package com.webstore.business.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.webstore.entities.Category;

public interface CategoryRepository extends Repository<Category> {
	
	Set<Category> getParents(Integer id);
	Map<Integer,Set<Category>> getCategories ();
	List<List<Category>> getAllSubCategories(Integer id);
	List<Category> getLastCategories ();
}