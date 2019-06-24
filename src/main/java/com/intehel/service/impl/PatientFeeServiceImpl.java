package com.intehel.service.impl;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.intehel.dao.PatientFeeMapper;
import com.intehel.dao.PayForRecipesMapper;
import com.intehel.service.PatientFeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.util.*;

@Service("PatientFeeService")
public class PatientFeeServiceImpl implements PatientFeeService {



    @Autowired
    PatientFeeMapper patientFeeMapper;

    @Autowired
    PayForRecipesMapper payForRecipesMapper;

    @Override
    @Transactional
    public void createPatient(Map<String, Object> map) {
        String departments = map.get("Departments").toString();
        if (departments.length()<4){
            return;
        }
        String[] args = departments.replace("[", "").replace("]", "").replace("=,","=\"\",").replace("PackageCode=","PackageCode=\"\"")
                .replace(" ", "").replace("},{", "}yufadashen{").split("yufadashen");
        List<String> list=new ArrayList();
        List<String> list2=new ArrayList();
        for (int i = 0; i < args.length; i++) {
            String[] split = args[i].replace("{", "").replace("}", "").split(",");
            Map<String,String> maps=new HashMap<>();
            for (int y=0;y<split.length;y++){
                String[] ls=split[y].split("=");
                if (ls[1]==null){ls[1]="";}
                maps.put(ls[0],ls[1]==null?"":ls[1]);
            }

            //查询是否已入库
            list.add(maps.get("RecipeNo"));
            list2.add(maps.get("TotalCost"));
            int a=patientFeeMapper.selectReg(maps.get("RegNo"),maps.get("RecipeNo"));
            if (a==0){
            //信息入库
                patientFeeMapper.createPatient(maps.get("OutpatientId"),maps.get("RegNo"),
                    maps.get("RegDate"),maps.get("RecipeNo"),maps.get("SysType"),maps.get("ItemName"),
                    maps.get("ItemSpec"),maps.get("DosageSpec"),maps.get("ItemNum"),maps.get("TotalCost"),maps.get("PaymentStatus"),maps.get("OperDate"),maps.get("CancelFlag"),
                    maps.get("RecipeDrName") ,maps.get("FeeDate"),new Date()
                 );
            }
            //最后一次循环，插入缴费信息
            if (i==args.length-1){
                list=removeDuplicate(list);
                String[] nsz=new String[list.size()];
                list.toArray(nsz);
                String[] nsz2=new String[list.size()];
                String[] strings = list2.toArray(nsz2);
                System.out.println(Arrays.toString(nsz));
                double db=0;
//                int as=0;
                for (int s=0;s<strings.length;s++){
                    db=db+(Double.parseDouble(strings[s]));
                }
                db=db*100;
                if (payForRecipesMapper.selectPat(maps.get("OutpatientId"),maps.get("RegNo"),(int)db+"")==0) {
                    //不存在插入
                    payForRecipesMapper.createPat(maps.get("OutpatientId"), maps.get("RegNo"), Arrays.toString(nsz).replace("[","").replace("]","").replace(" ",""), (int)db+"","2");
                    System.err.println("支付表插入成功");
                }
            }
        }





    }
    //list 去重
    public  List removeDuplicate(List list) {
        HashSet h = new HashSet(list);
        list.clear();
        list.addAll(h);
        return list;
    }
    @Override
    public void updatePay(String regNo, String recipeNos, String totalFee, String tradeSerialNumber, String paymentWay, String settleDate, String pay) {

    }
}
