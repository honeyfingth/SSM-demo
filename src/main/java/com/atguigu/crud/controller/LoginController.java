package com.atguigu.crud.controller;

import com.atguigu.crud.bean.User;
import com.atguigu.crud.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @Description:
 * @Author: ZhongPeng
 * @CreateTime: 2021-06-16  13:21
 */
@Controller
public class LoginController {

    @Autowired
    LoginService loginService;

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @PostMapping("/login")
    public String toLogin(@RequestParam("username") String username, @RequestParam("password") String password, HttpServletRequest request,HttpSession session, Model model){
        User user = loginService.findUser(username, password);
        if(user!=null){
            session.setAttribute("user",user);
            return "forward:index.jsp";
        }
        model.addAttribute("msg","用户名或密码错误请重新登录");
        return "login";
    }


    //退出登录,并且销毁session中存储的user对象
    @GetMapping("/loginOut")
    public String loginOut(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/login";
    }


}
