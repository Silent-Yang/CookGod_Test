package com.dishFood.model;

import java.util.*;
import com.food.model.FoodVO;

	public interface DishFoodDAO_interface {
		
		public void insert (DishFoodVO dishFoodVO);
		public void update (DishFoodVO dishFoodVO);
		public void delete (String dish_ID,String food_ID);
		public DishFoodVO findByPrimaryKey(String dish_ID,String food_ID);
		public List<DishFoodVO> getAll();
		
		public Set<DishFoodVO> getFoodsByDish(String dish_ID);
		
	}


