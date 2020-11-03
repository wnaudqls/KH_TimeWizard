package com.minibean.timewizard.utils.login;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;


public class DistinctStringMaker {

	public static void main(String args[]) throws NoSuchAlgorithmException {
		Scanner sc = new Scanner(System.in);
		System.out.print("id : ");
		String id = sc.nextLine();
		System.out.println("email : ");
		String email = sc.nextLine();
		System.out.println(makeDistinctString(id, email));
		// 4b3884d76c8ca6ed5972767b7bf89d385b50da815be0541228fec26ca43c88e9
		// c30a1041380d9995706c2745d1c8033d94a2fa6300ffc64c1d5412766870ab4e
		// cddbb6a58217c8196b5710327a7b6ddf3ea76fd913667e0e3f24689b631856a5
	}
	
	
	public static String makeDistinctString(String id, String email) throws NoSuchAlgorithmException {
	    MessageDigest md = MessageDigest.getInstance("SHA-256");
	    StringBuffer sb = new StringBuffer();
	    int randomNum = (int) (Math.random()*100 + 1);
	    sb.append(id.substring(0,4))
		    .append(email.split("@")[0])
		    .append(randomNum);
	    md.update(sb.toString().getBytes());
	    StringBuffer sb2 = new StringBuffer();
	    for(byte b: md.digest()) {
	    	sb2.append(String.format("%02x", b));
	    }
	    return sb2.toString();
//	출처: https://offbyone.tistory.com/286 [쉬고 싶은 개발자]
	}
}
