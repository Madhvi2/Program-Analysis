import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import soot.*;
import soot.jimple.Stmt;
import soot.options.Options;
import soot.tagkit.LineNumberTag;
import soot.toolkits.graph.ExceptionalUnitGraph;
import soot.toolkits.graph.UnitGraph;
import soot.toolkits.scalar.FlowSet;

public class Driverclass {
	public static void main(String[] args){
		soot.options.Options.v().setPhaseOption("jb", "use-original-names:true");
		Pack jtp = PackManager.v().getPack("jtp");
		SootClass c = Scene.v().loadClassAndSupport("SampleTaint");
		c.setApplicationClass();
		SootMethod m = c.getMethodByName("printOutPut");
		Body body = m.retrieveActiveBody();
		UnitGraph graph = new ExceptionalUnitGraph(body);
		TaintAnalysis taintanalysis = new TaintAnalysis(graph);
	}
}