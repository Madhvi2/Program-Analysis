

public class test 
{
	int f1;
	String f2;
	static int f3;
	
	public test()
	{
		
	}
	public test(int f1)
	{
		this.f1 = f1;
		test.f3 = 10;
	}
	public test(String f2)
	{
		this.f2 = f2;
	}
	
	public test(int f1, String f2)
	{
		this.f1 = f1;
		this.f2 = f2;
		for(int i = 0; i<10; i++)
		{
			f3 >>= this.f1 + 1; 
		}
		
		for(int j = 0; j<5; j++)
		{
			f3 <<= 2;
		}
	}

	public static int foo(int a) throws IllegalArgumentException
	{
		System.out.println("We are in foo()");
		return a + 2;
	}
	
	public int bar()
	{
		System.out.println("We are in bar");
		return 1;
	}
	public static void fun(int a) throws ArithmeticException
	{
		int x = 0;
		x = 3;
		test.foo(1);
		int y = 0;
		for(int i = 0; i<10; i++)
		{
			for(int j = i; j<20; j++)
			{
				for(int k = j; k<30; k++)
				{
					y = y - x;
				}
			}
		}
		
		for(int i = 0; i<40; i++)
		{
			y = y - 1;
		}
				

		test t = new test();
		int p = t.bar();
		new test("Main").bar();
	}
}