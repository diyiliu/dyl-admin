import net.coobird.thumbnailator.Thumbnails;
import org.junit.Test;

import java.io.IOException;
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

    @Test
    public void test1()throws IOException {
        String imagePath = "C:\\Users\\DIYILIU\\Desktop\\test\\4.jpg";
        String outPath = "C:\\Users\\DIYILIU\\Desktop\\test\\44.jpg";

        //保持纵横比，质量降低
        Thumbnails.of(imagePath).scale(1).outputQuality(0.5).toFile(outPath);
    }
}
