
public class Madhur_Program {
	int shama = 0;
	char madho = 'm';
	
	public static void foo(){
		int Akshu = 10;
		int i=0;
		while(i < Akshu){
			System.out.println(i);
			i++;
		}
		System.out.println("I am in new method");
	}
	public static int minFunction(int n1, int n2) {
		   int min;
		   if (n1 > n2)
		      min = n2;
		   else
		      min = n1;

		   return min; 
	} 
	public static void main(String args)
	{
		System.out.print("Hello");
		int i=0;
		while(i<5)
		{
			int j=0;
			System.out.print(i+1);
			
			while(j<5)
			{
				System.out.print("\t "+i);
				j++;
			}
			i++;
		}
		foo();
	}
	
	
	
	

}
