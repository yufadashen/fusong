package com.intehel.service;

import java.util.List;

import com.intehel.model.PxView;

public interface CallerService {

	List<PxView> getFyCallerList(String sectionsId);
	
	List<PxView> getCallerList(String sectionsId);
	
	void callNextPatient(String id,String nextId);
	
}
