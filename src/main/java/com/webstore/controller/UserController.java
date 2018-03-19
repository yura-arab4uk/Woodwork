package com.webstore.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.annotation.JsonAutoDetect.Visibility;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.webstore.business.functionality.CategoryLevels;
import com.webstore.business.functionality.Pagination;
import com.webstore.business.impl.specification.ByFieldSpec;
import com.webstore.business.impl.specification.CatByProdSpec;
import com.webstore.business.impl.specification.CountByFieldSpec;
import com.webstore.business.impl.specification.CountProdSearchSpec;
import com.webstore.business.impl.specification.CountProductsSpec;
import com.webstore.business.impl.specification.HomeSpec;
import com.webstore.business.impl.specification.MinMaxCatSpec;
import com.webstore.business.impl.specification.MinMaxProdSpec;
import com.webstore.business.impl.specification.ProductSearchSpec;
import com.webstore.business.impl.specification.ProductsSpec;
import com.webstore.business.service.CategoryRepository;
import com.webstore.business.service.InfoCenter;
import com.webstore.business.service.ProductRepository;
import com.webstore.business.service.Repository;
import com.webstore.entities.Category;
import com.webstore.entities.Order;
import com.webstore.entities.Product;
import com.webstore.entities.ProductInfo;
import com.webstore.entities.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class UserController {
	
	public static final Integer PAGE=1;
	public static final Integer PAMOUNT=10;
	@Autowired
	private ProductRepository prodRepository;
	@Autowired
	private CategoryRepository cRepository;
	@Autowired
	private Repository<Order> oRepository;
	@Autowired
	private Repository<User> uRepository;
	@Autowired
	private InfoCenter<Product,ProductInfo> pICenter;
	@Autowired
	private Pagination pagination;
	@Autowired
	private CategoryLevels cLevels;
	//Specification s = new GetByFieldSpec("category","parent","1","enabled","1");
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String showHomePage(Model model,
			@RequestParam(value = "p", required = false) Integer page, 
			@RequestParam(value = "pAmount", required = false) Integer pAmount)  throws JsonProcessingException  {
		if (page == null) page = UserController.PAGE;
		if (pAmount == null) pAmount = UserController.PAMOUNT;
		
		//Categories for Navbar
		Map<Integer,Set<Category>> categories = cRepository.getCategories();
		Map<Set<Integer>,Set<Category>> categoriesByLevels=cLevels.showByLevels(categories,categories.keySet().iterator().next());
		ObjectMapper mapper = new ObjectMapper();
		mapper.setVisibilityChecker(mapper.getVisibilityChecker().withFieldVisibility(Visibility.ANY));
		String categoriesJson=mapper.writeValueAsString(categoriesByLevels);
		model.addAttribute("categories", categoriesJson);
		//Pagination
		Integer numOfProducts = prodRepository.getCount(new CountByFieldSpec("product","enabled","1"));
		pagination.setAttributes(model, page, pAmount, numOfProducts);
		//Data
		model.addAttribute("products", prodRepository.query(new HomeSpec(page,pAmount)));
		return "home";
	}
	//:~
	@RequestMapping(value = "/showProducts/{catId}", method = RequestMethod.GET)
	public String showProducts(Model model, @PathVariable Integer catId,
			@RequestParam(value = "p", required = false) Integer page, 
			@RequestParam(value = "pAmount", required = false) Integer pAmount,
			@RequestParam(value = "prices", required = false) String prices,
			@RequestParam(value = "condition", required = false) String condition)  {
		if (page == null) page = UserController.PAGE;
		if (pAmount == null) pAmount = UserController.PAMOUNT;
		if (condition!=null)
		if (condition.equals("all")) condition=null;
		List<Category> allSubCategories = cRepository.getAllSubCategories(catId).get(1);
		//SubCategories menu
		List<Category> subCategories=cRepository.query(new ByFieldSpec("category","parent",catId,"enabled","1"));
		model.addAttribute("subCategories", subCategories);
		//Pagination
		int numOfProducts = prodRepository.getCount(new CountProductsSpec(allSubCategories, prices, condition, catId));
		pagination.setAttributes(model, page, pAmount, numOfProducts);
		//Data
		List<Product> products=prodRepository.query(new ProductsSpec(allSubCategories, prices, condition, catId, page, pAmount));
		model.addAttribute("products", products);
		//Filters
		Integer [] minMax = prodRepository.getMinMaxPrice(new MinMaxCatSpec(allSubCategories, catId));
		model.addAttribute("minPrice", minMax[0]);
		model.addAttribute("maxPrice", minMax[1]);
		if (prices!=null){
		String [] pricesArray = prices.split(",");
		model.addAttribute("bottomPrice", pricesArray[0]);
		model.addAttribute("topPrice", pricesArray[1]);
		}
		model.addAttribute("condition",condition);
		//Breadcrumb
		model.addAttribute("parentCategories", cRepository.getParents(new Integer(catId)));
		
		return "products";
	}
	
	@RequestMapping(value = "/showProduct/{prodId}", method = RequestMethod.GET)
	public String showProduct(Model model, @PathVariable Integer prodId) {

		List<Product> listP = prodRepository.query(new ByFieldSpec("product","enabled","1","id",prodId));
		if (!listP.isEmpty()) {
		Product product = listP.get(0);
		ProductInfo prodInfo = pICenter.addInfo(product);
		model.addAttribute("product", prodInfo);
		model.addAttribute("parentCategories", cRepository.getParents(prodInfo.getCategory_id()));
		}
		return "product";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search (Model model, 
			@RequestParam(value = "p", required = false) Integer page, 
			@RequestParam(value = "pAmount", required = false) Integer pAmount,
			@RequestParam(value = "prices", required = false) String prices,
			@RequestParam(value = "condition", required = false) String condition,
			@RequestParam(value = "q", required = false) String q,
			@RequestParam(value = "list", required = false) String list
			) {
		if (page == null) page = UserController.PAGE;
		if (pAmount == null) pAmount = UserController.PAMOUNT;
		if (condition!=null)
		if (condition.equals("all")) condition=null;
		
		//Pagination
		int numOfProducts = prodRepository.getCount(new CountProdSearchSpec(q, prices, condition,list));
		pagination.setAttributes(model, page, pAmount, numOfProducts);
		//Data
		List<Product> products=prodRepository.query(new ProductSearchSpec(q, prices, condition,list,page, pAmount));
		model.addAttribute("products", products);
		//Filters
		Integer [] minMax = prodRepository.getMinMaxPrice(new MinMaxProdSpec(q));
		model.addAttribute("minPrice", minMax[0]);
		model.addAttribute("maxPrice", minMax[1]);
		if (prices!=null){
		String [] pricesArray = prices.split(",");
		model.addAttribute("bottomPrice", pricesArray[0]);
		model.addAttribute("topPrice", pricesArray[1]);
		}
		model.addAttribute("condition",condition);
		//Search
		model.addAttribute("q",q);
		//Categories
		model.addAttribute("categories",cRepository.query(new CatByProdSpec(q, prices, condition)));
		//Active categories
		if (list!=null)
		model.addAttribute("list",list.split(","));
		return "search";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cart/processCart", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String processCart(
			@ModelAttribute("product") Product product,
			HttpSession session
			) {
		Map<Integer,Product> products = (Map<Integer,Product>)session.getAttribute("cart");
		if (products==null) 
		{
			products = new HashMap<>();
			products.put(product.getId(),product);
		}
		else if (products.get(product.getId())!=null) products.remove(product.getId());
		else products.put(product.getId(),product);
		 session.setAttribute("cart", products);
		return "{\"status\": \"ok \"}";
	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String showCart() {
		return "cart";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cart/cartContent", method = RequestMethod.GET)
	public String showCartContent(HttpSession session,
			Model model,
			@RequestParam(value = "p", required = false) Integer page, 
			@RequestParam(value = "pAmount", required = false) Integer pAmount
			) {
		if (page == null) page = UserController.PAGE;
		if (pAmount == null) pAmount = UserController.PAMOUNT;
		//Pagination
		Map<Integer,Product> products=(Map<Integer,Product>)session.getAttribute("cart");
		int numOfProducts=0;
		List<Product> pCart = new ArrayList<>();
		if (products!=null) {
			Integer offset = (page - 1) * pAmount;
			List<Product> cart = new ArrayList<>(products.values());
			for (int i=offset;i<offset+pAmount;i++) {
				if (i>=cart.size()) break;
				Product p=cart.get(i);
				pCart.add(p);
			}
			session.setAttribute("pCart", pCart);
			numOfProducts = products.size();
		}
		pagination.setAttributes(model, page, pAmount, numOfProducts);
		return "cartcontent";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cart/addOrder", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String addOrder(@RequestParam("prodId") Integer prodId,
			HttpSession session
			) {
		Map<Integer,Product> products=(Map<Integer,Product>)session.getAttribute("cart");
		if (products!=null)
		products.remove(prodId);
		session.setAttribute("cart", products);
		Order order = new Order();
		order.setProduct_id(prodId);
		order.setStatus_id(1);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		User user = uRepository.query(new ByFieldSpec("user","enabled","1","email",userDetail.getUsername())).get(0);
		order.setUser_id(user.getId());
		order.setDate(new Date());
		oRepository.add(order);
		return "{\"status\": \"ok \"}";
	}
	
}
