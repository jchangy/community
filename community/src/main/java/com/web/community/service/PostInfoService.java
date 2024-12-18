package com.web.community.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.community.mapper.CommentInfoMapper;
import com.web.community.mapper.PostInfoMapper;
import com.web.community.vo.ImageInfoVO;
import com.web.community.vo.PostInfoVO;
import com.web.community.vo.ResultList;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PostInfoService {

    @Autowired
    private PostInfoMapper postInfoMapper;
    @Autowired
    private ImageInfoService imageInfoService;
    @Autowired
    private CommentInfoMapper commentInfoMapper;
    @Value("${file.upload.path}")
    private String uploadDir;
    private static final int DEFAULT_COUNT = 10;

    public List<Map<String, Object>> getHotPosts() {
        // 조회수와 좋아요 수를 기준으로 상위 3개의 게시글을 가져옴
    	log.info("화제글 서비스 호출");
        List<Map<String, Object>> posts = postInfoMapper.selectHotPosts();
        log.info("조회된 화제글: {}", posts);
        return posts;
    }
    
    // 게시글 목록 조회
    public ResultList<PostInfoVO> selectPosts(PostInfoVO post) {
        if (post.getCount() == 0) {
            post.setCount(DEFAULT_COUNT);
        }
        if (post.getPage() != 0) {
            int start = (post.getPage() - 1) * post.getCount();
            post.setStart(start);
        }
        ResultList<PostInfoVO> rl = new ResultList<>();
        List<PostInfoVO> posts = postInfoMapper.selectPosts(post);
        rl.setList(posts);
        int totalCnt = postInfoMapper.selectPostsTotal(post);
        rl.setCount(totalCnt);

        int postNumber = totalCnt - post.getStart();
        for (PostInfoVO postInfo : posts) {
            postInfo.setPostNum(postNumber--);
            PostInfoVO latestPostInfo = postInfoMapper.selectPost(postInfo.getPiNum());
            postInfo.setPiViews(latestPostInfo.getPiViews());  // 최신 조회수 반영
        }

        return rl;
    }
    
    // 게시글 목록 조회
    public ResultList<PostInfoVO> selectPostsForAdmin(PostInfoVO post) {
        if (post.getCount() == 0) {
            post.setCount(DEFAULT_COUNT);
        }
        if (post.getPage() != 0) {
            int start = (post.getPage() - 1) * post.getCount();
            post.setStart(start);
        }
        ResultList<PostInfoVO> rl = new ResultList<>();
        List<PostInfoVO> posts = postInfoMapper.selectPostsForAdmin(post);
        rl.setList(posts);
        int totalCnt = postInfoMapper.selectPostsTotal(post);
        rl.setCount(totalCnt);

        int postNumber = totalCnt - post.getStart();
        for (PostInfoVO postInfo : posts) {
            postInfo.setPostNum(postNumber--);
            PostInfoVO latestPostInfo = postInfoMapper.selectPost(postInfo.getPiNum());
            postInfo.setPiViews(latestPostInfo.getPiViews());  // 최신 조회수 반영
        }
        return rl;
    }
    
    public PostInfoVO selectNextPost(int piNum) {
    	return postInfoMapper.selectNextPost(piNum);
    }
    
    public PostInfoVO selectPrevPost(int piNum) {
    	return postInfoMapper.selectPrevPost(piNum);
    }

    // 게시글 상세보기
    public PostInfoVO selectPost(int piNum, HttpServletRequest request, HttpServletResponse response) {
        // DB에서 게시글 조회
        PostInfoVO postInfo = postInfoMapper.selectPost(piNum);

        // 쿠키에서 조회수를 가져오고, 첫 방문일 경우 조회수 증가
        int viewCount = getViewCountFromCookie(request, piNum);

        if (viewCount == 0) {  // 첫 방문일 때만 조회수 증가
            // DB에서 조회수 증가
            int newViewCount = postInfo.getPiViews() + 1;  // 기존 조회수에 1을 더함
            postInfoMapper.updateViewCount(piNum, newViewCount);  // DB에 반영

            // 쿠키에 조회수 저장
            viewCount = incrementViewCount(viewCount);  // 조회수 증가
            saveViewCountToCookie(response, piNum, viewCount);  // 쿠키에 저장

            // 게시글 정보에 최신 조회수 반영 (디스플레이용)
            postInfo.setPiViews(newViewCount);  
        } else {
            // 첫 방문이 아닐 경우 DB에서 최신 조회수를 가져옴
            postInfo = postInfoMapper.selectPost(piNum);
        }

        return postInfo;
    }
    
    // 게시글 조회수 업데이트
    public int updatePostViewCount(int piNum, int newViewCount) {
        return postInfoMapper.updateViewCount(piNum, newViewCount);
    }

    // 게시글 및 이미지 등록
    public int insertPostWithImages(PostInfoVO post, List<String> imageUrls) {
        int insertResult = postInfoMapper.insertPost(post);
        int generatedPiNum = post.getPiNum();

        if (insertResult > 0 && imageUrls != null && !imageUrls.isEmpty()) {
            List<ImageInfoVO> images = new ArrayList<>();
            for (String imgUrl : imageUrls) {
                ImageInfoVO image = new ImageInfoVO();
                image.setImgUrl(imgUrl);
                image.setPiNum(generatedPiNum);
                images.add(image);
            }
            imageInfoService.insertImages(images);
        }

        return insertResult > 0 ? generatedPiNum : -1;
    }

    // 이미지 저장
    public String saveImage(MultipartFile file) {
        String fileName = System.nanoTime() + "_" + file.getOriginalFilename();
        File targetFile = new File(uploadDir + fileName);

        try {
            file.transferTo(targetFile);
            log.info("이미지 저장 성공: {}", fileName);
        } catch (IOException e) {
            log.error("이미지 저장 실패: {}", e.getMessage());
            return null;
        }
        return "/uploads/" + fileName;
    }

    // 게시글 수정
    public int updatePost(PostInfoVO post) {
        return postInfoMapper.updatePost(post);
    }

    // 게시글 및 관련 데이터 삭제 (댓글, 이미지 포함)
    public int deletePost(int piNum) {
        commentInfoMapper.deleteCommentsByPost(piNum);
        imageInfoService.deleteImg(piNum);
        return postInfoMapper.deletePost(piNum);
    }
    
    // 쿠키에서 조회수 가져오기
    private int getViewCountFromCookie(HttpServletRequest request, int piNum) {
        Cookie[] cookies = request.getCookies();
        int viewCount = 0;  // 기본값은 0
        String cookieName = "viewCount_" + piNum;  // 게시글마다 고유한 쿠키 이름

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    try {
                        viewCount = Integer.parseInt(cookie.getValue()); // 쿠키에 저장된 값을 가져옴
                    } catch (NumberFormatException e) {
                        // 쿠키 값이 숫자가 아니면 0으로 처리
                        viewCount = 0;
                    }
                    break;
                }
            }
        }

        return viewCount;
    }

    // 조회수 증가
    private int incrementViewCount(int currentViewCount) {
        return currentViewCount + 1;
    }

    private void saveViewCountToCookie(HttpServletResponse response, int piNum, int newViewCount) {
        String cookieName = "viewCount_" + piNum;  // 게시글마다 고유한 쿠키 이름
        
        // 쿠키 생성
        Cookie cookie = new Cookie(cookieName, String.valueOf(newViewCount));
        cookie.setMaxAge(30 * 24 * 60 * 60);  // 쿠키를 30일 동안 유지
        cookie.setPath("/");  // 모든 경로에서 접근 가능
        cookie.setHttpOnly(true);  // 클라이언트 측 자바스크립트에서 쿠키에 접근 못 하게 함
        cookie.setSecure(true);  // HTTPS 연결에서만 쿠키가 전송되게 설정 (HTTPS일 경우)
        
        // 쿠키를 클라이언트로 전달
        response.addCookie(cookie);
    }
    
    public int updatePostStatus(int piNum, String status) {
        return postInfoMapper.updatePostStatus(piNum, status);
    }
}
