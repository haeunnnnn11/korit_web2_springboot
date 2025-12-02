package com.koreait.spring_boot_study.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter @ToString
public class Post { //테이블명:post ->필드:Post
    private int id; //컬럼명 :post_id->필드:postId
    private String title; //컬럼명:post_title ->필드: postTitle
    private String content; //컬럼명:post_content ->필드:postContent
}
