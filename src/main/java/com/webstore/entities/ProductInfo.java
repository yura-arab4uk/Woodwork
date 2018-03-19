package com.webstore.entities;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class ProductInfo extends Product {

	private List<ProductPropertyInfo> listPPI;

	public List<ProductPropertyInfo> getListPPI() {
		return listPPI;
	}

	public void setListPPI(List<ProductPropertyInfo> listPPI) {
		this.listPPI = listPPI;
	}

	@Override
	public String toString() {
		return "ProductInfo [ "+super.toString()+" listPPI=" + listPPI + "]";
	}
	
}
