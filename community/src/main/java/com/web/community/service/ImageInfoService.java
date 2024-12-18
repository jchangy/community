package com.web.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.ImageInfoMapper;
import com.web.community.vo.ImageInfoVO;

@Service
public class ImageInfoService {
    @Autowired
    private ImageInfoMapper imageInfoMapper;

    public List<ImageInfoVO> selectImg(int piNum) {
        return imageInfoMapper.selectImg(piNum);
    }

    public int insertImages(List<ImageInfoVO> images) {
        int insertedCount = 0; // 삽입된 이미지 수

        if (images != null && !images.isEmpty()) {
            for (ImageInfoVO image : images) {
                insertedCount += imageInfoMapper.insertImg(image); // 각 삽입 결과를 누적
            }
        }
        
        return insertedCount; // 삽입된 이미지 수 반환
    }
    

    public int updateImg(ImageInfoVO image) {
        return imageInfoMapper.updateImg(image);
    }

    public int deleteImg(int piNum) {
        return imageInfoMapper.deleteImg(piNum);
    }
}