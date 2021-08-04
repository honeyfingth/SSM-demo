package com.atguigu.crud.test;

//测试dao层的工作

/*
 * 推荐Spring的项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration
 * */

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@ContextConfiguration(locations = "classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {

    //自动注入DepartmentMapper
    @Autowired
    DepartmentMapper departmentMapper;

    //自动注入EmployeeMapper
    @Autowired
    EmployeeMapper employeeMapper;

    //注入一个批量的sqlSession
    @Autowired
    SqlSession sqlSession;

    /*
     * 测试DepartmentMapper
     * */
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

/*        Department department = new Department(1, "开发部");
        System.out.println(department);*/
        //1.插入几个部门
/*        departmentMapper.insertSelective(new Department(1,"开发部"));
        departmentMapper.insertSelective(new Department(2,"测试部"));
        departmentMapper.insertSelective(new Department(3,"销售部"));*/


/*        //2.生成员工数据，测试员工插入
        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));*/


        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
        }
        System.out.println("批量完成......");
    }


}
