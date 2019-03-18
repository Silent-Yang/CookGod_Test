package com.chef.model;

import java.util.List;

import com.cust.model.CustVO;

public interface ChefDAO_Interface {
	
	public void insert(CustVO custVO, ChefVO chefVO);
    public void update(ChefVO chefVO);
    public void delete(String chef_ID);
    public ChefVO findByPrimaryKey(String chef_ID);
    public List<ChefVO> getAllByChefArea(String chef_area);
    public List<ChefVO> getAll();
//  萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<ChefVO> getAll(Map<String, String[]> map);
}
