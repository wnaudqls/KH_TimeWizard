package com.minibean.timewizard.utils.personal;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class PersonalDailyCalendar {

	private static Map<String, Integer> date = new HashMap<String, Integer>();
	private static Calendar cal = Calendar.getInstance();
	
	public static void setToday() {
		date.put("year", cal.get(Calendar.YEAR));
		date.put("month", cal.get(Calendar.MONTH));
		date.put("day", cal.get(Calendar.DATE));
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	
	public static void plusYear() {
		int dateyear= date.get("year");
		date.put("year", dateyear + 1);
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	public static void minusYear() {
		int dateyear= date.get("year");
		date.put("year", dateyear - 1);
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	
	public static void plusMonth() {
		int datemonth = date.get("month");
		date.put("month", datemonth + 1);
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	
	public static void minusMonth() {
		int datemonth = date.get("month");
		date.put("month", datemonth - 1);
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	
	public static void plusDay() {
		int dateday = date.get("day");
		date.put("day", dateday + 1);
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	
	public static void minusDay() {
		int dateday = date.get("day");
		date.put("day", dateday - 1);
		cal.set(date.get("year"), date.get("month"), date.get("day"));
	}
	
	@Override
	public String toString() {
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1; // Calendar.JANUARY = 0;
		int day = cal.get(Calendar.DATE);
		return "" + year + (month<10 ? "0"+month : month) + (day<10 ? "0" + day : day);
	}
}
