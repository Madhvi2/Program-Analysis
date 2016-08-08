//@author : Aritra Dhar

import java.util.ArrayList;
import java.util.Scanner;


public class SampleTaint 
{

	public ArrayList<String> getInput()
	{
		ArrayList<String> input = new ArrayList<String>();
		
		Scanner s = new Scanner(System.in);
		
		input.add(s.next());
		input.add(s.next());
		input.add(s.next());
		
		
		s.close();
		
		return input;
	}
	
	//parameters contain any number of string object
	public void printOutPut(String ... inputs)
	{
		for (Integer i = 0; i < inputs.length; i++)
		{
			if(i%2 == 0)
			{
				/*
				if this goes to print stream you should flag it
				*/
				inputs[i] = inputs[i].concat(i.toString());
			}
			else if(i%3 == 0)
			{
				/*
				if this goes to print stream you should flag it
				*/
				inputs[i] = inputs[i].substring(0, inputs[i].length()/2);
			}
			else
			{
				/*
				 * Assigned to new string, may not be a problem
				 */
				inputs[i] = "NOT TAINTED NOW";
			}
			
			System.out.println(inputs[i]);
		}
		
	}
	
	
	public static void main(String[] args) 
	{
		SampleTaint ST = new SampleTaint();
		ArrayList<String> input = ST.getInput();
		
		ST.printOutPut( input.get(1) );
		
		ST.printOutPut( input.get(2), input.get(2) );
	}
}