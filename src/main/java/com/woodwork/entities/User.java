package com.woodwork.entities;

import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class User extends Item {

	@NotEmpty(message="Заповніть поле email")
	@Email(message = "Невірна email-адреса")
	private String email;
	@NotEmpty(message="Заповніть поле login")
	@Size(max = 45, message = "Максимальна довжина поля login - 45 символів")
	private String login;
	@NotNull(message="Заповніть поле phone number")
	@Max(value = 999999999, message = "Введіть номер телефону на прикладі - 097XXXXXXX")
	private Integer phone_number;
	@NotEmpty(message="Заповніть поле first name")
	@Size(max = 45, message = "Максимальна довжина поля ім'я - 45 символів")
	private String firstname;
	@NotEmpty(message="Заповніть поле last name")
	@Size(max = 45, message = "Максимальна довжина поля lastname - 45 символів")
	private String lastname;
	private Integer enabled;
	@Size(min=6,max = 45, message = "Довжина поля password від 6 до 45 символів")
	private String password;
	private String role;
	

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getLogin() {
		return login;
	}
	
	public void setLogin(String login) {
		this.login = login;
	}

	public Integer getPhone_number() {
		return phone_number;
	}
	
	public void setPhone_number(Integer phone_number) {
		this.phone_number = phone_number;
	}

	public String getFirstname() {
		return firstname;
	}
	
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}
	
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getEnabled() {
		return enabled;
	}
	
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	@Override
	public String toString() {
		return "User [id="+getId()+", email=" + email + ", login=" + login + ", phone_number=" + phone_number + ", firstname=" + firstname + ", lastname=" + lastname + ", enabled=" + enabled + ", password=" + password + ", role=" + role + "]";
	}

}
