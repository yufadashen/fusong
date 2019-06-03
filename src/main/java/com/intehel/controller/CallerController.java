package com.intehel.controller;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.intehel.model.PxView;
import com.intehel.service.CallerService;

@Controller
public class CallerController {

	@Autowired
	CallerService callerService;
	
	private static final Log log = LogFactory.getLog(CallerController.class);
	
	@GetMapping("/caller.html")
    public String hehe(ModelMap model) {
        return "caller";
    }
	
//	@RequestMapping("/getPatientList.json")
//	@ResponseBody
//	public JSONObject getPatientList(String pageNumber,String pageSize,String sectionsId) {
//		if(StringUtil.isEmpty(pageNumber)) {
//			pageNumber="1";
//		}
//		if(StringUtil.isEmpty(pageSize)) {
//			pageSize = "2";
//		}
//		List<Caller> list = callerService.getFyCallerList(pageNumber, pageSize, sectionsId);
//		JSONObject obj=new JSONObject();
////        obj.put("total",fy.getTotal());
//        obj.put("rows",list);
//		return obj;
//	}
	
	@RequestMapping("/getPatientList.json")
	@ResponseBody
	public JSONObject getPatientList(String sectionsId) {
		List<PxView> list = callerService.getCallerList(sectionsId);
		JSONObject obj=new JSONObject();
        obj.put("total","8");
        obj.put("rows",list);
		return obj;
	}
	
	@RequestMapping("/callNextPatient.json")
	public void callNextPatient(Model model, String id,String nextId) {
		try {
			callerService.callNextPatient(id,nextId);
			model.addAttribute("msg", "呼叫成功");
			model.addAttribute("state", Boolean.TRUE);
		}catch(Exception e) {
			model.addAttribute("msg", "呼叫失败");
			model.addAttribute("state", Boolean.FALSE);
			e.printStackTrace();
		}
	}
	
	
	
}
