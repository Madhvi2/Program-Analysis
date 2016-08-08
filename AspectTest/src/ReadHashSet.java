import java.util.HashSet;
import java.util.Iterator;
import java.util.Collection;
import java.util.Comparator;

//public class ReadHashSet {
//    public static void main(String a[]){
//        HashSet<String> hs = new HashSet<String>();
//        //add elements to HashSet
//        hs.add("first");
//        hs.add("second");
//        hs.add("third");
//        Iterator<String> itr = hs.iterator();
//        while(itr.hasNext()){
//            System.out.println(itr.next());
//        }
//    }
//
//}
public class ReadHashSet {
public static void HS_safe()
{
	Collection<Collection<Long>> set_container = new HashSet<Collection<Long>>();
	Collection<Iterator<Long>> iter_container = new HashSet<Iterator<Long>>();
	
	for(int i = 0; i<4; i++)
	{
		Collection<Long> c = new HashSet<Long>();
		set_container.add(c);
		
		for(Long j=(long) 0; j<4; j++)
		{
			c.add(j);
		}
		
		for(Long k=(long) 0; k<2; k++)
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
	/*
	 * Choose any collection and write aspects for it
	 * Concurrent Hash Map
	 * Hash Set
	 * Tree Set
	 * Priority Queue
	 */
	ReadHashSet.HS_safe();
	
	System.exit(0);
}
}