package com.forumMsg.model;

import java.sql.Timestamp;
import java.util.List;

public class ForumMsgService {

	private ForumMsgDAO_interface dao;
	
	public ForumMsgService(){
		dao = new ForumMsgDAO();
	}
	
	public ForumMsgVO addForumMsg(String forum_art_ID,String forum_msg_con,String forum_msg_status,String cust_ID) {
		
		ForumMsgVO forumMsgVO = new ForumMsgVO();
		
		forumMsgVO.setForum_art_ID(forum_art_ID);
		forumMsgVO.setForum_msg_con(forum_msg_con);
		forumMsgVO.setForum_msg_status(forum_msg_status);
		forumMsgVO.setCust_ID(cust_ID);
		dao.insert(forumMsgVO);
		
		return forumMsgVO;
	}
	
	public ForumMsgVO updateForumMsg(String forum_art_ID,
			String forum_msg_con,Timestamp forum_msg_start,String forum_msg_status,String cust_ID,String forum_msg_ID) {
		
		ForumMsgVO forumMsgVO = new ForumMsgVO();
		
		
		forumMsgVO.setForum_art_ID(forum_art_ID);
		forumMsgVO.setForum_msg_con(forum_msg_con);
		forumMsgVO.setForum_msg_start(forum_msg_start);
		forumMsgVO.setForum_msg_status(forum_msg_status);
		forumMsgVO.setCust_ID(cust_ID);
		forumMsgVO.setForum_msg_ID(forum_msg_ID);
		
		dao.update(forumMsgVO);
		
		return forumMsgVO;
		
	}
	
	public void  deleteForumMsg(String forum_msg_ID) {
		dao.delete(forum_msg_ID);
	}
	public ForumMsgVO getOneForumMsg(String forum_msg_ID) {
		return dao.findByPrimaryKey(forum_msg_ID);
	}
	public List <ForumMsgVO> getAll(){
		return dao.getAll();
	}
}
