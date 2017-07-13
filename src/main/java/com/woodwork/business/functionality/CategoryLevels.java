package com.woodwork.business.functionality;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.stereotype.Service;

import com.woodwork.entities.Category;

@Service
public class CategoryLevels {
	
public Map<Set<Integer>,Set<Category>> showByLevels(Map<Integer,Set<Category>> map,Integer topCategoryId) {
	
	Set <Category> listC=map.get(topCategoryId);
	Map<Set<Integer>,Set<Category>> mapResult = new LinkedHashMap<>();
	
	do{
		Set <Integer> result1=new TreeSet<>();
		Set <Category> result2=new TreeSet<>();
	for (Category c:listC){
		Set<Category> subs = map.get(c.getId());
		if (subs!=null)
		for(Category cc:subs) {
			result1.add(cc.getParent());
			result2.add(cc);
			
		}
	}
	if (result1.size()>0) mapResult.put(result1, result2);
	listC=new TreeSet<>(result2);
	
	}while (listC.size()>0);
	return mapResult;
}

}
