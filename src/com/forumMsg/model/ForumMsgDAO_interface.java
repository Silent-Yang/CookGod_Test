package com.forumMsg.model;

import java.util.*;

public interface ForumMsgDAO_interface {
	
	public void insert (ForumMsgVO forumMsgVO);
	public void update (ForumMsgVO forumMsgVO);
	public void delete (String forum_msg_ID);
	public ForumMsgVO findByPrimaryKey (String forum_msg_ID);
	public List<ForumMsgVO> getAll();

}
