package com.web.community.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class LogAOP {
	@Pointcut("within(@org.springframework.web.bind.annotation.RestController *)")
	public void restController() {}
	@Pointcut("within(@org.springframework.stereotype.Controller *)")
	public void controller() {}
	@Pointcut("within(@org.springframework.stereotype.Service *)")
	public void service() {}

	@Before("restController() || controller()")
	public void beforeControler(JoinPoint jp) {
		log.info("{} 실행 전!", jp.getSignature().getName());
	}
	
	@After("controller()")
	public void afterControler(JoinPoint jp) {
		log.info("{} 실행 후!", jp.getSignature().getName());
	}
	
	@Around("controller()")
	public Object aroundController(ProceedingJoinPoint pjp) throws Throwable {
		log.info("{} around before" , pjp.getSignature().getName());
		Object result = pjp.proceed();
		log.info("{} around after" , pjp.getSignature().getName());
		return result;
	}
}
