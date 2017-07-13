package com.woodwork.entities;

public class Status extends Item {

	private String name;
	private Integer enabled;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Status [id=" + getId() + ", name=" + name + ", enabled=" + enabled + "]";
	}

}
