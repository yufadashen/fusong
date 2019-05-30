package com.intehel.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.intehel.entity.PxView;
import com.intehel.entity.User;
import com.intehel.service.CallerService;

@Controller
public class MriController {
	
	@Autowired
	CallerService callerService;
	
	private static final Log log = LogFactory.getLog(MriController.class);
	

	@GetMapping("/mritable")
    public String hehe(Model model,String sectionsId) {
		List<PxView> list = callerService.getFyCallerList("1");
        model.addAttribute("viewList", list);
        return "table";
    }
	
	
	
}
