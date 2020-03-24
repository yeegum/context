package com.sc.exam.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration
public class WebConfigure implements WebMvcConfigurer {

    @Value("${file.staticAccessPath}")
    private String staticAccessPath;
    @Value("${file.uploadFolder}")
    private String uploadFolder;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        HandlerInterceptor interceptor = new MyHandlerInterceptor();
        InterceptorRegistration ig = registry.addInterceptor(interceptor);
        ig.addPathPatterns("/**");

        /*registry.addInterceptor(
                new MyHandlerInterceptor()).addPathPatterns("/**").excludePathPatterns(
                        "/html/login.jsp","/css/**","/images/**","/js/**","/lib/**",
                        "/management/css/**","/management/fonts/**","/management/images/**","/management/js/**","/management/lib/**");*/
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler(staticAccessPath).addResourceLocations("file:" + uploadFolder);

    }
}
