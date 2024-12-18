package com.web.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LikeInfoMapper {
	int countLikeByPost(@Param("piNum") int piNum);
	int countLikeByUser(@Param("piNum") int piNum, @Param("uiNum")int uiNum);
	int insertLike(@Param("piNum") int piNum, @Param("uiNum") int uiNum);
	int deleteLike(@Param("piNum") int piNum, @Param("uiNum") int uiNum);
}
