package com.forumMsg.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class ForumMsgVO implements Serializable{

	private String forum_msg_ID;
	private String forum_msg_con;
	private Timestamp forum_msg_start;
	private String forum_msg_status;
	private String forum_art_ID;
	private String cust_ID;
	
	public String getForum_msg_ID() {
		return forum_msg_ID;
	}
	public void setForum_msg_ID(String forum_msg_ID) {
		this.forum_msg_ID = forum_msg_ID;
	}
	public String getForum_msg_con() {
		return forum_msg_con;
	}
	public void setForum_msg_con(String forum_msg_con) {
		this.forum_msg_con = forum_msg_con;
	}
	public Timestamp getForum_msg_start() {
		return forum_msg_start;
	}
	public void setForum_msg_start(Timestamp forum_msg_start) {
		this.forum_msg_start = forum_msg_start;
	}
	public String getForum_msg_status() {
		return forum_msg_status;
	}
	public void setForum_msg_status(String forum_msg_status) {
		this.forum_msg_status = forum_msg_status;
	}
	public String getForum_art_ID() {
		return forum_art_ID;
	}
	public void setForum_art_ID(String forum_art_ID) {
		this.forum_art_ID = forum_art_ID;
	}
	public String getCust_ID() {
		return cust_ID;
	}
	public void setCust_ID(String cust_ID) {
		this.cust_ID = cust_ID;
	}
	
	
	
}