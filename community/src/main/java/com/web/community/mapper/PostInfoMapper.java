package com.web.community.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.web.community.vo.PostInfoVO;

public interface PostInfoMapper {
	List<Map<String,Object>> selectHotPosts();
	List<PostInfoVO> selectPosts(PostInfoVO post);
	PostInfoVO selectPost(int piNum);
	int updateViewCount(@Param("piNum") int piNum, @Param("piViews") int piViews);
	int insertPost(PostInfoVO post);
	int updatePost(PostInfoVO post);
	int deletePost(int piNum);
	int selectPostsTotal(PostInfoVO post);
	int getPostCount();
	List<Integer> selectPostIdsByUserId(int userId);
	int deleteByUserId(int userId);
	PostInfoVO selectNextPost(int piNum);
	PostInfoVO selectPrevPost(int piNum);
	List<PostInfoVO> selectPostsForAdmin(PostInfoVO post);
	int updatePostStatus(@Param("piNum") int piNum, @Param("status") String status);
}
