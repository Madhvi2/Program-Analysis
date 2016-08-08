public class Test7
{
  public static int globalVar = 0;

  public void foo(String str,
                  int n)
  {
    int x = 0;
    int y = n + 2;
    String z = str + "foo";
    this.globalVar = x;
  }
}
