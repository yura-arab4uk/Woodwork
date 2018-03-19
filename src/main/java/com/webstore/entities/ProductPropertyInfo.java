package com.webstore.entities;

import org.springframework.stereotype.Service;

@Service
public class ProductPropertyInfo extends ProductProperty {

	private Product product;
	private Property property;
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Property getProperty() {
		return property;
	}
	public void setProperty(Property property) {
		this.property = property;
	}
	@Override
	public String toString() {
		return "ProductPropertyInfo [ "+super.toString()+" product=" + product + ", property=" + property + "]";
	}
	
}
