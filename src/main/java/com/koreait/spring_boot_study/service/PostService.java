package com.koreait.spring_boot_study.service;

import com.koreait.spring_boot_study.entity.Post;
import com.koreait.spring_boot_study.repository.PostRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PostService {
    private final PostRepository postRepository;

    public PostService(PostRepository postRepository){
        this.postRepository=postRepository;
    }

    //전체 글제목 조회
    public List<String> getAllPostName(){
        List<String> postName=new ArrayList<>();
        List<Post> posts=postRepository.findALlPost();
        for(Post post:posts){
            postName.add(post.getTitle());
        }
        return postName;
    }

    // 게시글 단건 조회: isEmpty->정석)예외를 던져야함
    public String getPostTitleById(int id){
        String targgetName=postRepository.findPost(id);
        return targgetName;
    }

}
