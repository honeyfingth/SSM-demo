import com.atguigu.crud.bean.User;
import com.atguigu.crud.service.LoginService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @Description:
 * @Author: ZhongPeng
 * @CreateTime: 2021-06-16  14:03
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class LoginTest {

    @Autowired
    LoginService loginService;


    @Test
    public  void test1(){
        User user = loginService.findUser("zhangsan", "123456");
        System.out.println(user);
    }
}
