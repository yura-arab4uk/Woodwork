package com.webstore.business.service;

public interface InfoCenter<B,A extends B> {

	A addInfo(B item);
	
}
