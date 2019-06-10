package com.intehel.service.impl;

import com.intehel.dao.TestMapper;
import com.intehel.model.Test;
import com.intehel.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("TestService")
public class TestServiceImpl  extends BaseServiceImpl<Test> implements TestService {

    @Autowired
    TestMapper testMapper;
    @Override
    public String test() {
        List<Test> test = testMapper.test();
        for (Test t:test) {
            System.err.println(t.getTbId());
            System.err.println(t.getName());
        }
        return null;
    }
}
