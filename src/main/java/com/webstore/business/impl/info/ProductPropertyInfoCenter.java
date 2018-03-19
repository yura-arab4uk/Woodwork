package com.webstore.business.impl.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webstore.business.impl.specification.ByFieldSpec;
import com.webstore.business.service.InfoCenter;
import com.webstore.business.service.ProductRepository;
import com.webstore.business.service.Repository;
import com.webstore.entities.ProductProperty;
import com.webstore.entities.ProductPropertyInfo;
import com.webstore.entities.Property;

@Service("pPICenter")
public class ProductPropertyInfoCenter implements InfoCenter<ProductProperty,ProductPropertyInfo> {

	@Autowired
	private ProductPropertyInfo pPInfo;
	@Autowired
	private ProductRepository prodRepository;
	@Autowired
	private Repository<Property> propRepository;
	
	
	public ProductPropertyInfo addInfo(ProductProperty pP) {
		pPInfo.setProduct_id(pP.getProduct_id());
		pPInfo.setValue_as_string(pP.getValue_as_string());
		pPInfo.setProperty_id(pP.getProperty_id());
		pPInfo.setEnabled(pP.getEnabled());
		pPInfo.setProduct(prodRepository.query(new ByFieldSpec("product","enabled","1","id",pP.getProduct_id())).get(0));
		pPInfo.setProperty(propRepository.query(new ByFieldSpec("property","enabled","1","id",pP.getProperty_id())).get(0));
		return pPInfo;
	}
	
}
