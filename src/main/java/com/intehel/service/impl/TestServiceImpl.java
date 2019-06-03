package com.intehel.service.impl;

import com.intehel.dao.TestMapper;
import com.intehel.entity.User;
import com.intehel.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("testService")
public class TestServiceImpl implements TestService {

    @Autowired
    private TestMapper callerMapper;

    @Override
    public List getuser() {
        List list = callerMapper.getuser();
        return list;
    }

    @Override
    public void adduser(User user) {
        callerMapper.adduser(user);
    }
}
