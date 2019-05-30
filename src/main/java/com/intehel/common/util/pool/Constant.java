package com.intehel.common.util.pool;

import org.springframework.web.context.WebApplicationContext;

public class Constant
{
	public static final String			VSERION										= "1.0";
	public static String				SERVLET_MAPPING								= "*.shtml";
	public static final String			CHARSET										= "UTF-8";
	public static String				ROOTPATH									= "";
	public static String				DEV_ROOTPATH								= "";											//为开发环境和测试环境设置的windows上ROOTPATH路径
	public static String				TMPPATH										= "/tmp";
	public static String				UPLOADPATH									= "/upload";
	public static String				WEBROOTPATH									= "";
	public static String				WEBPATH										= "/website/";
	public static String				FTL_PATH									= "website/templates/";
	public static boolean				USE_URL_REWRITE								= false;
	public static final boolean			USE_PERMISSION_CACHE						= true;
	public static boolean				USE_CLUSTER									= false;
	public static int					POST_STORAGE_MODE							= 0;
	public static String				IMG_EXT										= "jpg";
	public static final String			DEFAULT_HTML_TITLE							= "海乐排队评价查询分析系统";
	public static final String			DEFAULT_HTML_KEYWORDS						= "海乐排队评价查询分析系统";
	public static final String			DEFAULT_HTML_DESCRIPTION					= "海乐排队评价查询分析系统";
	public static String				HTML_TITLE									= "html_title";
	public static String				HTML_KEYWORDS								= "html_keywords";
	public static String				HTML_DESCRIPTION							= "html_description";
	public static int					rowsSizePerPage								= 20;
	// 用于记录用户登陆的全局变量
	public static String				SESSION_TB_USER								= "sessionTbUser";
	// 用于记录护士登陆的全局变量
	public static String				SESSION_TB_NURSE							= "sessionTbNurse";
	public static String				SESSION_TB_STATION							= "sessionTbStation";
	// 用于保存用户名的session名
	public static String				SESS_USER_NAME								= "sess_user_name";
	// 用于保存护士的session名
	public static String				SESS_NURSE_NAME								= "sess_nurse_name";
	// 用于保存用户id的session名
	public static String				SESS_USER_ID								= "sess_user_id";
	// 用于保存护士id的session名
	public static String				SESS_NURSE_ID								= "sess_nurse_id";
	// 用于保存护士分诊台ID
	public static String				SESS_STATION_ID								= "sess_station_id";
	// 用于保存护士分诊台綜合屏地址
	public static String				SESS_SCREEN_ADDRESS							= "sess_screen_address";
	// 用于保存护士分诊台的科室
	public static String				SESS_STATION_SECTIONS_ID					= "sess_station_sections_id";
	// 用于保存护士分诊台所有科室ID
	public static String				SESS_ALL_SECTIONS_ID						= "sess_all_sections_id";
	// 用于保存用户请求的页面
	public static String				SESSION_USER_REQUEST_PAGE					= "sessionUserRequestPage";
	// 用于保存护士请求的页面
	public static String				SESSION_NURSE_REQUEST_PAGE					= "sessionNurseRequestPage";
	// session中用于保存图片验证码的名字
	public static String				CHECK_CODE_NAME								= "sessChkCode";
	// session中保存用户真实姓名
	public static String				SESS_REAL_NAME								= "sess_real_name";
	// session中保存用户真实姓名
	public static String				SESS_REAL_NURSE_NAME						= "sess_real_nurse_name";
	// session中保存用户职位名称
	public static String				SESS_USER_POSITION							= "sess_user_position";
	// session 中保存用户角色
	public static String				SESSION_USER_ROLE							= "sess_user_role";
	public static String				baseFileDir									= "d:/lylt/uploadedFiles";						// 文件存放根目录
	public static String				tmpFileDir									= "d:/lylt/uploadedFiles/tmp";					// 文件存放临时目录
	//用户菜单
	public static final String			SESS_USER_FUNCTION							= "sess_user_function";
	//护士科室
	public static String				SESS_NURSE_LEFT_FUNCTION					= "sess_nurse_left_function";
	public static final String			USER_INDEX_URL_START						= "/home/";
	public static int					WARNING_REFERSH_TIME						= 1;
	//保存登录人员所属营业厅的所有下属营业厅ids
	public static String				PERMISSION_OFFICEIDS_STR					= "";
	public static String				SESS_PERMISSION_OFFICEIDS					= "sess_permission_officeids";
	//session中保存登录人员营业厅级别
	public static final String			SESS_OFFICES_LEVEL							= "sess_offices_level";
	//当前访问URL的上级菜单ID
	public static final String			SESS_CURR_FUNCTION_PARENT_ID				= "sess_curr_function_parent_id";
	//一级菜单的总数
	public static String				SESS_TOYAL_FUNCTION_PARENT					= "sess_total_function_parent";
	public static String				SESS_EMPLOYEES_ALL_OFFICES_STR				= "sess_employees_all_offices_str";
	public static String				SESS_EMPLOYEES_ALL_OFFICES_HAS_LEVEL_STR	= "sess_employees_all_offices_has_level_str";
	public static final String			SITE_URL									= "http://172.16.1.26:8080";					//服务器地址
	public static final String			SITE_IP										= "172.16.1.26";								//服务器地址
	public static String				USER_LEFT_FUNCTION_PAGE						= "";
	public static String				SESS_MAP_KIND								= "sess_map_kind";
	public static String				SESS_STATION_URL							= "http://172.16.22.56:801/?";
	public static ThreadPool			threadPool									= null;
	public static final Integer			finalInsertNum								= 7;
	public static final Integer			finalUpNum									= 2;  //每隔一个 插一个  如果为2的话，只插优先的【优先的会连在一起】【在有复诊的情况下，就不会出错】
	public static final Integer			callNumForReady								= 5;											//呼叫预备就诊的人数
	public static WebApplicationContext	wc											= null;
}
