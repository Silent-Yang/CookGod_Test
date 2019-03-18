package com.forumArt.model;

import java.util.*;
import com.forumMsg.model.ForumMsgVO;

public interface ForumArtDAO_interface {
	
	public void insert (ForumArtVO forumArtVO);
	public void update (ForumArtVO forumArtVO);
	public void delete (String forum_art_ID);
	public ForumArtVO findByPrimarKey (String forum_art_ID);
	public List<ForumArtVO> getAll();
	
	public Set<ForumMsgVO> getForumMsgsByForumArt(String forum_art_ID);

}
