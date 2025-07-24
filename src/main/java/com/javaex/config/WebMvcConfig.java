package com.javaex.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String osName = System.getProperty("os.name").toLowerCase();
        String resourceLocation;
        if (osName.contains("win")) { // 윈도우
            resourceLocation = "file:///C:/javaStudy/upload/";
        } else { // 리눅스(및 그 외)
            resourceLocation = "file:/data/upload/";
        }
        registry.addResourceHandler("/upload/**")
                .addResourceLocations(resourceLocation);
    }
}