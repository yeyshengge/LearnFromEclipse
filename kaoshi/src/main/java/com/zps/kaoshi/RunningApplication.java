package com.zps.kaoshi;

	import org.mybatis.spring.annotation.MapperScan;
	import org.springframework.boot.SpringApplication;
	import org.springframework.boot.autoconfigure.SpringBootApplication;
	import org.springframework.context.annotation.ComponentScan;

	@SpringBootApplication
	@ComponentScan("com") //springmvc的扫描配置
	@MapperScan("com.zps.dao")
	public class RunningApplication {

		public static void main(String[] args) {
			SpringApplication.run(RunningApplication.class, args);
		}
		
	}