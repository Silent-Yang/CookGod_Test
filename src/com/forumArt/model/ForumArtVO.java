package com.forumArt.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;


public class ForumArtVO implements Serializable{

	private String forum_art_ID;
	private String forum_art_name;
	private byte[] forum_art_pic;
	private String forum_art_con;
	private Timestamp forum_art_start;
	private String forum_art_status;
	private String chef_ID;
	
	
	public String getForum_art_ID() {
		return forum_art_ID;
	}
	public void setForum_art_ID(String forum_art_ID) {
		this.forum_art_ID = forum_art_ID;
	}
	public String getForum_art_name() {
		return forum_art_name;
	}
	public void setForum_art_name(String forum_art_name) {
		this.forum_art_name = forum_art_name;
	}
	public byte[] getForum_art_pic() {
		return forum_art_pic;
	}
	public void setForum_art_pic(byte[] forum_art_pic) {
		this.forum_art_pic = forum_art_pic;
	}
	public String getForum_art_con() {
		return forum_art_con;
	}
	public void setForum_art_con(String forum_art_con) {
		this.forum_art_con = forum_art_con;
	}
	public Timestamp getForum_art_start() {
		return forum_art_start;
	}
	public void setForum_art_start(Timestamp forum_art_start) {
		this.forum_art_start = forum_art_start;
	}
	public String getForum_art_status() {
		return forum_art_status;
	}
	public void setForum_art_status(String forum_art_status) {
		this.forum_art_status = forum_art_status;
	}
	public String getChef_ID() {
		return chef_ID;
	}
	public void setChef_ID(String chef_ID) {
		this.chef_ID = chef_ID;
	}
	
	
	
	
}
