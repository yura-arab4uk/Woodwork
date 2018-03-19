package com.webstore.entities;

public class ProductProperty {

	
	private Integer product_id;
	private Integer property_id;
	private String value_as_string;
	private Integer enabled;
	
	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getProperty_id() {
		return property_id;
	}
	
	public void setProperty_id(Integer property_id) {
		this.property_id = property_id;
	}

	public String getValue_as_string() {
		return value_as_string;
	}
	
	public void setValue_as_string(String value_as_string) {
		this.value_as_string = value_as_string;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	
	@Override
	public String toString() {
		return "ProductProperty [product_id=" + product_id + ", property_id=" + property_id + ", value_as_string=" + value_as_string + ", enabled=" + enabled + "]";
	}

}
