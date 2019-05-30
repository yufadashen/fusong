package com.intehel.service;

import java.util.List;
import com.intehel.common.web.FyPageObject;
import com.intehel.entity.Caller;
import com.intehel.entity.PxView;

public interface CallerService {

	List<PxView> getFyCallerList(String sectionsId);
	
	List<PxView> getCallerList(String sectionsId);
	
	void callNextPatient(String id,String nextId);
	
}
