package com.boot;

import org.springframework.boot.SpringApplication;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"com.mylib.paging", "com.boot"})

@SpringBootApplication
public class BootPagingMysqlTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(BootPagingMysqlTestApplication.class, args);
	}

}
