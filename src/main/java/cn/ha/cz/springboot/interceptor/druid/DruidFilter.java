package cn.ha.cz.springboot.interceptor.druid;

import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;

import com.alibaba.druid.support.http.WebStatFilter;

@WebFilter(filterName="druidWebStatFilter",urlPatterns="/*",
initParams={
    @WebInitParam(name="exclusions",value="*.js,*.gif,*.jpg,*.bmp,*.png,*.css,*.ico,*.ico, *.woff2, /druid/*,/static/**")// 忽略资源
})
public class DruidFilter extends WebStatFilter {

}
