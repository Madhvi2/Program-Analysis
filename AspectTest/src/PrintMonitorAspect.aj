import java.io.*;
import java.util.*;
import javamoprt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

class PtrStmtMopWrapper_Set implements javamoprt.MOPSet {
	public PtrStmtMopWrapper node;
	protected PtrStmtMopWrapper[] elementData;
	public int size;

	public PtrStmtMopWrapper_Set(){
		this.size = 0;
		this.elementData = new PtrStmtMopWrapper[4];
	}

	public final int size(){
		while(size > 0 && elementData[size-1].MOP_terminated) {
			elementData[--size] = null;
		}
		return size;
	}

	public final boolean add(MOPMonitor e){
		ensureCapacity();
		elementData[size++] = (PtrStmtMopWrapper)e;
		return true;
	}

	public final void endObject(int idnum){
		for(int i = 0; i < size; i++){
			MOPMonitor monitor = elementData[i];
			if(!monitor.MOP_terminated){
				monitor.endObject(idnum);
			}
		}
	}

	public final boolean alive(){
		for(int i = 0; i < size; i++){
			MOPMonitor monitor = elementData[i];
			if(!monitor.MOP_terminated){
				return true;
			}
		}
		return false;
	}

	public final void endObjectAndClean(int idnum){
		for(int i = size - 1; i > 0; i--){
			MOPMonitor monitor = elementData[i];
			if(monitor != null && !monitor.MOP_terminated){
				monitor.endObject(idnum);
			}
			elementData[i] = null;
		}
		elementData = null;
	}

	public final void ensureCapacity() {
		int oldCapacity = elementData.length;
		if (size + 1 > oldCapacity) {
			cleanup();
		}
		if (size + 1 > oldCapacity) {
			Object oldData[] = elementData;
			int newCapacity = (oldCapacity * 3) / 2 + 1;
			if (newCapacity < size + 1){
				newCapacity = size + 1;
			}
			elementData = Arrays.copyOf(elementData, newCapacity);
		}
	}

	public final void cleanup() {
		int num_terminated_monitors = 0 ;
		for(int i = 0; i + num_terminated_monitors < size; i ++){
			PtrStmtMopWrapper monitor = (PtrStmtMopWrapper)elementData[i + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i + num_terminated_monitors + 1 < size){
					do{
						monitor = (PtrStmtMopWrapper)elementData[i + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i + num_terminated_monitors + 1 < size);
					if(monitor.MOP_terminated){
						num_terminated_monitors++;
						break;
					}
				} else {
					num_terminated_monitors++;
					break;
				}
			}
			if(num_terminated_monitors != 0){
				elementData[i] = monitor;
			}
		}
		if(num_terminated_monitors != 0){
			size -= num_terminated_monitors;
			for(int i = size; i < size + num_terminated_monitors ; i++){
				elementData[i] = null;
			}
		}
	}

