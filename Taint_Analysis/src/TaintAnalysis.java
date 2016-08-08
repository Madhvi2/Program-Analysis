import java.util.Iterator;
import java.util.List;

import soot.*;
import soot.jimple.AssignStmt;
import soot.jimple.CastExpr;
import soot.jimple.IdentityStmt;
import soot.jimple.InvokeExpr;
import soot.jimple.InvokeStmt;
import soot.jimple.StaticInvokeExpr;
import soot.jimple.Stmt;
import soot.jimple.VirtualInvokeExpr;
import soot.jimple.internal.JInvokeStmt;
import soot.toolkits.graph.DirectedGraph;
import soot.toolkits.graph.UnitGraph;
import soot.toolkits.scalar.ArraySparseSet;
import soot.toolkits.scalar.FlowSet;
import soot.toolkits.scalar.ForwardFlowAnalysis;
import soot.util.Chain;


public class TaintAnalysis extends  ForwardFlowAnalysis {
	
	private FlowSet gen;
	private FlowSet taintVar = new ArraySparseSet();
	
	public TaintAnalysis(UnitGraph graph) {
		super(graph);
		//System.out.println(graph);
		Chain<Unit> units = graph.getBody().getUnits();
        for (Unit unit:units){
		    if (unit instanceof IdentityStmt) {
		    	if(((IdentityStmt) unit).getLeftOp().toString() != "this")
		    	{
			        taintVar.add(((IdentityStmt) unit).getLeftOp().toString());
		    	}
		    }
        }
        System.out.println(taintVar);
		doAnalysis();
	}
	
	@Override
	protected Object newInitialFlow() {
		return new ArraySparseSet();
	}	

	@Override
	protected void flowThrough(Object in, Object unit, Object out) {
		
		Stmt s = (Stmt) unit ;
				
				Iterator useBox = s.getUseBoxes().iterator();						  
				Iterator defBox = s.getDefBoxes().iterator();   
				Boolean flag = false;
				while(useBox.hasNext())
				{
					final ValueBox box = (ValueBox) useBox.next(); 
						Value use = box.getValue(); 
						Iterator it = taintVar.iterator();
					while(it.hasNext())
					{
						if(it.next().toString().equals(use.toString()))
						{
							flag = true;
							
						}
					}	
				}
				if(flag)
				{
					while(defBox.hasNext())
					{
						final ValueBox box = (ValueBox) defBox.next(); 
							Value def = box.getValue(); 
							taintVar.add(def.toString());
					}
				}
				
				
				
				if(s instanceof InvokeStmt)
				{
					flag = false;
					 if(((InvokeStmt) s).getInvokeExpr() instanceof VirtualInvokeExpr) {
		                 useBox = s.getUseBoxes().iterator();
		                 while(useBox.hasNext())
		         		{
		         			final ValueBox box = (ValueBox) useBox.next(); 
		         			Value def = box.getValue(); 
		         			Iterator it2 = taintVar.iterator();
		         			while(it2.hasNext())
		         			{
		         				if(it2.next().toString().equals(def.toString()))
		         				{
		         					System.out.println("Tainted Variable reached sink: " + def.toString());
		         					flag = true;
		         				}
		         			}	
		         		}
		                 
					 }
					 
				}
	}
	
	@Override
	protected void copy(Object source, Object dest) {
		// TODO Auto-generated method stub
		FlowSet srcSet = (FlowSet)source,
				destSet = (FlowSet)dest; 
				srcSet.copy(destSet);
	}

	@Override
	protected Object entryInitialFlow() {
		// TODO Auto-generated method stub
		return taintVar;
	}

	@Override
	protected void merge(Object in1, Object in2, Object out) {
		// TODO Auto-generated method stub
		FlowSet inSet1 = (FlowSet)in1,
				inSet2 = (FlowSet)in2,
				outSet = (FlowSet)out; 
				inSet1.union(inSet2, outSet);
				
	}
	
}
