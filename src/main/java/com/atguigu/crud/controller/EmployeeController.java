package com.atguigu.crud.controller;

//处理员工的CRUD请求

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    //以json的形式进行员工数据信息的分页查询
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps= employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息,包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page=new PageInfo(emps,5);

        return Msg.success().add("pageInfo",page);
    }

    //查询员工信息(分页查询)
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper分页插件
        // 在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps= employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息,包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page=new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }



    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    //定义一个员工的保存方法
    //1.支持JSR303校验
    //2.导入Hibernate-Validator
    //@Valid校验注解,BindingResult来封装校验的结果
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败,在模态框中显示校验失败的错误信息
            HashMap<Object, Object> map = new HashMap<Object, Object>();
            //获取错误信息
            List<FieldError> fieldErrors = result.getFieldErrors();
            //遍历错误信息
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);

        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    //校验用户名是否可用
    @RequestMapping(value = "/checkuser",method = RequestMethod.POST)
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName){
        //判断用户名是否是合法的表达式
        String regx="(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母组成的");
        }
        boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    //查询一个员工信息
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET )
    @ResponseBody
    //PathVariable是从路径中取出id的值
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }


    /*
    * 如果直接发送ajax=PUT形式的请求
    * 封装的数据
    *  Employee
    *  除了Id其他数据都为null
    *  问题：
    *  请求体中的数据封装不上
    *  update tbl_emp  sql:where emp_id =1014
    *  tomcat默认的请求方式就是post请求
    *  因此直接设置为put请求则会报错
    * */
    //更新员工信息
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println("将要更新的数据："+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //删除员工信息
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable("ids")String ids){
        //批量删除
        if(ids.contains("-")){
            //自定义一个删除方法
            //1.定义一个list集合来存储选中删除的id
            List<Integer> del_ids=new ArrayList<Integer>();
            String[] str_ids=ids.split("-");
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            //单个删除
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}
