目  录


一、员工管理系统描述	2
1、需要实现的功能	2
2、设计目的	2
3、使用的技术栈	2
二、分析与设计	3
1、功能模块划分	3
2、数据库结构描述	3
3、系统详细设计文档	7
4、各个模块的实现方法描述	7
三、系统测试	8
四、附录(主要代码)	10


一、系统描述
1、需求实现的功能
1.1、实现了用户登录的功能,以及登录校验的功能
1.2、实现了用户权限登录的功能、以拦截器的形式来实现权限登录；
1.3、实现了员工的增删改查功能；
1.4、实现了部门信息的查询功能；
1.5、实现了员工信息校验的功能；
1.6、实现了对员工展示信息得到的分页展示功能

2、设计目的
员工信息管理系统是一款员工信息管理平台！前后端分离架构 ，支持员工信息的增删改查。 帮助解决员工信息的管理工作，简化工作流程速度提高效率，节省研发成本，同时又不失灵活性！


3、使用的技术栈
①　基础框架：Spring SpringMVC
②　持久层框架：Mybatis
③　前端框架：BootStrap jQuery
④　据库连接池：c3p0
⑤　其他：Restful接口、Tomcat服务器
⑥　数据库：MySql



二、分析与设计
1、功能模块划分
  
图1 员工管理系统功能模块划分图

2、数据库结构描述
2.1、数据库E-R模型 





图2 部门信息E-R图


	



 






图3 员工信息E-R图








图4 用户信息E-R图



2.2、数据库关系模型——二维表
1.Admin(管理员表)
管理员表用于存储管理员信息，包括用户名和密码，数据表结构如表1所示

表1 管理员表
字段名	数据类型	长度	说明
id	int	10	管理员ID（主键）
name	varchar	16	用户名
password	varchar	16	密码



2.Emp(员工表)
员工表用于存储员工信息，包括员工名字和id、性别、邮箱、部门id，数据表结构如表2所示
表2 员工表
字段名	数据类型	长度	说明
emp_id 	int	10	员工ID（主键）
emp_name 	varchar	16	员工姓名
gender	varchar	16	性别
email	varchar	16	邮箱
d_id	int	10	部门id(外键)

3.Dept(部门表)
部门表用于存储部门信息，包括部门id和部门名字，数据表结构如表3所示
表3 部门表
字段名	数据类型	长度	说明
dept_id	int	10	部门ID（主键）
dept_name 	varchar	16	部门名



员工表数据库截图:


部门表数据库截图:


用户表数据库截图:

3、系统详细设计文档
3.1、系统执行流程图


4、各个模块的实现方法描述
4.1、用户登录页
用户登录页用于管理员登录操作，实现方法如下：
1)表单提交后到/login这个请求进行用户名和密码的校验
2)与数据库中的用户名和密码进行比对
3)查询成功，则跳转到list.jsp
4)查询失败，则返回login.jsp
4.2、员工信息展示页
登录页面跳转成功后进行员工信息的展示
1)通过/emp这个请求进行员工信息的查询
2)进行到service中的list方法
3)到dao层将数据填充到数据库中
4)最后在跳转回员工信息展示页
4.3、员工信息删除页
登录页面跳转成功后进行员工信息的删除
1)通过/emp这个请求进行员工信息的删除
2)到service层中的delete方法
3)到dao层将数据填充到数据库中
4.4、员工信息修改页
员工信息查询成功后进行员工信息修改
1)通过/emp这个请求进行员工信息的修改
2)进行到service中的update方法
3)到dao层将数据填充到数据库中
4)最后在跳转回员工信息展示页
4.5、员工信息添加页
登录页面跳转成功后进行员工信息的添加
1)通过/emp这个请求进行员工信息的查询
2)进行到service中的list方法
3)到dao层将数据填充到数据库中
4)最后在跳转回员工信息展示页
4.6、权限拦截功能
对登录请求进行权限检查
1)通过定义一个拦截器实现对用户是否登录的拦截
2)在spring-mvc的配置文件中对要拦截的请求进行配置
3)最后在LoginController编写方法进行用户登录后信息的存储
三、系统测试
1、员工管理系统登录界面


2、员工信息展示界面(分页的展示)



3、员工信息添加界面


4、员工信息修改界面







