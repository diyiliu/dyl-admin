import org.junit.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Description: TestMain
 * Author: DIYILIU
 * Update: 2018-12-03 15:47
 */
public class TestMain {

    public static void main(String[] args) {

        String str = ".\\upload\\pic\\201811\\pic5204028673149667661.jpg";

        System.out.println(str);

        System.out.println(str.replaceAll("\\\\",  "/"));
    }

    @Test
    public void test(){

        String str = "<link rel=\"canonical\" href=\"https://mvnrepository.com/\"/><link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"/assets/images/7080b8b0f6f48e6fbaffd5f9d85fcc7f-favicon.ico\">";

        // 取出有用的范围
        Pattern p = Pattern.compile("<link[^<]+rel=\"[^\"]*icon[^\"]*\"[^>]+>");
        Matcher m = p.matcher(str);
        if (m.find()) {
            String path = m.group();
            int index = path.indexOf("href=");
            path = path.substring(index + 6);
            index = path.indexOf("\"");
            System.out.println(path.substring(0, index));
        }
    }
}
