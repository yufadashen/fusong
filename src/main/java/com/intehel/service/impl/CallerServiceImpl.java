package com.intehel.service.impl;

import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.util.StringUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.util.StringUtil;
import com.intehel.common.util.pool.Constant;
import com.intehel.common.util.pool.RunThreadPool;
import com.intehel.common.util.pool.ThreadPool;
import com.intehel.dao.CallerMapper;
import com.intehel.dao.ClinicMapper;
import com.intehel.dao.PxViewMapper;
import com.intehel.dao.StationMapper;
import com.intehel.entity.Caller;
import com.intehel.entity.Clinic;
import com.intehel.entity.PxView;
import com.intehel.entity.Station;
import com.intehel.service.CallerService;

@Service("callerService")
public class CallerServiceImpl extends BaseServiceImpl<Caller> implements CallerService{

	@Autowired
	private CallerMapper callerMapper;
	@Autowired
	private ClinicMapper clinicMapper;
	@Autowired
	private StationMapper stationMapper;
	@Autowired
	private PxViewMapper pxViewMapper;
	
//	@Override
//	public FyPageObject findPageObjects(Integer pageCurrent) {
//		int pageSize=2;
//	    int startIndex=(pageCurrent-1)*pageSize;
//	    int rowCount = callerMapper.getRowCount();
//	    int pageCount=rowCount/pageSize;
//	    if(rowCount%pageSize!=0){
//	    	pageCount++;
//	    }
//	    List<Caller> list = callerMapper.list(startIndex,pageSize);
//	    List<Map<String,String>> fyList = new ArrayList();
//	    Map<String,String> map =null;
//	    for(Caller ele:list) {
//			map =  new HashMap();
//			map.put("id", ele.getId());
//			map.put("requisitionId", ele.getRequisitionId());
//			map.put("patienId", ele.getPatienId());
//			map.put("name", ele.getName());
//			map.put("sex", ele.getSex());
//			map.put("emergency", ele.getEmergency());
//			map.put("reqDepartment", ele.getReqDepartment());
//			map.put("departmentId", ele.getDepartmentId());
//			fyList.add(map);
//		}
//	    
//		FyPageObject fy=new FyPageObject();
//		int total = callerMapper.getRowCount();
//		fy.setRows(fyList);
//	    fy.setTotal(total);
//		return fy;
//	}

	/**
	 * 
	 * @param pageNumber
	 * @param perPageNum
	 * @param sectionsId 科室id
	 * @return
	 */
	@Override
	public List<PxView> getFyCallerList(String sectionsId) {
		PageHelper.startPage(1, 5);
		List<PxView> list = callerMapper.getCallerList(sectionsId);
		return list;
	}
	public List<PxView> getCallerList(String sectionsId) {
		List<PxView> list = callerMapper.getCallerList(sectionsId);
		
		return list;
	}

