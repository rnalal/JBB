package com.naver.jbb.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.CommentDto;

@Repository
public class CommentDaoImpl implements CommentDao {
	
	@Autowired
	private SqlSession session;
	private static String namespace="com.naver.jbb.dao.CommentMapper.";
	
	//댓글 개수
	@Override
	public int count(Integer bno) throws Exception {
		return session.selectOne(namespace+"count", bno);
	}
	
	//댓글 삭제
	@Override
	public int delete(Integer cno, String commenter) throws Exception {
		Map map = new HashMap();
		map.put("cno", cno);
		map.put("commenter", commenter);
		return session.delete(namespace+"delete", map);
	}
	
	//특정 게시글에 있는 댓글 모두 삭제
	@Override
	public int deleteAll(Integer bno) throws Exception {
		return session.delete(namespace+"deleteAll", bno);
	}
	
	//댓글 등록
	@Override
	public int insert(CommentDto commentDto) throws Exception {
		return session.insert(namespace+"insert", commentDto);
	}
	
	//댓글 목록
	public List<CommentDto> selectAll(Integer bno) throws Exception {
		return session.selectList(namespace+"selectAll", bno);
	}
	
	//댓글 상세보기
	@Override
    public CommentDto select(Integer cno) throws Exception {
        return session.selectOne(namespace + "select", cno);
    }
	
	//댓글 수정
	@Override
    public int update(CommentDto dto) throws Exception {
        return session.update(namespace+"update", dto);
    }
}
