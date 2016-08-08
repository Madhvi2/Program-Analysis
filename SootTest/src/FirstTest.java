import java.io.IOException;


public class FirstTest {

	/**
	 * @param args
	 */
	String test;
	String test1;
	int tt;
	static int aa;
	
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		int x=6;
		int y=8;
		int z=9;
		int k= x + y+ z;
		System.out.print("Test Soot");
		sum(3,4,"test");
	}
	
	public static void sum(int a, int b, String C)
	{
		int c1 = a+b;
		aa =c1+5;
		int z=0;
		while(z<10)
		{
			z++;
			int k=0;
			while(k<3)
			{
				k++;
			}
		}
		z=5;
		while(z<10)
		{
			z++;
		}
		prnt();
		//return c;
	}
	public static void prnt()
	{
		System.out.println("Success");
	}

}
