package com.webstore.entities;

public class Category  extends Item implements Comparable<Category> {

	private String name;
	private Integer parent;
	private Integer enabled;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParent() {
		return parent;
	}
	
	public void setParent(Integer parent) {
		this.parent = parent;
	}

	public Integer getEnabled() {
		return enabled;
	}

	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Category [id=" + getId() + ", name=" + name + ", parent=" + parent + ", enabled=" + enabled + "]";
	}
	@Override
	public int compareTo(Category o) {
		
		return (this.getId() < o.getId()) ? -1 : (this.getId() == o.getId()) ? 0 : 1;
	}

}
