package com.woodwork.business.functionality;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class Pagination {
	
public void setAttributes(Model model,Integer page,Integer pAmount,Integer numOfItems){
	int numOfPages = (int) Math.ceil(numOfItems * 1.0 / pAmount);
	model.addAttribute("page", page);
	model.addAttribute("numOfPages", numOfPages);
	model.addAttribute("pAmount", pAmount);
}

}
