package cn.ha.cz.springboot;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import cn.ha.cz.springboot.interceptor.LoginInterceptor;

@SpringBootApplication
@ServletComponentScan //扫描druidServlet
@Configuration
public class SpringBootWebApplication extends WebMvcConfigurerAdapter {

	@Value("${file.staticAccessPath}")
	private String staticAccessPath;
	@Value("${file.uploadFolder}")
	private String uploadFolder;

	public static void main(String[] args) {
		SpringApplication.run(SpringBootWebApplication.class, args);

	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**").excludePathPatterns("/login/**",
				"/error", "/static/**", staticAccessPath+"**");
	}

//	@Override
//	public void addResourceHandlers(ResourceHandlerRegistry registry) {
//		registry.addResourceHandler(staticAccessPath).addResourceLocations("file:" + uploadFolder);
//	}
	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //默认的不需要改：将所有/static/** 访问都映射到classpath:/static/ 目录下
        //registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
		
		//将文件上传相对路径映射到磁盘路径
        registry.addResourceHandler(staticAccessPath+"**").addResourceLocations("file:" + uploadFolder);
    }

}
