package com.dish.model;

import java.util.*;
import com.food.model.*;


public interface DishDAO_interface {

	public void insert (DishVO dishVO);
	public void update (DishVO dishVO);
	public void delete (String dish_ID);
	public DishVO findByPrimaryKey (String dish_ID);
	public List<DishVO> getAll();
	
	//public void insertWithFoods(DishVO dishVO , List<FoodVO> list);

}
