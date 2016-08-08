import soot.*;
public class Driverclass {
	public static void main(String[] args){
		soot.options.Options.v().setPhaseOption("jb", "use-original-names:true");
		Pack jtp = PackManager.v().getPack("jtp");
		jtp.add(new Transform("jtp.instrumenter",new SimpleAnalysis()));
		soot.Main.main(args);
		
	}
}
