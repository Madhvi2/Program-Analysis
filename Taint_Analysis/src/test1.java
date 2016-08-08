
public class test1 {

	/**
	 * @param args
	 */
	
	
	 void foo(int x){ // x is tainted
		   int y, z;
		   y = x + 100;
		   int k = go(x);
		   if( x > 5)
		     z = 100;
		   else
		     z = y/20;

		  System.out.println(z);  //sink
		  System.out.println(k);  //sink
		}
	 
	 int go(int x)
	 {
		 return (x+10);
	 }

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//foo(10);
	}

}
