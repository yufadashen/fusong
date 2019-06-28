//package com.intehel;
//
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.junit4.SpringRunner;
//import static org.assertj.core.api.Assertions.assertThat;
//
//import java.util.Date;
//
////import com.intehel.dao.CallerMapper;
//import com.intehel.dao.PxViewMapper;
//import com.intehel.dao.UserMapper1;
//import com.intehel.model.PxView;
//import com.intehel.service.CallerService;
//import com.intehel.service.UserService;
//
//@RunWith(SpringRunner.class)
//@SpringBootTest
//public class MedicalApplicationTests {
//
//	@Autowired
//    UserMapper1 userMapper;
//	@Autowired
//	UserService userService;
//	@Autowired
//	CallerService callerService;
//	@Autowired
//	CallerMapper callerMapper;
//	@Autowired
//	PxViewMapper pxViewMapper;
//
//	@Test
//    public void test_call() {
//		Caller c = callerMapper.selectByPrimaryKey(1);
//		c.setCreated(new Date());
//		callerMapper.updateByPrimaryKey(c);
//    }
//
//    @Test
//    public void test_db() {
//    	PxView v = pxViewMapper.selectByPrimaryKey(1);
//
//    	Caller c = new Caller();
//    	c.setName(v.getPtnName());
//
//    	callerMapper.insert(c);
//    }
//
//    @Test
//    public void test2() {
//    	/**
//    	 * @Options(useGeneratedKeys=true)获取新添加记录的自增长主键字段值时，
//    	 *     需要在执行添加操作之后，直接访问对象的主键字段属性即可取得对应值
//    	 */
////    	User user = new User();
//////    	user.setUserId("66");
////    	user.setUsername("张三3");
////    	user.setPassword("123456");
////    	userService.save(user);
//
//    }
//
//	@Test
//	public void contextLoads() {
//	}
//
//}
