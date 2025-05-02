package com.naver.jbb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.jbb.dao.BoardDao;
import com.naver.jbb.dao.CommentDao;
import com.naver.jbb.domain.CommentDto;
import com.naver.jbb.domain.Notification;

@Service
public class CommentServiceImpl implements CommentService{

	@Autowired
	BoardDao boardDao;
	@Autowired
	CommentDao commentDao;
	@Autowired
	NotificationService notificationService;
	
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
		// 1) 댓글 수 증가 & DB 저장
        boardDao.updateCommentCnt(commentDto.getBno(), 1);
        int rowCnt = commentDao.insert(commentDto);
        
        // 2) 글쓴이 아이디 조회
        String postOwner = boardDao.findWriterByBno(commentDto.getBno());
        
        // 3) 알림 객체 생성
        Notification noti = new Notification();
        noti.setRecipient(postOwner);
        noti.setType("COMMENT");
        noti.setMessage(commentDto.getCommenter() + "님이 댓글을 남겼습니다.");
        noti.setUrl("/board/read?bno=" + commentDto.getBno());
        
        // 4) 알림 전송
        notificationService.sendToUser(postOwner, noti);
        
        return rowCnt;
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
