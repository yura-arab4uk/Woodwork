package com.webstore.business.impl.info;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webstore.business.impl.specification.ByFieldSpec;
import com.webstore.business.service.InfoCenter;
import com.webstore.business.service.Repository;
import com.webstore.entities.Product;
import com.webstore.entities.ProductInfo;
import com.webstore.entities.ProductProperty;
import com.webstore.entities.ProductPropertyInfo;

@Service("pICenter")
public class ProductInfoCenter implements InfoCenter<Product, ProductInfo> {

	@Autowired
	private ProductInfo pInfo;
	@Autowired
	private Repository<ProductProperty> pPRepository;
	@Autowired
	private InfoCenter<ProductProperty,ProductPropertyInfo> pPICenter;
	
	public ProductInfo addInfo(Product p){
	pInfo.setId(p.getId());
	pInfo.setName(p.getName());
	pInfo.setDescription(p.getDescription());
	pInfo.setCondition(p.getCondition());
	pInfo.setCategory_id(p.getCategory_id());
	pInfo.setPrice(p.getPrice());
	pInfo.setImage(p.getImage());
	pInfo.setEnabled(p.getEnabled());
	List<ProductProperty> listPP = pPRepository.query(new ByFieldSpec("product_has_property","enabled","1","product_id",p.getId()));
	List<ProductPropertyInfo> listPPI = new ArrayList<>();
	for(ProductProperty pP:listPP) {
		listPPI.add(pPICenter.addInfo(pP));
	}
	pInfo.setListPPI(listPPI);
		return pInfo;
	}

}
