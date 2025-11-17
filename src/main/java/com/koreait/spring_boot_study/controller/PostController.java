package com.koreait.spring_boot_study.controller;

import com.koreait.spring_boot_study.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/post")
public class PostController {
    private final PostService postService;

    @Autowired
    public PostController(PostService postService){
        this.postService=postService;
    }

    @GetMapping("/name/all")
    public ResponseEntity<?> getPostNames(){
        return ResponseEntity.ok(postService.getAllPostName());
    }

    @GetMapping("/name/{id}")
    public ResponseEntity<?> getPostTitle(@PathVariable int id){
        return ResponseEntity.ok(postService.getPostTitleById(id));
    }

    }



