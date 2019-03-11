package cn.ha.cz.springboot.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import cn.ha.cz.springboot.bean.EnumUserStatus;
import cn.ha.cz.springboot.bean.UserBean;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

/**
 * Json转换工具类（基于google的Gson和阿里的fastjson）
 * https://www.cnblogs.com/leeSmall/p/9114134.html
 * 
 * @author Administrator
 *
 */
public class JsonConverter {

	public static void main(String[] args) {
		List<UserBean> list = new ArrayList<>();
		for (int i = 0; i < 10; i++) {
			UserBean userBean = new UserBean();
			userBean.setId(i);
			userBean.setUsername("liuwei" + i);
			userBean.setStatusEnum(EnumUserStatus.NORMAL);

			UserBean convertBean = convertBean(userBean, UserBean.class);
			System.out.println("===>convert UserBean: " + convertBean);

			list.add(userBean);
		}

		List<UserBean> convertList = convertList(list, UserBean.class);

		System.out.println("convert user list: "
				+ Arrays.toString(convertList.toArray()));
	}

	public static <T> T convertBean(Object object, Class<T> clazz) {
		return getJsonToBean(getBeanToJson(object), clazz);
	}

	public static <T> List<T> convertList(Object object, Class<T> clazz) {
		return getJsonToList(getBeanToJson(object), clazz);
	}

	/**
	 * 功能描述：把JSON数据转换成指定的java对象
	 * 
	 * @param jsonData
	 *            JSON数据
	 * @param clazz
	 *            指定的java对象
	 * @return 指定的java对象
	 */
	public static <T> T getJsonToBean(String jsonData, Class<T> clazz) {
		return JSON.parseObject(jsonData, clazz);
	}

	/**
	 * 功能描述：把java对象转换成JSON数据
	 * 
	 * @param object
	 *            java对象
	 * @return JSON数据
	 */
	public static String getBeanToJson(Object object) {
		String json = JSON.toJSONString(object);
		System.out.println("json:" + json);
		return json;
	}

	/**
	 * 功能描述：把JSON数据转换成指定的java对象列表
	 * 
	 * @param jsonData
	 *            JSON数据
	 * @param clazz
	 *            指定的java对象
	 * @return List<T>
	 */
	public static <T> List<T> getJsonToList(String jsonData, Class<T> clazz) {
		return JSON.parseArray(jsonData, clazz);
	}

	/**
	 * 功能描述：把JSON数据转换成较为复杂的List<Map<String, Object>>
	 * 
	 * @param jsonData
	 *            JSON数据
	 * @return List<Map<String, Object>>
	 */
	public static List<Map<String, Object>> getJsonToListMap(String jsonData) {
		return JSON.parseObject(jsonData,
				new TypeReference<List<Map<String, Object>>>() {
				});
	}
}