	public final void event_updatesource_3(Collection c) {
		int num_terminated_monitors = 0 ;
		for(int i_1 = 0; i_1 + num_terminated_monitors < this.size; i_1 ++){
			PtrStmtMopWrapper monitor = (PtrStmtMopWrapper)this.elementData[i_1 + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i_1 + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (PtrStmtMopWrapper)this.elementData[i_1 + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i_1 + num_terminated_monitors + 1 < this.size);
					if(monitor.MOP_terminated){
						num_terminated_monitors++;
						break;
					}
				} else {
					num_terminated_monitors++;
					break;
				}
			}
			if(num_terminated_monitors != 0){
				this.elementData[i_1] = monitor;
			}
			if (monitor.monitor != null){
				monitor.event_updatesource_3(c);
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i_1 = this.size; i_1 < this.size + num_terminated_monitors; i_1++){
				this.elementData[i_1] = null;
			}
		}
	}

	public final void event_updatesource_4(Collection c) {
		int num_terminated_monitors = 0 ;
		for(int i_1 = 0; i_1 + num_terminated_monitors < this.size; i_1 ++){
			PtrStmtMopWrapper monitor = (PtrStmtMopWrapper)this.elementData[i_1 + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i_1 + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (PtrStmtMopWrapper)this.elementData[i_1 + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i_1 + num_terminated_monitors + 1 < this.size);
					if(monitor.MOP_terminated){
						num_terminated_monitors++;
						break;
					}
				} else {
					num_terminated_monitors++;
					break;
				}
			}
			if(num_terminated_monitors != 0){
				this.elementData[i_1] = monitor;
			}
			if (monitor.monitor != null){
				monitor.event_updatesource_4(c);
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i_1 = this.size; i_1 < this.size + num_terminated_monitors; i_1++){
				this.elementData[i_1] = null;
			}
		}
	}

	public final void event_endProg() {
		int num_terminated_monitors = 0 ;
		for(int i_1 = 0; i_1 + num_terminated_monitors < this.size; i_1 ++){
			PtrStmtMopWrapper monitor = (PtrStmtMopWrapper)this.elementData[i_1 + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i_1 + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (PtrStmtMopWrapper)this.elementData[i_1 + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i_1 + num_terminated_monitors + 1 < this.size);
					if(monitor.MOP_terminated){
						num_terminated_monitors++;
						break;
					}
				} else {
					num_terminated_monitors++;
					break;
				}
			}
			if(num_terminated_monitors != 0){
				this.elementData[i_1] = monitor;
			}
			if (monitor.monitor != null){
				monitor.event_endProg();
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i_1 = this.size; i_1 < this.size + num_terminated_monitors; i_1++){
				this.elementData[i_1] = null;
			}
		}
	}
}

class PtrStmtMopWrapper extends javamoprt.MOPMonitor {
	public PtrStmtMopMonitor monitor = null;
	public long disable = 1;
	public long tau = 1;

	public final void event_updatesource_3(Collection c) {
		MOP_lastevent = 0;
		monitor.Prop_1_event_updatesource_3(c);
		if(monitor.Prop_1_Category_match) {
			monitor.Prop_1_handler_match(c, null);
		}
	}

	public final void event_updatesource_4(Collection c) {
		MOP_lastevent = 1;
		monitor.Prop_1_event_updatesource_4(c);
		if(monitor.Prop_1_Category_match) {
			monitor.Prop_1_handler_match(c, null);
		}
	}

	public final void event_endProg() {
		MOP_lastevent = 2;
		monitor.Prop_1_event_endProg();
		if(monitor.Prop_1_Category_match) {
			monitor.Prop_1_handler_match(null, null);
		}
	}

	public final void reset() {
		MOP_lastevent = -1;
		monitor.reset();
	}

	public javamoprt.MOPWeakReference MOPRef_c;
	public javamoprt.MOPWeakReference MOPRef_i;

	public final void endObject(int idnum){
		switch(idnum){
			case 0:
			break;
			case 1:
			break;
		}
		switch(MOP_lastevent) {
			case -1:
			return;
			case 0:
			//updatesource
			return;
			case 1:
			//updatesource
			return;
			case 2:
			//endProg
			return;
		}
		return;
	}

}

