package com.foodOrder.model;

import java.util.List;
import java.util.Set;

import com.foodOrDetail.model.FoodOrDetailVO;


public interface FoodOrderDAO_interface {
	void insert(FoodOrderVO foodOrderVO);
	public void insertWithFoodDetails(FoodOrderVO foodOrderVO, List<FoodOrDetailVO> foodODList);
	void update(FoodOrderVO foodOrderVO);
	void delete(String food_or_ID);
	FoodOrderVO findByPrimaryKey(String food_or_ID);
	List<FoodOrderVO> getAll();
	Set<FoodOrDetailVO> getFoodOrDetailsByFood_or_ID(String food_or_ID);
}
