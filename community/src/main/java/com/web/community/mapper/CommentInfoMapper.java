package com.web.community.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import com.web.community.vo.CommentInfoVO;

public interface CommentInfoMapper {
	List<CommentInfoVO> selectCommentsList(CommentInfoVO comment);
	List<CommentInfoVO> selectComments(CommentInfoVO comment);
	CommentInfoVO selectComment(int uiNum);
	int insertComment(CommentInfoVO comment);
	int updateComment(CommentInfoVO comment);
	int updateComments(List<CommentInfoVO> comment);
	int deleteComment(CommentInfoVO comment);
	int deleteCommentsByPost(int piNum);
	int selectCommentsTotal(CommentInfoVO comment);
	int getCommentCount();
	
	@Delete("DELETE FROM comment_info WHERE UI_NUM = #{userId} OR PI_NUM IN (SELECT PI_NUM FROM post_info WHERE UI_NUM = #{userId})")
    int deleteByUserId(@Param("userId") int userId);
}
