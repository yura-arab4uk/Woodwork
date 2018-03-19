package com.webstore.business.service;

import com.webstore.entities.Product;

public interface ProductRepository extends Repository<Product> {
	
	public Integer[] getMinMaxPrice(Specification specification);
	public Integer getMaxId();
}