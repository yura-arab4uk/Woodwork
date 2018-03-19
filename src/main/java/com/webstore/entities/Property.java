package com.webstore.entities;

public class Property extends Item {

	private String name;
	private String type;
	private Integer enabled;

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Property [id=" + getId() + ", name=" + name + ", type=" + type + ", enabled=" + enabled + "]";
	}


}
