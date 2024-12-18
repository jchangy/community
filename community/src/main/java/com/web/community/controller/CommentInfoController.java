package com.web.community.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.web.community.service.CommentInfoService;
import com.web.community.vo.CommentInfoVO;
import com.web.community.vo.ResultList;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CommentInfoController {
    
    @Autowired
    private CommentInfoService commentInfoService;
    
    @GetMapping("/comments")
    public ResultList<CommentInfoVO> getComments(CommentInfoVO comment){
        return commentInfoService.selectComments(comment);
    }
    
    @GetMapping("/commentsList")
    public ResultList<CommentInfoVO> getCommentsList(CommentInfoVO comment){
        ResultList<CommentInfoVO> results = commentInfoService.selectCommentsList(comment);
        return results;
}
    
    
    @GetMapping("/comments/{piNum}")
    public ResultList<CommentInfoVO> getComments(CommentInfoVO comment, @PathVariable int piNum){
        comment.setPiNum(piNum);
        return commentInfoService.selectComments(comment);
    }
    
    @PostMapping("/comments")
    @ResponseBody
    public int insertComment(@RequestBody CommentInfoVO comment) {
        if (comment.getUiNum() == null || comment.getUiNum() <= 0) {
            return -1; // 로그인하지 않은 경우
        }
        if (comment.getCmiContent() == null || comment.getCmiContent().trim().isEmpty()) {
            return 0; // 댓글 내용이 비어 있을 경우
        }
        return commentInfoService.insertComment(comment);
    }

    @PutMapping("/comments/{cmiNum}")
    public int updateComment(@RequestBody CommentInfoVO comments, @PathVariable int cmiNum) {
        comments.setCmiNum(cmiNum);
        return commentInfoService.updateComment(comments);
    }

    @PutMapping("/comments")
    public int updateComments(@RequestBody List<CommentInfoVO> comments) {
        return commentInfoService.updateComments(comments);
    }

    
    @DeleteMapping("/comments/{cmiNum}")
    public int removeComment(@PathVariable int cmiNum, HttpSession session) {
        Integer uiNum = (Integer) session.getAttribute("uiNum");
        if (uiNum != null) {
            CommentInfoVO comment = new CommentInfoVO();
            comment.setCmiNum(cmiNum);
            comment.setUiNum(uiNum);
            return commentInfoService.deleteComment(comment);
        }
    	log.info("삭제 댓글 cmiNum =>{}" , cmiNum);
    	log.info("삭제 댓글 uiNum =>{}" , uiNum);
        return 0;
    }
    
    @DeleteMapping("/comments/post/{piNum}")
    public int removeCommentByPost(@PathVariable int piNum) {
        return commentInfoService.deleteCommentsByPost(piNum);
    }
}
