package com.atguigu.crud.dao;

import com.atguigu.crud.bean.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * @Description:
 * @Author: ZhongPeng
 * @CreateTime: 2021-06-16  13:56
 */
@Mapper
public interface LoginMapper {

    @Select("select * from tbl_user where username=#{username} and password=#{password}")
    public User findUser(@Param("username") String username, @Param("password") String password);
}
