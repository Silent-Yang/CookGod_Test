package com.foodOrder.model;

public class FoodOrderCompQuery {
	
	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("food_or_status".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if ("cust_name".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		else if ("food_or_send".equals(columnName))                          // 用於Oracle的date
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";
		return aCondition + " ";
	}
	
	//public static String getWhereCondition(Map<String, String[]> map) {
		
	//}
}
