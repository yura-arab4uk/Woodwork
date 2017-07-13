package com.woodwork.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.woodwork.business.functionality.CategoryLevels;
import com.woodwork.business.functionality.Pagination;
import com.woodwork.business.functionality.WWFile;
import com.woodwork.business.impl.specification.ByFieldSpec;
import com.woodwork.business.impl.specification.CatPropSpec;
import com.woodwork.business.impl.specification.CountByFieldSpec;
import com.woodwork.business.impl.specification.CountUserSearchSpec;
import com.woodwork.business.impl.specification.PropertySpec;
import com.woodwork.business.impl.specification.UserSpec;
import com.woodwork.business.service.CategoryRepository;
import com.woodwork.business.service.ProductRepository;
import com.woodwork.business.service.Repository;
import com.woodwork.entities.Category;
import com.woodwork.entities.CategoryProperty;
import com.woodwork.entities.Product;
import com.woodwork.entities.ProductProperty;
import com.woodwork.entities.Property;
import com.woodwork.entities.User;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private Repository<Property> propRepository;
	@Autowired
	private ProductRepository prodRepository;
	@Autowired
	private Repository<User> uRepository;
	@Autowired
	private CategoryRepository cRepository;
	@Autowired
	private Repository<CategoryProperty> cPRepository;
	@Autowired
	private Repository<ProductProperty> pPRepository;
	@Autowired
	private Pagination pagination;
	@Autowired
	private CategoryLevels cLevels;
	@Autowired
	private WWFile wWFile;
	//Specification s = new GetByFieldSpec("category","parent","1","enabled","1");
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public ModelAndView profile() {
		ModelAndView model = new ModelAndView();
		model.setViewName("admin");
		
		return model;
	}
	
	@RequestMapping(value = "/editUserView", method = RequestMethod.GET)
	public String editUserView(
			@RequestParam(value = "p", required = false) Integer page, 
			@RequestParam(value = "pAmount", required = false) Integer pAmount,
			@RequestParam(value = "q", required = false) String q,
			@RequestParam(value = "order", required = false) String order,
			Model model) throws JsonProcessingException  {
		if (page == null) page = UserController.PAGE;
		if (pAmount == null) pAmount = UserController.PAMOUNT;
		
		Integer numOfProducts = uRepository.getCount(new CountUserSearchSpec(q));
		pagination.setAttributes(model, page, pAmount, numOfProducts);
		
		
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibilityChecker(mapper.getVisibilityChecker().withFieldVisibility(Visibility.ANY));
		String usersJson=mapper.writeValueAsString(uRepository.query(new UserSpec(q,order,page,pAmount)));
		model.addAttribute("users",usersJson);
		//Search
		model.addAttribute("q",q);
		//Order
		model.addAttribute("order",order);
		return "edituser";
	}
	
	@RequestMapping(value = "/editUser", method = RequestMethod.POST)
	public String editUser(
			@ModelAttribute User user
			) {
		
		uRepository.update(user);
		return "redirect:/admin";
	}
	
	@RequestMapping(value = "/activateUser", method = RequestMethod.PUT, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String activateUser(
			@ModelAttribute User user
			) {
		uRepository.update(user);
		return "{\"status\": \"ok \"}";
	}
	
	@RequestMapping(value = "/editCategoryView", method = RequestMethod.GET)
	public String editCategoryView(Model model) throws JsonProcessingException  {
		
		Map<Integer,Set<Category>> categories = cRepository.getCategories();
		Map<Set<Integer>,Set<Category>> categoriesByLevels=cLevels.showByLevels(categories,categories.keySet().iterator().next());
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibilityChecker(mapper.getVisibilityChecker().withFieldVisibility(Visibility.ANY));
		String categoriesJson=mapper.writeValueAsString(categoriesByLevels);
		model.addAttribute("categories", categoriesJson);
		return "editcategory";
	}
	
	@RequestMapping(value = "/addCategory", method = RequestMethod.PUT, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String addCategory(
			@ModelAttribute Category category
			) {
		cRepository.add(category);
		return "{\"status\": \"ok \"}";
	}
	
	@RequestMapping(value = "/removeCategory", method = RequestMethod.DELETE, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String removeCategory(
			@ModelAttribute Category category
			) {
		cRepository.remove(category);
		return "{\"status\": \"ok \"}";
	}
	
	@RequestMapping(value = "/editPropertyView", method = RequestMethod.GET)
	public String editPropertyView(
			@RequestParam(value = "p", required = false) Integer page, 
			@RequestParam(value = "pAmount", required = false) Integer pAmount,
			Model model) throws JsonProcessingException  {
		if (page == null) page = UserController.PAGE;
		if (pAmount == null) pAmount = UserController.PAMOUNT;
		Integer numOfProducts = propRepository.getCount(new CountByFieldSpec("property"));
		pagination.setAttributes(model, page, pAmount, numOfProducts);
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibilityChecker(mapper.getVisibilityChecker().withFieldVisibility(Visibility.ANY));
		String propertiesJson=mapper.writeValueAsString(propRepository.query(new PropertySpec(page,pAmount)));
		model.addAttribute("properties", propertiesJson);
		List<Category> categories=cRepository.query(new ByFieldSpec("category","enabled","1"));
		model.addAttribute("categories", categories);
		return "editproperty";
	}
	
	@RequestMapping(value = "/activateProperty", method = RequestMethod.PUT, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String activateProperty(
			@ModelAttribute Property property
			) {
		List<CategoryProperty> listCp=cPRepository.query(new ByFieldSpec("category_has_property","property_id",property.getId()));
		for (CategoryProperty cp:listCp) {
			cp.setEnabled(property.getEnabled());
			cPRepository.update(cp);
		}
		propRepository.update(property);
		return "{\"status\": \"ok \"}";
	}
	
	@RequestMapping(value = "/addProperty", method = RequestMethod.PUT, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String addProperty(
			@ModelAttribute Property property,
			@RequestParam(value = "catId", required = false) Integer catId
			) {
		propRepository.add(property);
		property=propRepository.query(new ByFieldSpec("property","name",property.getName())).get(0);
		CategoryProperty cp=new CategoryProperty();
		cp.setCategory_id(catId);
		cp.setProperty_id(property.getId());
		cPRepository.add(cp);
		return "{\"status\": \"ok \"}";
	}
	
	@RequestMapping(value = "/addProductView", method = RequestMethod.GET)
	public String addProductView(Model model) {
		
		model.addAttribute("categories",cRepository.getLastCategories());
		
		return "addproduct";
	}
	
	@RequestMapping(value = "/getProperties", method = RequestMethod.GET, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String getProperties(
			@RequestParam(value = "catId") Integer catId,Model model
			) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibilityChecker(mapper.getVisibilityChecker().withFieldVisibility(Visibility.ANY));
		Set<Category> categories=cRepository.getParents(catId);
		String properties=mapper.writeValueAsString(propRepository.query(new CatPropSpec(categories)));
		return properties;
	}
	
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String addProduct(
			@ModelAttribute Product p,
			@RequestParam(value="propIds",required=false) List<Integer> propIds,
			@RequestParam(value="sValues",required=false) List<String> sValues,
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request
			) {
		//System.out.println(request.getContextPath());
		String newName = (prodRepository.getMaxId()+1)+".png";
		wWFile.saveFile(file,request,newName);
		p.setImage(newName);
		prodRepository.add(p);
		p=prodRepository.query(new ByFieldSpec("product","name",p.getName())).get(0);
		List<ProductProperty> listPP=new ArrayList<>();
		if (propIds!=null)
		{
		for (int i=0;i<propIds.size();i++) {
			ProductProperty pp=new ProductProperty();
			pp.setProduct_id(p.getId());
			pp.setProperty_id(propIds.get(i));
			pp.setValue_as_string(sValues.get(i));
			listPP.add(pp);
		}
		pPRepository.add(listPP);
		}
		return "{\"status\": \"ok \"}";
	}
	
}
