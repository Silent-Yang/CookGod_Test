package com.mall.controller;

import com.foodOrDetail.model.FoodOrDetailVO;

public class CheckType {
	public boolean getIsFOD(Object o) {
		if(o instanceof FoodOrDetailVO) {
			return true;
		}
		else 
			return false;
	}
}
