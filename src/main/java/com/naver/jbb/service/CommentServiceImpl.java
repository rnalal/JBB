package com.naver.jbb.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.jbb.dao.BoardDao;
import com.naver.jbb.dao.CommentDao;
import com.naver.jbb.domain.CommentDto;

@Service
public class CommentServiceImpl implements CommentService{

	@Autowired
	BoardDao boardDao;
	@Autowired
	CommentDao commentDao;
	
	//댓글 개수
	@Override
	public int getCount(Integer bno) throws Exception {
		return commentDao.count(bno);
	}
	
	//댓글 삭제
	@Override
    @Transactional(rollbackFor = Exception.class) //예외가 발생하면 롤백
    public int remove(Integer cno, Integer bno, String commenter) throws Exception {
        int rowCnt = boardDao.updateCommentCnt(bno, -1);
        rowCnt = commentDao.delete(cno, commenter);
        return rowCnt;
    }
	
	//댓글 등록
	@Override
    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception {
        boardDao.updateCommentCnt(commentDto.getBno(), 1);
        return commentDao.insert(commentDto);
    }
	
	//댓글 목록
	@Override
    public List<CommentDto> getList(Integer bno) throws Exception {
        return commentDao.selectAll(bno);
    }
	
	//댓글 상세보기
	@Override
    public CommentDto read(Integer cno) throws Exception {
        return commentDao.select(cno);
    }
	
	//댓글 수정
	@Override
    public int modify(CommentDto commentDto) throws Exception {
        return commentDao.update(commentDto);
    }
}
