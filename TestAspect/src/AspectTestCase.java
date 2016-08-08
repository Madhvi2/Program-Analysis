import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;


public class AspectTestCase {
	
	public static void HS_safe()
	{
		Collection<Collection<Long>> set_container = new HashSet<Collection<Long>>();
		Collection<Iterator<Long>> iter_container = new HashSet<Iterator<Long>>();
		
		for(int i = 0; i<100; i++)
		{
			Collection<Long> c = new HashSet<Long>();
			set_container.add(c);
			
			for(Long j=(long) 0; j<100; j++)
			{
				c.add(j);
			}
			
			for(Long k=(long) 0; k<60; k++)
			{
				Iterator<Long> it = c.iterator();
				iter_container.add(it);
				Long x = (long) 0;
				
				while(it.hasNext())
				{
					x += it.next();
				}
				c.add(x);
			}
			//System.out.println(c);
			
		}
		System.out.println("The size of set_container is " + 
							set_container.size() + 
							" and the size of iter_container is " + iter_container.size());
	}
	
	
	
	public static void main(String[] args) 
	{
		AspectTestCase.HS_safe();	
		System.exit(0);
	}

}
