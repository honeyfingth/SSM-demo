package com.atguigu.crud.service;

import com.atguigu.crud.bean.User;
import com.atguigu.crud.dao.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: ZhongPeng
 * @CreateTime: 2021-06-16  13:56
 */
@Service
public class LoginService {

    @Autowired
    private LoginMapper loginMapper;

    public User findUser(String username,String password){
        return loginMapper.findUser(username,password);
    }
}
