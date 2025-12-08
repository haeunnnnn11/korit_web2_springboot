package com.koreait.spring_boot_study.repository.mapper;

import com.koreait.spring_boot_study.entity.RefreshToken;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;

import java.time.LocalDateTime;
import java.util.Optional;

@Mapper
public interface RefreshTokenMapper {
    //insert
    int insertRefreshToken(
            @Param("userId") int userId,
            @Param("token") String token,
            @Param("expireAt") LocalDateTime expireAt
    );
    //토큰값으로 조회 -select
    Optional<RefreshToken> findByToken(@Param("token") String token);

    //재발급 - update
    int updateRefreshToken(
            @Param("oldToken") String oldToken,
            @Param("newToken") String newToken
    );


    //삭제 - delete
}
