package com.koreait.spring_boot_study.repository;

import com.koreait.spring_boot_study.entity.Post;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Repository
public class PostRepository {
    //CRUD(생성, 조회, 수정, 삭제)
    //DB대용 필드 -sql쿼리로 DB에서 데이터를 받아옴(주로 List로)
    private List<Post> posts=new ArrayList<>(
            Arrays.asList(
                    new Post(1,"페이커vs손흥민","누가 이김?"),
                    new Post(2,"박지성vs손흥민","누가 이김?"),
                    new Post(3,"피카츄vs하이츄","누가 이김?"),
                    new Post(4,"스프링부트공부중","반복 ㄱㄱ")
            )
    );
    
    //전체 게시글 조회,글 제목 조회
    public List<Post> findALlPost(){
        return posts;
    }
    //게시글 단건 조회,글제목 조회
    public String findPost(int id){
        Optional<Post> optionalPost=posts.stream()
                .filter(post->post.getId()==id)
                .findFirst(); //객체가 있으면  Optional로 감싸서 리턴
        // 없으면 null Optional로 감싸서 리턴
        
        if(optionalPost.isEmpty()){
            return "해당 id 상품 없음";
        }
        String targgetName=optionalPost.get().getTitle();
        
        return targgetName;
    }
    
}
