package com.woodwork.entities;

public class CategoryProperty {

	private Integer category_id;
	private Integer property_id;
	private Integer enabled;

	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public Integer getProperty_id() {
		return property_id;
	}

	public void setProperty_id(Integer property_id) {
		this.property_id = property_id;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "CategoryProperty [category_id=" + category_id + ", property_id=" + property_id + ", enabled=" + enabled + "]";
	}

}
