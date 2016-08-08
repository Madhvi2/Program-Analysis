
import java.lang.reflect.Method;
import java.util.*;

import soot.Body;
import soot.BodyTransformer;
import soot.Local;
import soot.PatchingChain;
import soot.Scene;
import soot.SootClass;
import soot.SootField;
import soot.SootMethod;
import soot.Unit;
import soot.Value;
import soot.ValueBox;
import soot.jimple.AssignStmt;
import soot.jimple.DefinitionStmt;
import soot.jimple.FieldRef;
import soot.jimple.IdentityStmt;
import soot.jimple.InvokeStmt;
import soot.jimple.StaticFieldRef;
import soot.jimple.StaticInvokeExpr;
import soot.jimple.Stmt;
import soot.toolkits.graph.ExceptionalUnitGraph;
import soot.toolkits.graph.LoopNestTree;
import soot.toolkits.graph.UnitGraph;
import soot.util.Chain;



public class SimpleAnalysis extends  BodyTransformer  {

		 protected void internalTransform(Body body, String arg1, Map arg2) {
			SootClass c = Scene.v().loadClassAndSupport("test");
			Chain<SootField> fld = c.getFields();
			
			/*Fields of a class*/ 
			Iterator<SootField> it =fld.iterator();
			while(it.hasNext()){
				SootField loc =it.next();
				//System.out.println("Fields of a class: \t" + loc.getName());
				
			}
			
			List<SootMethod> sootmethod = c.getMethods();
			Iterator<SootMethod> method = sootmethod.iterator();
			while(method.hasNext()){
				SootMethod m = method.next();
	
				/* Method Name with its signature and exception thrown by it*/
	
				if(!(m.getName().equalsIgnoreCase("<init>"))) {
					System.out.println("Method Name:\t" + m.getName());
					System.out.println("Signature of Method:\t" + m.getSignature());
					System.out.println("Exception Thrown by the method:\t" + m.getExceptions());	
					
					/*Local variable and Parameter of the method and method calls*/

					Chain<Local> localchain = m.getActiveBody().getLocals();
					Iterator<Local> its =localchain.iterator();
					while(its.hasNext()){
						Local loc =its.next();
						if(!(loc.getName().startsWith("$"))) {
							System.out.println("Local Variable Name: \t" + loc.getName());
						}
					}
					
					
					Chain<Unit> units = m.getActiveBody().getUnits();
					for (Unit unit:units){
						if (unit instanceof IdentityStmt) {
							System.out.println("Parameter Name:\t" + ((IdentityStmt) unit).getLeftOp());
						}
						if ((unit instanceof InvokeStmt)) {
			            	if(((InvokeStmt) unit).getInvokeExpr() instanceof StaticInvokeExpr) {
			            		System.out.println("Called Methods:\t" + unit);
			            	}
			            }
					}	
					
					/*Used Fields of a method*/
					if(body.getMethod().getName().toString().compareTo(m.getName().toString())==0)
					{
						Chain unt = body.getUnits();
						Iterator it1 = unt.snapshotIterator();
						while(it1.hasNext())
						{
							Stmt st = (Stmt) it1.next();
							if(st.containsFieldRef())
							{
								FieldRef rf = st.getFieldRef();
								System.out.println("Used Field :\t "+ st.getFieldRef().getField().getName());
							}
						}
					}
					
			}
					
			}
			
			
			/*Number of Loops in the method*/
			LoopNestTree loopNestTree = new LoopNestTree(body);
			
			if(!(body.getMethod().getName().equals("<init>"))) {
				System.out.println("Method " + body.getMethod().getName() + " has number of Loops:\t" + loopNestTree.size());
				if(loopNestTree.hasNestedLoops()){
					System.out.println("There exist nested loops!!");
				}
			}
			
		}
		
}
