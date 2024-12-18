package com.web.community.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.service.ImageInfoService;
import com.web.community.vo.ImageInfoVO;

@RestController
public class ImageInfoController {
	@Autowired
    private ImageInfoService imageInfoService;
	
	@GetMapping("/images/{piNum}")
	public List<ImageInfoVO> getImage(@PathVariable int piNum){
		return imageInfoService.selectImg(piNum);
	}
	
	@PostMapping("/images")
	@ResponseBody
	public int addImage(@RequestBody List<ImageInfoVO> img) {
		return imageInfoService.insertImages(img);
	}
	
	@PutMapping("/images")
	@ResponseBody
	public int modifyImage(@RequestBody ImageInfoVO img) {
		return imageInfoService.updateImg(img);
	}
	
	@DeleteMapping("/images/{piNum}")
	public int removeImage(@PathVariable int piNum) {
		return imageInfoService.deleteImg(piNum);
	}
}
