<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" %>
<%--引入标签库--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--
        不以/开始的相对路径,找资源,以当前资源的路径为基准,经常容易出问题

        以/开始的相对路径,找资源,以服务器的路径为标准
    --%>
    <%--引入BootStrap--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>

    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


</head>
<body>

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10" >
                            <label class="radio-inline">
                                <input type="radio" name="gender"  id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4" >
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control"  name="empName" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10" >
                            <label class="radio-inline">
                                <input type="radio" name="gender"  id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4" >
                            <%--部门提交部门id即可--%>
                            <select class="form-control" name="dId" >

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn" >新增</button>
            <button class="btn btn-success" id="emp_delete_all_btn">删除</button>
            <a href="${pageContext.request.contextPath}/loginOut">退出</a>
            <span>欢迎,${user.username}</span>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table  class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
        <script type="text/javascript">
            //定义总记录数
            var totalRecord,currentPage;
            //1.页面加载完成以后直接发送ajax请求，要到分页数据
                $(function () {
                    //去首页
                    to_page(1);
                });

                function to_page(pn) {
                    $.ajax({
                        url:"${APP_PATH}/emps",
                        data:"pn="+pn,
                        type:"GET",
                        success:function (result) {
                            // console.log(result);
                            //1.解析并显示员工数据
                            build_emps_table(result);
                            //2.解析并显示分页信息
                            build_page_info(result);
                            //3.解析显示分页条
                            build_page_nav(result);
                        }
                    });
                }
                function build_emps_table(result) {
                    //点击页码时，实现清空
                    $("#emps_table tbody").empty();
                    var emps=result.extend.pageInfo.list;
                    //遍历数据
                    $.each(emps,function (index,item) {
                            var checkBoxTd=$("<td><input type='checkbox' class='check_item'></td>");
                            var empIdTd=$("<td></td>").append(item.empId);
                            var empNameTd=$("<td></td>").append(item.empName);
                            var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
                            var emailTd=$("<td></td>").append(item.email);
                            var deptNameTd=$("<td></td>").append(item.department.deptName);
                            /*
                                 <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                            * */

                            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>")
                                .addClass("glyphicon glyphicon-pencil")).append("编辑");
                            //为编辑按钮添加一个自定义属性，来表示当前员工的id
                            editBtn.attr("edit-id",item.empId);
                            var delBtn=$("<button></button>").addClass("btn btn-success btn-sm delete_btn").append($("<span></span>")
                                .addClass("glyphicon glyphicon-trash")).append("删除");

                            //为删除按钮添加一个自定义的属性来表示当前删除员工的id
                            delBtn.attr("del-id",item.empId);
                            //append方法执行完成以后还是返回原来的元素，将tr元素添加到表格体中
                           $("<tr></tr>")
                               .append(checkBoxTd)
                               .append(empIdTd)
                               .append(empNameTd)
                               .append(genderTd)
                               .append(emailTd)
                               .append(deptNameTd)
                               .append(editBtn).append(delBtn)
                               .appendTo("#emps_table tbody")
                    });
                }
                //解析显示分页信息
                function build_page_info(result) {
                    $("#page_info_area").empty();
                    $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页," +
                        "总"+result.extend.pageInfo.pages+"页," +
                        "总"+result.extend.pageInfo.total+"条记录");
                         totalRecord=result.extend.pageInfo.total;

                         currentPage=result.extend.pageInfo.pageNum;
                }
                //解析显示分页条
                function build_page_nav(result) {
                    $("#page_nav_area").empty();
                    var ul=$("<ul></ul>").addClass("pagination");
                    //首页
                    var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
                    //前一页
                    var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
                    //判断该页是否有前一页
                    if(result.extend.pageInfo.hasPreviousPage== false){
                        //若该页没有前一页
                        firstPageLi.addClass("disabled");
                        prePageLi.addClass("disabled");
                    }else{
                        //为元素添加点击翻页的事件
                        //首页单击事件
                        firstPageLi.click(function () {
                            to_page(1);
                        });
                        //前一页单击事件
                        prePageLi.click(function () {
                            to_page(result.extend.pageInfo.pageNum-1);
                        });

                    }


                    //后一页
                    var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
                    //末页
                    var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

                    //判断该页是否有下一页
                    if(result.extend.pageInfo.hasNextPage==false){
                        //若该页没有下一页
                        nextPageLi.addClass("disabled");
                        lastPageLi.addClass("disabled");
                    }else{
                        //为元素添加分页事件
                        nextPageLi.click(function () {
                            to_page(result.extend.pageInfo.pageNum+1);
                        });
                        lastPageLi.click(function () {
                            to_page(result.extend.pageInfo.pages);
                        });
                    }


                    //添加首页和前一页
                    ul.append(firstPageLi).append(prePageLi);
                    //遍历导航条
                    //1、2、3....遍历给ul中添加页码提示
                    $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                        var numLi=$("<li></li>").append($("<a></a>").append(item));
                        if(result.extend.pageInfo.pageNum==item){
                            numLi.addClass("active");
                        }
                        //添加页码的单击事件
                        numLi.click(function () {
                            to_page(item);
                        });
                        ul.append(numLi);

                    });
                    //添加后一页与末页
                    ul.append(nextPageLi).append(lastPageLi);
                    //把ul加入到nav中
                    var navEle=$("<nav></nav>").append(ul);
                    //把导航条添加到区域div元素中
                    navEle.appendTo("#page_nav_area");
                }

            //表单完整重置的方法
            //清空表单样式及内容
            function reset_form(ele){
                $(ele)[0].reset();
                //清空样式
                $(ele).find("*").removeClass("has-error has-success");
                //清空span中的文本文字
                $(ele).find(".help-block").text("");
            }


            //绑定添加按钮的单击事件
            $("#emp_add_modal_btn").click(function () {
                //清空表单数据(表单完整重置)
                // $("#empAddModal form")[0].reset();
                reset_form("#empAddModal form");
                getDepts("#empAddModal select");
                $("#empAddModal").modal({
                    backdrop: "static"
                });
            });

            //查出所有的部门信息并显示在下拉列表中
            function getDepts(ele){
                //清空之前下拉列表的值
                $(ele).empty();
                $.ajax({
                    url:"${APP_PATH}/depts",
                    type:"GET",
                    success:function (result){
                        // console.log(result);
                        //显示部门信息在下拉列表
                        //遍历list中的部门信息
                        $.each(result.extend.depts,function () {
                            var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                            optionEle.appendTo(ele);
                        })
                }
                });
            }

            //表单校验方法
            function validate_add_form(){
                //1.校验员工名字
                //使用正则表达式来进行表单的校验
                var empName = $("#empName_add_input").val();
                //6-16个字母和数字或者是2-5个中文字符
                var regName=/(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                //使用正则表达式中的test方法来进行表单数据的校验
               if(!regName.test(empName)){
                   //校验失败
                   //提示用户名可以是2-5为中文或者6-16为英文和数字的组合
                   // alert("用户名可以是2-5为中文或者6-16为英文和数字的组合");
/*                   $("#empName_add_input").parent().addClass("has-error");
                   $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");*/
                    show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                   return false;
               }else {
/*                   $("#empName_add_input").parent().addClass("has-success");*/
                   show_validate_msg("#empName_add_input","success","");
               }
                //2.校验员工的邮箱
                var empEmail = $("#email_add_input").val();
               //定义邮箱的正则表达式
                var  regMail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regMail.test(empEmail)){
                    //校验失败
/*                    $("#email_add_input").parent().addClass("has-error");
                    $("#email_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");*/
                    show_validate_msg("#email_add_input","error","邮箱格式错误，请重新输入...");
                    return  false;
                }else {
                    show_validate_msg("#email_add_input","success","");
                }
                return  true;

            }

            //定义一个显示校验结果信息的方法
            function show_validate_msg(ele,status,msg){
                //清除当前元素的校验状态
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text("");
                if("success"==status){
                    $(ele).parent().addClass("has-success");
                    $(ele).next("span").text(msg);
                }else if("error"==status){
                    //校验失败
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            }

            //校验用户名是否可用
            $("#empName_add_input").change(function () {
                //获取文本框中的值
                var empName=this.value;
                //发送ajax请求校验用户名是否可用
                $.ajax({
                    url:"${APP_PATH}/checkuser",
                    data:"empName="+empName,
                    type:"POST",
                    success:function (result) {
                        if(result.code==100){
                            //代表用户名可用
                            show_validate_msg("#empName_add_input","success","用户名可用");
                            //为保存按钮添加属性
                            //保存成功
                            $("#emp_save_btn").attr("ajax-va","success");
                        }else {
                            //用户名不可用
                            show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                            $("#emp_save_btn").attr("ajax-va","error");
                        }
                    }
                })
            })
            //添加保存操作的单击事件
            $("#emp_save_btn").click(function () {
                //1.将模态框中的数据提交给服务器进行保存
                //2.发送ajax请求保存员工
                // alert($("#empAddModal form").serialize());
                // 3.进行表单数据的提交时要先进行表单数据的校验
                    if(!validate_add_form()){
                        return false;
                    }
                //1.判断之前ajax用户名校验是否成功。如果成功
                if($(this).attr("ajax-va")=="error"){
                    return false;
                }
               $.ajax({
                   url:"${APP_PATH}/saveEmp",
                   data:$("#empAddModal form").serialize(),
                   type:"POST",
                   success:function (result) {
                       if(result.code==100){
                           // alert(result.msg)
                           //员工保存成功
                           //1.关闭模态框
                           $("#empAddModal").modal('hide');
                           //2.来到最后一页，显示刚才保存的数据
                           //发送ajax请求显示最后一页数据即可
                           to_page(totalRecord);
                       }else {
                           //显示失败信息
                           // console.log(result);
                           //有哪个字段的错误信息就显示哪个字段的
                           if(undefined!=result.extend.errorFields.email){
                               //显示邮箱错误信息
                               show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                           }
                           if(undefined!=result.extend.errorFields.empName){
                               //显示员工名字的错误信息
                               show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                           }
                       }

                   }
               })
            })

            //绑定编辑按钮的单击事件
            //1.我们是按钮创建之前就绑定了click，所以绑定不上
            //2.可以在创建按钮的时候绑定  绑定点击.live()
            //3.jquery新版没有live，可以使用on进行代替
            $(document).on("click",".edit_btn",function () {
                // alert("edit");


                //1.查出员工信息,显示员工信息
                getEmp($(this).attr("edit-id"));
                //2.查出部门信息,并显示部门列表
                getDepts("#empUpdateModal select");
                //3.把员工的id传递给模态框的更新按钮
                $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
                //弹出模态框
                $("#empUpdateModal").modal({
                    backdrop: "static"
                });
            })

            //查询员工信息,显示在模态框中
            function getEmp(id) {
                $.ajax({
                    url:"${APP_PATH}/emp/"+id,
                    type:"GET",
                    success:function (result) {
                        // console.log(result);
                        var empData = result.extend.emp;

                        $("#empName_update_static").text(empData.empName);
                        $("#email_update_input").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select").val([empData.dId]);
                    }
                });
            }

            //为更新按钮添加单击事件，更新员工信息
            $("#emp_update_btn").click(function () {
                //验证邮箱是否合法
                //1.校验邮箱信息
                var empEmail = $("#email_update_input").val();
                //定义邮箱的正则表达式
                var  regMail=/^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regMail.test(empEmail)){
                    //校验失败
                    show_validate_msg("#email_update_input","error","邮箱格式错误，请重新输入...");
                    return  false;
                }else {
                    show_validate_msg("#email_update_input","success","");
                }
                //2.发送ajax请求保存更新员工数据
                $.ajax({
                    url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                    //因为在更新方法中请求方式是put这里要改成put因此
                    type:"PUT",
                    data:$("#empUpdateModal form").serialize(),
                    success:function (result) {
                        // alert(result.msg);
                        //1.关闭对话框
                        $("#empUpdateModal").modal("hide");
                        //2.回到本页面
                        to_page(currentPage);
                    }
                })
            })

            //单个删除按钮的单击事件
            $(document).on("click",".delete_btn",function () {
                //获取到删除员工的名字
                // alert($(this).parents("tr").find("td:eq(1)").text());
                //获取删除员工的id属性
                var empId = $(this).attr("del-id");
                var empName=$(this).parents("tr").find("td:eq(2)").text();
                if(confirm("确认删除["+empName+"]吗")){
                    //确认，发送ajax请求删除即可
                    $.ajax({
                        url:"${APP_PATH}/emp/"+empId,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            //回到本页
                            to_page(currentPage);
                        }
                    })
                }
            })

            //完成全选/全不选功能
            $("#check_all").click(function () {
                //弹出是否被选中
                //attr获取checked是undefined
                //我们这些dom原生的属性;attr获取自定义属性的值
                //prop修改和读取dom原生属性的值
                // alert($(this).prop("checked"));
                $(".check_item").prop("checked",$(this).prop("checked"));
            })

            //check_item
            $(document).on("click",".check_item",function () {
                //判断当前选择中的元素是否为5个
                // alert($(".check_item:checked").length==$(".check_item").length);
                var flag=$(".check_item:checked").length==$(".check_item").length;
                $("#check_all").prop("checked",flag);
            })

            //点击全部删除,就批量删除
            $("#emp_delete_all_btn").click(function () {
                var  empNames="";
                var  empIds="";
                $.each($(".check_item:checked"),function () {
                    empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";

                    empIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
                });
                //删除多余的,
                empNames=empNames.substring(0,empNames.length-1);
                //删除多余的-
                empIds=empIds.substring(0,empIds.length-1);
                if(confirm("确认删除["+empNames+"]吗?")){
                    //发送ajax请求
                    $.ajax({
                        url:"${APP_PATH}/emp/"+empIds,
                        type:"DELETE",
                        success:function (result) {
                            alert(result.msg);
                            //回到当前页面
                            to_page(currentPage);
                        }
                    })
                }
            })
        </script>
</body>
</html>

