package com.webstore.entities;

import java.util.Date;

public class Order extends Item {

	private Integer user_id;
	private Integer product_id;
	private Date date;
	private Integer status_id;
	private String status_description;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getStatus_id() {
		return status_id;
	}

	public void setStatus_id(Integer status_id) {
		this.status_id = status_id;
	}

	public String getStatus_description() {
		return status_description;
	}

	public void setStatus_description(String status_description) {
		this.status_description = status_description;
	}

	@Override
	public String toString() {
		return "Order [id=" + getId() + ", user_id=" + user_id + ", product_id=" + product_id + ", date=" + date + ", status_id=" + status_id + ", status_description=" + status_description + "]";
	}


}