	@Override
//	@Transactional(rollbackFor = Exception.class)
	public void callNextPatient(String id,String nextId) {
		if(StringUtil.isNotEmpty(id) && StringUtils.isNumber(id)) {
			PxView view = pxViewMapper.selectByPrimaryKey(Integer.parseInt(id));
			if(view!=null) {
				String patientName = view.getPtnName();//当前呼叫病人的姓名
				String patientQueue = view.getRequisitionId(); //检查号
	//			String stationIp = "http://" + "192.168.0.103" + ":801/?";
				String stationIp = "http://" + "127.0.0.1" + ":801/?";
				String infoSound = "请" + patientQueue + "号，" + patientName + "，到";
				infoSound = infoSound + "1号诊室" + "就诊";
	//			if (StringUtil.isNotEmpty(clinicName)){
	//				infoSound = infoSound + clinicName + "就诊";
	//				infoUpWindow = infoUpWindow + clinicName + "就诊";
	//			}else{
	//				infoSound = infoSound + clinic.getClinicNo() + "诊室就诊";
	//				infoUpWindow = infoUpWindow + clinic.getClinicNo() + "诊室就诊";
	//			}
				//http://172.50.64.13:801/?Func=Sound_Play&Info=请13号，杨秀清，到妇科诊室3就诊，请00003号，沈佳，到妇科诊室3准备就诊
				String url_sound = stationIp + "Func=Sound_Play&Info=" + infoSound + "";
				String url_bScreenDisplay = "";
				String url_upWindowDisplay = "";
				String url_downWindowDisplay = "";
				String url_normalScreenDisplay = "";
				ThreadPool threadPool = ThreadPool.getThreadPool(5);
				threadPool.execute(new Thread[] { new RunThreadPool(url_sound), new RunThreadPool(url_bScreenDisplay), new RunThreadPool(url_upWindowDisplay), new RunThreadPool(url_downWindowDisplay), new RunThreadPool(url_normalScreenDisplay) });
	//			Constant.threadPool.execute(new Thread[] { new RunThreadPool(url_sound), new RunThreadPool(url_bScreenDisplay), new RunThreadPool(url_upWindowDisplay), new RunThreadPool(url_downWindowDisplay), new RunThreadPool(url_normalScreenDisplay) });
				ExecutorService newFixedThreadPool = Executors.newFixedThreadPool(5);
				for (int i = 0; i < 10; i++) {
				    final int index = i;
				    newFixedThreadPool.execute(new Runnable() {
				        @Override
				        public void run() {
				            try {
				                System.out.println(index);
				                Thread.sleep(2000);
				            } catch (InterruptedException e) {
				                // TODO Auto-generated catch block
				                e.printStackTrace();
				            }
				        }
				    });
				}
				//将呼叫过的人员插入caller表
		    	Caller c = new Caller();
		    	c.setRequisitionId(view.getRequisitionId());//检查号
		    	c.setPatienId(view.getPtnId());//病人id
		    	c.setName(view.getPtnName());//姓名
		    	c.setName(view.getPtnName());
		    	c.setSex(view.getSex());
		    	c.setEmergency(view.getEmergencyId());
		    	c.setReqDepartment(view.getReqDepartment());//科室名称
		    	c.setSectionsId(view.getSectionsId());//科室id
		    	c.setState("1");
		    	c.setCreated(new Date());
		    	
		    	callerMapper.insert(c);
				
				
			
			
			}
		}
		
	}
	
	
	public void callNextPatient2(String id,String nextId) {
		if(StringUtil.isNotEmpty(id) && StringUtils.isNumber(id)) {
			
//			Caller caller = callerMapper.selectByPrimaryKey(Integer.parseInt(id));
			PxView view = pxViewMapper.selectByPrimaryKey(Integer.parseInt(id));
			if(view!=null) {
				Clinic clinic = clinicMapper.selectByPrimaryKey(Integer.parseInt(view.getSectionsId()));
				String nscreenAddress = clinic.getNscreenAddress();//综合屏地址
				//控制硬件 呼叫
				String upWinNo = String.valueOf(clinic.getClinicNo());//诊室对应的上屏幕窗口号
				String downWinNo = String.valueOf(clinic.getClinicNoTwo());//诊室对应的下屏幕窗口号
				String clinicName = clinic.getClinicName();
				String patientName = view.getPtnName();//当前呼叫病人的姓名
				String patientQueue = view.getRequisitionId(); 
				String stationIp = "http://" + clinic.getClinicServiceIp() + ":801/?";
				String infoUpWindow = "请" + patientQueue + "号" + patientName + "到";
				String infoDownWindow = "";
				String infoSound = "请" + patientQueue + "号，" + patientName + "，到";
				if (StringUtil.isNotEmpty(clinicName)){
					infoSound = infoSound + clinicName + "就诊";
					infoUpWindow = infoUpWindow + clinicName + "就诊";
				}else{
					infoSound = infoSound + clinic.getClinicNo() + "诊室就诊";
					infoUpWindow = infoUpWindow + clinic.getClinicNo() + "诊室就诊";
				}
				
				/******* 待定*******/
				String infoNScreen = patientQueue + "号" + patientName + "诊室";
				//大屏显示队列 最多五位患者，呼叫当前就诊患者的同时呼叫一位等待的患者，并在窗口屏显示
				String infoBScreen = patientQueue + "号" + patientName;
				/**************/
				
				if(StringUtil.isNotEmpty(nextId) && StringUtils.isNumber(nextId)) {
					PxView nextView = pxViewMapper.selectByPrimaryKey(Integer.parseInt(nextId));
					String nextPatientName = nextView.getPtnName();
					String nextPatientQueue = nextView.getRequisitionId();
					//对等待队列中的第二个患者进行处理，包括呼叫和窗口屏幕显示
					String addInfoSound = "，请";
					infoSound = infoSound + addInfoSound + nextPatientQueue + "号，"  + nextPatientName + "，到";
					infoDownWindow = "请" + nextPatientQueue + "号" + nextPatientName + "到";
					if (StringUtil.isNotEmpty(clinicName)){
						infoSound = infoSound + clinicName + "准备就诊";
						infoDownWindow = infoDownWindow + clinicName + "准备就诊";
					}else{
						infoSound = infoSound + clinic.getClinicNo() + "诊室准备就诊";
						infoDownWindow = infoDownWindow + clinic.getClinicNo() + "诊室准备就诊";
					}
					//处理视展卡显示数据，大屏显示队列 最多五位患者
//					TbStation tbStation = tbPatientQueue.getTbSections().getTbStation();
//					String infoBScreen = "";//待定   屏幕上显示的患者信息
					String bigScreenIp = "";
					if(null!=clinic.getStationId()) {
						Station station = stationMapper.selectByPrimaryKey(clinic.getStationId());
						if(null!=station) {
							bigScreenIp = station.getBigScreenIp();
							String url_bScreenDisplay = stationIp + "Func=BScreen_Display&winNo=" + clinic.getBscreenAddress() + "&width=110" + "&height=44" + "&Info=" + infoBScreen + "&Cust=" + patientQueue +"&IP="+bigScreenIp;
							if (null != station) {
								url_bScreenDisplay = stationIp + "Func=BScreen_Display&winNo=" + clinic.getBscreenAddress() + "&width=" + station.getBigScreenWidth() + "&height=" + station.getBigScreenHeight() + "&Info=" + infoBScreen + "&Cust=" + patientQueue +"&IP="+ bigScreenIp;
								//线程执行调用硬件
								//http://172.50.64.13:801/?Func=Sound_Play&Info=请13号，杨秀清，到妇科诊室3就诊，请00003号，沈佳，到妇科诊室3准备就诊
								String url_sound = stationIp + "Func=Sound_Play&Info=" + infoSound + "";
								//http://172.50.64.13:801/?Func=WinScreen_Display&DeviceNo=60&Info=请13号杨秀清到妇科诊室3就诊&Cust=13
								String url_upWindowDisplay = stationIp + "Func=WinScreen_Display&DeviceNo=" + upWinNo + "&Info=" + infoUpWindow + "&Cust=" + patientQueue;
								//http://172.50.64.13:801/?Func=WinScreen_Display&DeviceNo=97&Info=请00003号沈佳到妇科诊室3准备就诊&Cust=13
								String url_downWindowDisplay = stationIp + "Func=WinScreen_Display&DeviceNo=" + downWinNo + "&Info=" + infoDownWindow + "&Cust=" + patientQueue;
								//http://172.50.64.13:801/?Func=NormalScreen_Display&DeviceNo=88&Info=13号杨秀清诊室&Cust=13
								String url_normalScreenDisplay = stationIp + "Func=NormalScreen_Display&DeviceNo=" + nscreenAddress + "&Info=" + infoNScreen + "&Cust=" + patientQueue;
								Constant.threadPool.execute(new Thread[] { new RunThreadPool(url_sound), new RunThreadPool(url_bScreenDisplay), new RunThreadPool(url_upWindowDisplay), new RunThreadPool(url_downWindowDisplay), new RunThreadPool(url_normalScreenDisplay) });
							
							
							
							}
						}
					}
					
					
				}
				
				
			}
			
			
			
			
			
			
		}
		
	}


	

}
