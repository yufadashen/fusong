package com.intehel.common.util;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class XmlJsonUtils {

    /**
     * @description 将xml字符串转换成map
     * @param xml
     * @return Map
     */
    public static Map readStringXmlOut(String xml) {
        Map<String,Object> map = new HashMap();
        Document doc = null;
        try {
            doc = DocumentHelper.parseText(xml); // 将字符串转为XML
            Element rootElt = doc.getRootElement(); // 获取根节点
//            递归遍历当前节点所有的子节点
            List<Element> listElement=rootElt.elements();//所有一级子节点的list
            for(Element e:listElement){//遍历所有一级子节点
//                System.err.println(e.getName().equals("Code"));

                if (e.getName().equals("Message")){
                    map.put("Message",e.getTextTrim());
                }
                if ("Code".equals(e.getName())){
                    map.put("Code",e.getTextTrim());
                    if (e.getTextTrim().equals("0")){
                        map.put("Message","成功");
                    }
                }
//                System.out.println(e.getName()+":"+e.getTextTrim());//当前节点名称
                map.put("Departments",getNodes(e));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public static List<Map> getNodes(Element node){
        List<Map>list=new ArrayList<>();
        Map map = new HashMap();

        System.out.println("--------------------");
        //当前节点的名称、文本内容和属性
        System.out.println(node.getName()+":"+node.getTextTrim());//当前节点名称
        //递归遍历当前节点所有的子节点
        List<Element> listElement=node.elements();//所有一级子节点的list
        for(Element e:listElement){//遍历所有一级子节点
            Map map1=null;
            map1=getNodess(e);//递归
            list.add(map1);
        }
       list.add(map);
        return list;
    }

    private static Map getNodess(Element e) {
        List<Map>list=new ArrayList<>();
        Map map = new HashMap();

        System.out.println("-----------123---------");
        //当前节点的名称、文本内容和属性
        System.out.println(e.getName()+":"+e.getTextTrim());//当前节点名称
        map.put(e.getName(),e.getTextTrim());
//        map.put(e.getName(),e.getTextTrim());
        List<Element> listAttr=e.attributes();//当前节点的所有属性的list
        for(Element attr:listAttr){//遍历当前节点的所有属性
            String name=attr.getName();//属性名称
            String value=attr.getTextTrim();//属性的值
            System.out.println("属性名称："+name+"属性值："+value);
            map.put(attr.getName(),attr.getTextTrim());
        }
        //递归遍历当前节点所有的子节点
        List<Element> listElement=e.elements();//所有一级子节点的list
        for(Element ee:listElement){//遍历所有一级子节点

            map.put(ee.getName(),ee.getTextTrim());
            getNodess(ee);//递归
            list.add(map);
        }
//        list.add(map);
        return map;
    }
}
