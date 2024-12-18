package com.web.community.mapper;

import java.util.List;

import com.web.community.vo.ImageInfoVO;

public interface ImageInfoMapper {
	List<ImageInfoVO> selectImg(int piNum);
    int insertImg(ImageInfoVO img);
    int updateImg(ImageInfoVO img);
    int deleteImg(int piNum);

    int deleteByUserId(int userId);
}
