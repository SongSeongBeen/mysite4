package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {
//공통영역	
	@Autowired
	private SqlSession sqlSession;

//공통영역		

//회원가입
	public int insertUser(UserVo userVo) {
		System.out.println("UserDao.insertUser");

		int count = sqlSession.insert("user.insertUser", userVo);
		System.out.println(count + "명이 등록되었습니다");
		return count;
	}

//로그인		
	public UserVo selectUser(UserVo userVo) {
		System.out.println("UserDao.selectUser");

		sqlSession.selectOne("user.selectUser", userVo);
		UserVo authUser = sqlSession.selectOne("user.selectUser", userVo);

		return authUser;

	}

//회원 1명 번호로	
	public UserVo getUser(int no) {
		return sqlSession.selectOne("user.getUser", no);
	}

// 회원정보 수정
	public int updateUser(UserVo userVo) {
		int count = sqlSession.update("user.updateUser", userVo);
		System.out.println(count + "건이 수정되었습니다");
		return count;
	}

}


