package com.web.community.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.community.mapper.CommentInfoMapper;
import com.web.community.vo.CommentInfoVO;
import com.web.community.vo.ResultList;

@Service
public class CommentInfoService {
	@Autowired
	private CommentInfoMapper commentInfoMapper;
	
	private static final int DEFAULT_COUNT = 5;
		
	public ResultList<CommentInfoVO> selectComments(CommentInfoVO comment) {
		if (comment.getCount() == 0) {
			comment.setCount(DEFAULT_COUNT);
		}
		if (comment.getPage() != 0) {
			int start = (comment.getPage() - 1) * comment.getCount();
			comment.setStart(start);
		}
		ResultList<CommentInfoVO> rl = new ResultList<>();
		List<CommentInfoVO> comments = commentInfoMapper.selectComments(comment);
		
		// 상태가 BLOCKED인 댓글 처리: "삭제된 댓글입니다."로 내용 변경
		for (CommentInfoVO commentVO : comments) {
			if ("BLOCKED".equals(commentVO.getStatus())) {
				commentVO.setCmiContent("삭제된 댓글입니다.");
			}
		}
		rl.setList(comments);
		
		int totalCnt = commentInfoMapper.selectCommentsTotal(comment);
		rl.setCount(totalCnt);
		return rl;
	}
	
	public ResultList<CommentInfoVO> selectCommentsList(CommentInfoVO comment) {
		if (comment.getCount() == 0) {
			comment.setCount(DEFAULT_COUNT);
		}
		if (comment.getPage() != 0) {
			int start = (comment.getPage() - 1) * comment.getCount();
			comment.setStart(start);
		}
		
		ResultList<CommentInfoVO> rl = new ResultList<>();
		List<CommentInfoVO> comments = commentInfoMapper.selectCommentsList(comment);
		rl.setList(comments);
		
		int totalCnt = commentInfoMapper.selectCommentsTotal(comment);
		rl.setCount(totalCnt);
		
		return rl;
	}
	
	

	public CommentInfoVO selectComment(int cmiNum) {
		return commentInfoMapper.selectComment(cmiNum);
	}
	public int insertComment(CommentInfoVO comment) {
		return commentInfoMapper.insertComment(comment);
	}
	public int updateComment(CommentInfoVO comment) {
		return commentInfoMapper.updateComment(comment);
	}

	public int updateComments(List<CommentInfoVO> comments) {
		return commentInfoMapper.updateComments(comments);
	}

	public int deleteComment(CommentInfoVO comment) {
        return commentInfoMapper.deleteComment(comment);
    }
	public int deleteCommentsByPost(int piNum) {
		return commentInfoMapper.deleteCommentsByPost(piNum);
	}
}
