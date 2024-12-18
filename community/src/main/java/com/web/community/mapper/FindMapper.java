package com.web.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.web.community.vo.FindVO;

@Mapper
public interface FindMapper {
    FindVO findByEmail(String uiEmail); // 이메일로 사용자 찾기
}