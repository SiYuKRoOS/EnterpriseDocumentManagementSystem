package cn.ha.cz.springboot;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import cn.ha.cz.springboot.bean.EnumFileType;
import cn.ha.cz.springboot.bean.FileBean;
import cn.ha.cz.springboot.bean.UserBean;
import cn.ha.cz.springboot.dao.IFileDao;
import cn.ha.cz.springboot.dao.IUserDao;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringBootWebApplicationTests {

	@Autowired
	IUserDao userDao;
	
	@Autowired
	IFileDao fileDao;

	@Test
	public void userTest() {
		UserBean queryUser = userDao.queryUser(1);
		System.out.println("queryUser: " + queryUser);

		List<UserBean> queryUserList = userDao.queryUserList();
		for (UserBean u : queryUserList) {
			System.out.println("queryUserList: " + u);
		}
	}
	
	@Test
	public void fileTest() {
		FileBean fileBean = new FileBean();
		fileBean.setFilename("test");
		fileBean.setUploadtime(new Date());
		fileBean.setFiletype(EnumFileType.OTHRER);
		System.out.println("==========>"+fileDao.insertFile(fileBean));
	}

}