class PtrStmtMopMonitor implements Cloneable, javamoprt.MOPObject {
	public Object clone() {
		try {
			PtrStmtMopMonitor ret = (PtrStmtMopMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}
	long t1, t2, t3;
	ArrayList a = new ArrayList();

	int Prop_1_state;
	static final int Prop_1_transition_updatesource[] = {1, 1, 3, 3};;
	static final int Prop_1_transition_endProg[] = {3, 2, 3, 3};;

	boolean Prop_1_Category_match = false;

	public PtrStmtMopMonitor () {
		Prop_1_state = 0;

	}

	public final void Prop_1_event_updatesource_3(Collection c) {

		Prop_1_state = Prop_1_transition_updatesource[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 2;
		{
			t1 = System.nanoTime();
		}
	}

	public final void Prop_1_event_updatesource_4(Collection c) {

		Prop_1_state = Prop_1_transition_updatesource[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 2;
		{
			t2 = System.nanoTime();
			t3 = t2 - t1;
			a.add(t3);
		}
	}

	public final void Prop_1_event_endProg() {

		Prop_1_state = Prop_1_transition_endProg[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 2;
		{
			if (a.size() != 0) {
				System.out.println("Program has ended!!");
				System.out.println("Time taken by an add operation  : " + a);
			}
		}
	}

	public final void Prop_1_handler_match (Collection c, Iterator i){
		{
		}

	}

	public final void reset() {
		Prop_1_state = 0;
		Prop_1_Category_match = false;
	}

}

public aspect PrintMonitorAspect implements javamoprt.MOPObject {
	javamoprt.MOPMapManager PrintMapManager;
	public PrintMonitorAspect(){
		Runtime.getRuntime().addShutdownHook(new Print_DummyHookThread());
		PrintMapManager = new javamoprt.MOPMapManager();
		PrintMapManager.start();
	}

	// Declarations for Locks
	static Object PtrStmtMop_MOPLock = new Object();

	// Declarations for Timestamps
	static long PtrStmtMop_timestamp = 1;

	// Declarations for Indexing Trees
	static javamoprt.MOPSet PtrStmtMop_Set = new PtrStmtMopWrapper_Set();
	static javamoprt.MOPMap PtrStmtMop_c_Map = new javamoprt.MOPMapOfSet(0);
	static Object PtrStmtMop_c_Map_cachekey_0 = null;
	static Object PtrStmtMop_c_Map_cachevalue = null;

	pointcut PtrStmtMop_updatesource_3(Collection c) : ((call(* Collection+.remove*(..)) || call(* Collection+.add*(..))) && target(c)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	before (Collection c) : PtrStmtMop_updatesource_3(c) {
		Object obj = null;
		javamoprt.MOPMap m;
		PtrStmtMopWrapper mainWrapper;
		PtrStmtMopWrapper origWrapper;
		PtrStmtMopWrapper lastWrapper;
		PtrStmtMopWrapper wrapper;
		javamoprt.MOPMap mainMap = null;
		javamoprt.MOPMap origMap = null;
		javamoprt.MOPMap lastMap = null;
		PtrStmtMopWrapper_Set mainSet = null;
		PtrStmtMopWrapper_Set origSet = null;
		PtrStmtMopWrapper_Set monitors = null;
		PtrStmtMopWrapper_Set lastSet = null;
		javamoprt.MOPWeakReference TempRef_c = null;

		synchronized(PtrStmtMop_MOPLock) {
			if(c == PtrStmtMop_c_Map_cachekey_0){
				obj = PtrStmtMop_c_Map_cachevalue;
			}

			if (obj == null) {
				mainSet = (PtrStmtMopWrapper_Set)PtrStmtMop_c_Map.get(c);
				if (mainSet != null){
					mainWrapper = ((PtrStmtMopWrapper_Set)mainSet).node;
				} else {
					mainSet = new PtrStmtMopWrapper_Set();
					if (TempRef_c == null){
						TempRef_c = new javamoprt.MOPWeakReference(c);
					}
					PtrStmtMop_c_Map.put(TempRef_c, mainSet);
					mainWrapper = null;
				}
				PtrStmtMop_c_Map_cachekey_0 = c;
				PtrStmtMop_c_Map_cachevalue = mainSet;
			} else {
				mainSet = (PtrStmtMopWrapper_Set)obj;
				mainWrapper = ((PtrStmtMopWrapper_Set)mainSet).node;
			}

			// line 1 of Main in Algorithm D
			if (mainWrapper == null || mainWrapper.monitor == null) {
				if (mainWrapper == null || mainWrapper.monitor == null) {
					origSet = (PtrStmtMopWrapper_Set)PtrStmtMop_Set;
					if (origSet != null){
						origWrapper = ((PtrStmtMopWrapper_Set)origSet).node;
					} else {
						origWrapper = null;
					}
					if (origWrapper != null && origWrapper.monitor != null) {
						// line 1 of defineTo in Algorithm D
						boolean timeCheck = true;
						if (timeCheck){
							monitors = (PtrStmtMopWrapper_Set)PtrStmtMop_c_Map.get(c);
							if (monitors != null){
								wrapper = ((PtrStmtMopWrapper_Set)monitors).node;
								if (wrapper != null && (wrapper.disable > origWrapper.tau || wrapper.tau < origWrapper.tau)) {
									timeCheck = false;
								}
							}
						}

						if (timeCheck){
							if (mainWrapper == null){
								mainWrapper = new PtrStmtMopWrapper();
								if (TempRef_c == null){
									mainWrapper.MOPRef_c = TempRef_c = new javamoprt.MOPWeakReference(c);
								} else {
									mainWrapper.MOPRef_c = TempRef_c;
								}
								((PtrStmtMopWrapper_Set)mainSet).node = mainWrapper;
							}
							mainWrapper.tau = origWrapper.tau;
							mainWrapper.monitor = (PtrStmtMopMonitor)origWrapper.monitor.clone();
							mainWrapper.MOP_lastevent = origWrapper.MOP_lastevent;
							mainSet.add(mainWrapper);

							PtrStmtMop_Set.add(mainWrapper);
						}
					}
				}
				if (mainWrapper == null) {
					mainWrapper = new PtrStmtMopWrapper();
					if (TempRef_c == null){
						mainWrapper.MOPRef_c = TempRef_c = new javamoprt.MOPWeakReference(c);
					} else {
						mainWrapper.MOPRef_c = TempRef_c;
					}
					((PtrStmtMopWrapper_Set)mainSet).node = mainWrapper;
				}

				if (mainWrapper.monitor == null) {
					// line 4 of defineNew in Algorithm D
					mainWrapper.monitor = new PtrStmtMopMonitor();
					mainWrapper.tau = PtrStmtMop_timestamp++;
					mainSet.add(mainWrapper);

					PtrStmtMop_Set.add(mainWrapper);
				}

				// line 4-5 of Main in Algorithm D
				mainWrapper.disable = PtrStmtMop_timestamp++;
			}
			// line 7 of Main in Algorithm D
			if (mainSet != null) {
				((PtrStmtMopWrapper_Set)mainSet).event_updatesource_3(c);
			}
		}
	}

	pointcut PtrStmtMop_updatesource_4(Collection c) : ((call(* Collection+.remove*(..)) || call(* Collection+.add*(..))) && target(c)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	after (Collection c) : PtrStmtMop_updatesource_4(c) {
		Object obj = null;
		javamoprt.MOPMap m;
		PtrStmtMopWrapper mainWrapper;
		PtrStmtMopWrapper origWrapper;
		PtrStmtMopWrapper lastWrapper;
		PtrStmtMopWrapper wrapper;
		javamoprt.MOPMap mainMap = null;
		javamoprt.MOPMap origMap = null;
		javamoprt.MOPMap lastMap = null;
		PtrStmtMopWrapper_Set mainSet = null;
		PtrStmtMopWrapper_Set origSet = null;
		PtrStmtMopWrapper_Set monitors = null;
		PtrStmtMopWrapper_Set lastSet = null;
		javamoprt.MOPWeakReference TempRef_c = null;

		synchronized(PtrStmtMop_MOPLock) {
			if(c == PtrStmtMop_c_Map_cachekey_0){
				obj = PtrStmtMop_c_Map_cachevalue;
			}

			if (obj == null) {
				mainSet = (PtrStmtMopWrapper_Set)PtrStmtMop_c_Map.get(c);
				if (mainSet != null){
					mainWrapper = ((PtrStmtMopWrapper_Set)mainSet).node;
				} else {
					mainSet = new PtrStmtMopWrapper_Set();
					if (TempRef_c == null){
						TempRef_c = new javamoprt.MOPWeakReference(c);
					}
					PtrStmtMop_c_Map.put(TempRef_c, mainSet);
					mainWrapper = null;
				}
				PtrStmtMop_c_Map_cachekey_0 = c;
				PtrStmtMop_c_Map_cachevalue = mainSet;
			} else {
				mainSet = (PtrStmtMopWrapper_Set)obj;
				mainWrapper = ((PtrStmtMopWrapper_Set)mainSet).node;
			}

			// line 1 of Main in Algorithm D
			if (mainWrapper == null || mainWrapper.monitor == null) {
				if (mainWrapper == null || mainWrapper.monitor == null) {
					origSet = (PtrStmtMopWrapper_Set)PtrStmtMop_Set;
					if (origSet != null){
						origWrapper = ((PtrStmtMopWrapper_Set)origSet).node;
					} else {
						origWrapper = null;
					}
					if (origWrapper != null && origWrapper.monitor != null) {
						// line 1 of defineTo in Algorithm D
						boolean timeCheck = true;
						if (timeCheck){
							monitors = (PtrStmtMopWrapper_Set)PtrStmtMop_c_Map.get(c);
							if (monitors != null){
								wrapper = ((PtrStmtMopWrapper_Set)monitors).node;
								if (wrapper != null && (wrapper.disable > origWrapper.tau || wrapper.tau < origWrapper.tau)) {
									timeCheck = false;
								}
							}
						}

						if (timeCheck){
							if (mainWrapper == null){
								mainWrapper = new PtrStmtMopWrapper();
								if (TempRef_c == null){
									mainWrapper.MOPRef_c = TempRef_c = new javamoprt.MOPWeakReference(c);
								} else {
									mainWrapper.MOPRef_c = TempRef_c;
								}
								((PtrStmtMopWrapper_Set)mainSet).node = mainWrapper;
							}
							mainWrapper.tau = origWrapper.tau;
							mainWrapper.monitor = (PtrStmtMopMonitor)origWrapper.monitor.clone();
							mainWrapper.MOP_lastevent = origWrapper.MOP_lastevent;
							mainSet.add(mainWrapper);

							PtrStmtMop_Set.add(mainWrapper);
						}
					}
				}
				if (mainWrapper == null) {
					mainWrapper = new PtrStmtMopWrapper();
					if (TempRef_c == null){
						mainWrapper.MOPRef_c = TempRef_c = new javamoprt.MOPWeakReference(c);
					} else {
						mainWrapper.MOPRef_c = TempRef_c;
					}
					((PtrStmtMopWrapper_Set)mainSet).node = mainWrapper;
				}

				if (mainWrapper.monitor == null) {
					// line 4 of defineNew in Algorithm D
					mainWrapper.monitor = new PtrStmtMopMonitor();
					mainWrapper.tau = PtrStmtMop_timestamp++;
					mainSet.add(mainWrapper);

					PtrStmtMop_Set.add(mainWrapper);
				}

				// line 4-5 of Main in Algorithm D
				mainWrapper.disable = PtrStmtMop_timestamp++;
			}
			// line 7 of Main in Algorithm D
			if (mainSet != null) {
				((PtrStmtMopWrapper_Set)mainSet).event_updatesource_4(c);
			}
		}
	}

	class Print_DummyHookThread extends Thread {
		public void run(){
			javamoprt.MOPMap m;
			PtrStmtMopWrapper mainWrapper;
			PtrStmtMopWrapper origWrapper;
			PtrStmtMopWrapper lastWrapper;
			PtrStmtMopWrapper wrapper;
			javamoprt.MOPMap mainMap = null;
			javamoprt.MOPMap origMap = null;
			javamoprt.MOPMap lastMap = null;
			PtrStmtMopWrapper_Set mainSet = null;
			PtrStmtMopWrapper_Set origSet = null;
			PtrStmtMopWrapper_Set monitors = null;
			PtrStmtMopWrapper_Set lastSet = null;

			synchronized(PtrStmtMop_MOPLock) {
				mainSet = (PtrStmtMopWrapper_Set)PtrStmtMop_Set;
				if (mainSet != null){
					mainWrapper = ((PtrStmtMopWrapper_Set)mainSet).node;
				} else {
					mainWrapper = null;
				}

				// line 1 of Main in Algorithm D
				if (mainWrapper == null || mainWrapper.monitor == null) {
					if (mainWrapper == null) {
						mainWrapper = new PtrStmtMopWrapper();
						((PtrStmtMopWrapper_Set)PtrStmtMop_Set).node = mainWrapper;
					}

					if (mainWrapper.monitor == null) {
						// line 4 of defineNew in Algorithm D
						mainWrapper.monitor = new PtrStmtMopMonitor();
						mainWrapper.tau = PtrStmtMop_timestamp++;
						PtrStmtMop_Set.add(mainWrapper);

					}

					// line 4-5 of Main in Algorithm D
					mainWrapper.disable = PtrStmtMop_timestamp++;
				}
				// line 7 of Main in Algorithm D
				if (mainSet != null) {
					((PtrStmtMopWrapper_Set)mainSet).event_endProg();
				}
			}
		}
	}
}
