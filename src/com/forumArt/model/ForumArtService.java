package com.forumArt.model;

import java.util.Set;
import java.util.List;
import java.sql.Timestamp;
import com.forumMsg.model.ForumMsgVO;


public class ForumArtService {

	private ForumArtDAO_interface dao;
	
	public ForumArtService() {
		dao = new ForumArtDAO();
	}
	
	public ForumArtVO addForumArt(String forum_art_name,byte[] forum_art_pic,String forum_art_con,String forum_art_status,String chef_ID) {

		
		ForumArtVO forumArtVO = new ForumArtVO();
		
		forumArtVO.setForum_art_name(forum_art_name);
		forumArtVO.setForum_art_pic(forum_art_pic);
		forumArtVO.setForum_art_con(forum_art_con);;
		forumArtVO.setForum_art_status(forum_art_status);
		forumArtVO.setChef_ID(chef_ID);
		
		dao.insert(forumArtVO);
		
		return forumArtVO;
	}

	
	
	public ForumArtVO updateForumArt(String forum_art_ID,String forum_art_name,byte[] forum_art_pic,
				String forum_art_con,Timestamp forum_art_start,String forum_art_status,String chef_ID) {
	
	
		ForumArtVO forumArtVO = new ForumArtVO();
		
		forumArtVO.setForum_art_ID(forum_art_ID);
		forumArtVO.setForum_art_name(forum_art_name);
		forumArtVO.setForum_art_pic(forum_art_pic);
		forumArtVO.setForum_art_con(forum_art_con);
		forumArtVO.setForum_art_start(forum_art_start);
		forumArtVO.setForum_art_status(forum_art_status);
		forumArtVO.setChef_ID(chef_ID);
		
		dao.update(forumArtVO);
		
		return forumArtVO;
		
	}
	
	public void deleteForumArt(String forum_art_ID) {
		dao.delete(forum_art_ID);
	}
	
	public ForumArtVO getOneForumArt(String forum_art_ID) {
		return dao.findByPrimarKey(forum_art_ID);
	}
	
	public List<ForumArtVO> getAll(){
		return dao.getAll();
	}
	public Set<ForumMsgVO> getForumMsgsByForumArt(String forum_art_ID){
		return dao.getForumMsgsByForumArt(forum_art_ID);
	} 
}
