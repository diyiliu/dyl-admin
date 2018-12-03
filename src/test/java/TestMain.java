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
}
