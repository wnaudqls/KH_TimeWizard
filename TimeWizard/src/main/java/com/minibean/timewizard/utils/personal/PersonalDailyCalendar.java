package com.minibean.timewizard.utils.personal;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class PersonalDailyCalendar {

	private static Map<String, Integer> date = new HashMap<String, Integer>();
	private static Calendar cal = Calendar.getInstance();
	
	public PersonalDailyCalendar() {
		date.put("year", cal.get(Calendar.YEAR));
		date.put("month", cal.get(Calendar.MONTH));
		date.put("day", cal.get(Calendar.DATE));
	}
	
	public void setYear(int year) {
		date.put("year", year);
	}
	
	public String getYear() {
		return date.get("year") + "";
	}
	
	public void setMonth(int month) {
		date.put("month", month);
	}
	
	public String getMonth() {
		int month = date.get("month") + 1;
		return month<10 ? "0"+month : "" + month;
	}
	
	public void setDay(int day) {
		date.put("day", day);
	}
	
	public String getDay() {
		int day = date.get("day");
		return day<10 ? "0" + day : "" + day;
	}
	
	@Override
	public String toString() {
		int year = date.get("year");
		int month = date.get("month") + 1; // Calendar.JANUARY = 0;
		int day = date.get("day");
		return "" + year + (month<10 ? "0"+month : month) + (day<10 ? "0" + day : day);
	}
	
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

}
