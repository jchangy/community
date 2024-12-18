package com.web.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.web.community.service.CommentInfoService;
import com.web.community.service.PostInfoService;
import com.web.community.service.UserInfoService;
import com.web.community.vo.PostInfoVO;
import com.web.community.vo.ResultList;
import com.web.community.vo.UserInfoVO;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class PostInfoController {
    @Autowired
    private PostInfoService postInfoService;
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private CommentInfoService commentInfoService;
    
    private static final int MAX_IMAGES = 10;

    @GetMapping("/posts/hot")
    public List<Map<String, Object>> getHotPosts() {
    	log.info("화제글 요청 받음");
        List<Map<String, Object>> hotPosts = postInfoService.getHotPosts();
        log.info("화제글 데이터: {}", hotPosts);
        return hotPosts;
    }
    
    @GetMapping("/posts")
    public ResultList<PostInfoVO> getPosts(PostInfoVO post) {
        return postInfoService.selectPosts(post);
    }
    
    //관리자 전체리스트
    @GetMapping("/postList")
    public ResultList<PostInfoVO> getPostList(PostInfoVO post) {
        return postInfoService.selectPostsForAdmin(post);
    }
    
    //다음글
    @GetMapping("/posts/{piNum}/next")
    public PostInfoVO getNextPost(@PathVariable int piNum) {
    	log.info("getNextPost piNum=>{}",piNum);
        return postInfoService.selectNextPost(piNum);
    }
    
    //이전글
    @GetMapping("/posts/{piNum}/prev")
    public PostInfoVO getPrevPost(@PathVariable int piNum) {
    	log.info("getPrevPost piNum=>{}",piNum);
        return postInfoService.selectPrevPost(piNum);
    }
    
    @GetMapping("/posts/{piNum}")
    public PostInfoVO getPost(@PathVariable int piNum, HttpServletRequest request, HttpServletResponse response) {
        // 서비스에서 조회수 처리 및 게시글 조회 후 반환
        return postInfoService.selectPost(piNum, request, response);
    }

    @PostMapping("/posts")
    public int addPost(@RequestParam("piTitle") String title, 
                       @RequestParam("piContent") String content,
                       @RequestParam(required = false) List<String> imageUrls, HttpSession session) {
        if (imageUrls != null && imageUrls.size() > MAX_IMAGES) {
            return 0;
        }
        UserInfoVO user = (UserInfoVO) session.getAttribute("user");
        

        PostInfoVO post = new PostInfoVO();
        post.setPiTitle(title);
        post.setPiContent(content);
        post.setUiNum(user.getUiNum());
        log.info("uiNum{}", post.getUiNum());
        int piNum = postInfoService.insertPostWithImages(post, imageUrls);
        return piNum;
    }

    @PostMapping("/posts/upload")
    public ResponseEntity<Map<String, String>> uploadImage(@RequestParam("file") MultipartFile file) {
        String imageUrl = postInfoService.saveImage(file);
        Map<String, String> response = new HashMap<>();
        
        if (imageUrl != null) {
            response.put("imageUrl", imageUrl);
            return ResponseEntity.ok().body(response); // JSON 형태로 반환
        }
        // 실패 시 JSON으로 에러 메시지 반환
        response.put("error", "Image upload failed");
        return ResponseEntity.status(500).body(response);
    }
    
    @PutMapping("/posts/{piNum}")
    public int modifyPost(@RequestBody PostInfoVO post, @PathVariable int piNum, HttpSession session) {
    	Integer uiNum = (Integer) session.getAttribute("uiNum");
        
        post.setPiNum(piNum);
        post.setUiNum(uiNum);
        return postInfoService.updatePost(post);
    }
    
    @PutMapping("/posts/{piNum}/status")
    public int modifyPostStatus(@PathVariable int piNum, @RequestBody Map<String, String> statusMap) {
        String status = statusMap.get("status");
        return postInfoService.updatePostStatus(piNum, status);
    }
    
    @DeleteMapping("/posts/{piNum}")
    public int removePost(@PathVariable int piNum, HttpSession session) {
        commentInfoService.deleteCommentsByPost(piNum);
        return postInfoService.deletePost(piNum);
    }
}
