package shoppingcart.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Utilities {
	
	//if string is null convert to empty
	public static String checkString(String arg) {
		if(null == arg || "null".equals(arg))
			return "";

		return arg;
	}
	
	public static int checkInt(String arg) {

		try {
			
			if(null != arg && !"null".equals(arg)){
				return Integer.parseInt(arg);
			}	

		} catch(NumberFormatException nfe) {
		}

		return 0;
	}
	
	public static double checkDouble(String arg) {

		try {
			
			if(null != arg && !"null".equals(arg)){
				return Double.parseDouble(arg);
			}	

		} catch(NumberFormatException nfe) {
		}

		return 0;
	}
	
    public static Timestamp convertFormattedStringToSqlTimeStamp(String strDate) {
        Timestamp timeStamp = null;
        if(strDate != null) {
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            try {
                java.util.Date date = sf.parse(strDate);
                timeStamp = Timestamp.valueOf(sf.format(date));
            } catch(ParseException pe) {
            	System.out.println((new StringBuilder("Exception occurred while converting String ")).append(strDate).append(" to java.util.Timestamp due to the bad input data").append(pe).toString());
            }
        }
        return timeStamp;
    }

    public static String formatDateString(String inDateString, String inPattern, String outPattern){
        String outDateStr = null;
        try{
            SimpleDateFormat sdfIn = new SimpleDateFormat(inPattern);
            java.util.Date inDate = sdfIn.parse(inDateString);
            SimpleDateFormat sdfOut = new SimpleDateFormat(outPattern);
            outDateStr = sdfOut.format(inDate);
        }
        catch(ParseException pex){
            System.out.println((new StringBuilder("Exception occurred in formatDateString ")).append(pex).toString());
            return outDateStr;
        }
        return outDateStr;
    }

}
