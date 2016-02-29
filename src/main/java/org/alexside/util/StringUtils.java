package org.alexside.util;

/**
 * Created with IntelliJ IDEA.
 * User: Alex
 * Date: 09.01.16
 * Time: 18:49
 */
public class StringUtils {

    public static boolean isEmpty(String str) {
        if (str == null || str.isEmpty()) return true;
        return false;
    }
}
