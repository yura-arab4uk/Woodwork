package com.woodwork.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.woodwork.business.impl.specification.ByFieldSpec;
import com.woodwork.business.service.Repository;
import com.woodwork.entities.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CommonController {
	
	@Autowired
	private Repository<User> uRepository;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout
			) {
		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username or password!");
		}
		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully!");
		}
		model.setViewName("login");
		return model;
	}
	
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public String registrationView(Map<String, Object> model) {
		model.put("user", new User());
		return "registration";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@Valid @ModelAttribute User user,BindingResult bResult,HttpSession session) {
		if (bResult.hasErrors()) return "registration";
		uRepository.add(user);
		user.setPassword(null);
		session.setAttribute("user", user);
		return "redirect:/regSuccess";
	}
	
	@RequestMapping(value = "/isEmailFree", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String emailCheker(
			@RequestParam(value = "email", required = false) String email) {
		List<User> users=uRepository.query(new ByFieldSpec("user","email",email));
		boolean theSameEmail = !users.isEmpty();
		return "{\"status\":"+ theSameEmail + "}";
	}
	
	@RequestMapping(value = "/isLoginFree", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public @ResponseBody String loginCheker(
			@RequestParam(value = "login", required = false) String login) {
		List<User> users=uRepository.query(new ByFieldSpec("user","login",login));
		boolean theSameLogin = !users.isEmpty();
		return "{\"status\":"+ theSameLogin + "}";
	}
	
	@RequestMapping(value = "/regSuccess", method = RequestMethod.GET)
	public String regSuccess(Map<String, Object> model,HttpSession session) {
		model.put("user", session.getAttribute("user"));
		session.removeAttribute("user");
		return "regsuccess";
	}
	
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {
		ModelAndView model = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);
			model.addObject("username", userDetail.getUsername());
		}
		model.setViewName("403");
		return model;
	}
	
}
