package com.web.community.dump;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@PropertySource(value={"classpath:api.properties"})
public class PropertiesTest {

	@Value("${api.key}")
	private String apiKey;

}
