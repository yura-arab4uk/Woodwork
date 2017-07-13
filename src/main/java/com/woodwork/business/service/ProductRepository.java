package com.woodwork.business.service;

import com.woodwork.entities.Product;

public interface ProductRepository extends Repository<Product> {
	
	public Integer[] getMinMaxPrice(Specification specification);
	public Integer getMaxId();
}