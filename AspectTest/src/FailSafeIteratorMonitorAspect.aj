import java.io.*;
import java.util.*;
import javamoprt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

class FailSafeItrWrapper_Set implements javamoprt.MOPSet {
	public FailSafeItrWrapper node;
	protected FailSafeItrWrapper[] elementData;
	public int size;

	public FailSafeItrWrapper_Set(){
		this.size = 0;
		this.elementData = new FailSafeItrWrapper[4];
	}

	public final int size(){
		while(size > 0 && elementData[size-1].MOP_terminated) {
			elementData[--size] = null;
		}
		return size;
	}

	public final boolean add(MOPMonitor e){
		ensureCapacity();
		elementData[size++] = (FailSafeItrWrapper)e;
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
			FailSafeItrWrapper monitor = (FailSafeItrWrapper)elementData[i + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i + num_terminated_monitors + 1 < size){
					do{
						monitor = (FailSafeItrWrapper)elementData[i + (++num_terminated_monitors)];
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

	public final void event_create(Collection c, Iterator i) {
		int num_terminated_monitors = 0 ;
		for(int i_1 = 0; i_1 + num_terminated_monitors < this.size; i_1 ++){
			FailSafeItrWrapper monitor = (FailSafeItrWrapper)this.elementData[i_1 + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i_1 + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (FailSafeItrWrapper)this.elementData[i_1 + (++num_terminated_monitors)];
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
				monitor.event_create(c, i);
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i_1 = this.size; i_1 < this.size + num_terminated_monitors; i_1++){
				this.elementData[i_1] = null;
			}
		}
	}

	public final void event_updatesource(Collection c) {
		int num_terminated_monitors = 0 ;
		for(int i_1 = 0; i_1 + num_terminated_monitors < this.size; i_1 ++){
			FailSafeItrWrapper monitor = (FailSafeItrWrapper)this.elementData[i_1 + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i_1 + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (FailSafeItrWrapper)this.elementData[i_1 + (++num_terminated_monitors)];
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
				monitor.event_updatesource(c);
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i_1 = this.size; i_1 < this.size + num_terminated_monitors; i_1++){
				this.elementData[i_1] = null;
			}
		}
	}

	public final void event_next(Iterator i) {
		int num_terminated_monitors = 0 ;
		for(int i_1 = 0; i_1 + num_terminated_monitors < this.size; i_1 ++){
			FailSafeItrWrapper monitor = (FailSafeItrWrapper)this.elementData[i_1 + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i_1 + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (FailSafeItrWrapper)this.elementData[i_1 + (++num_terminated_monitors)];
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
				monitor.event_next(i);
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

class FailSafeItrWrapper extends javamoprt.MOPMonitor {
	public FailSafeItrMonitor monitor = null;
	public long disable = 1;
	public long tau = 1;

	public final void event_create(Collection c, Iterator i) {
		MOP_lastevent = 0;
		monitor.Prop_1_event_create(c, i);
		if(monitor.Prop_1_Category_match) {
			monitor.Prop_1_handler_match(c, i);
		}
	}

	public final void event_updatesource(Collection c) {
		MOP_lastevent = 1;
		monitor.Prop_1_event_updatesource(c);
		if(monitor.Prop_1_Category_match) {
			monitor.Prop_1_handler_match(c, null);
		}
	}

	public final void event_next(Iterator i) {
		MOP_lastevent = 2;
		monitor.Prop_1_event_next(i);
		if(monitor.Prop_1_Category_match) {
			monitor.Prop_1_handler_match(null, i);
		}
	}

	public final void reset() {
		MOP_lastevent = -1;
		monitor.reset();
	}

	public javamoprt.MOPWeakReference MOPRef_c;
	public javamoprt.MOPWeakReference MOPRef_i;

	//alive_parameters_0 = [Collection c, Iterator i]
	public boolean alive_parameters_0 = true;
	//alive_parameters_1 = [Iterator i]
	public boolean alive_parameters_1 = true;

	public final void endObject(int idnum){
		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
			case 1:
			alive_parameters_0 = false;
			alive_parameters_1 = false;
			break;
		}
		switch(MOP_lastevent) {
			case -1:
			return;
			case 0:
			//create
			//alive_c && alive_i
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

			case 1:
			//updatesource
			//alive_i
			if(!(alive_parameters_1)){
				MOP_terminated = true;
				return;
			}
			break;

			case 2:
			//next
			//alive_c && alive_i
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

		}
		return;
	}

}

class FailSafeItrMonitor implements Cloneable, javamoprt.MOPObject {
	public Object clone() {
		try {
			FailSafeItrMonitor ret = (FailSafeItrMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	int Prop_1_state;
	static final int Prop_1_transition_create[] = {1, 4, 4, 4, 4};;
	static final int Prop_1_transition_updatesource[] = {4, 2, 2, 4, 4};;
	static final int Prop_1_transition_next[] = {4, 1, 3, 4, 4};;

	boolean Prop_1_Category_match = false;

	public FailSafeItrMonitor () {
		Prop_1_state = 0;

	}

	public final void Prop_1_event_create(Collection c, Iterator i) {

		Prop_1_state = Prop_1_transition_create[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 3;
	}

	public final void Prop_1_event_updatesource(Collection c) {

		Prop_1_state = Prop_1_transition_updatesource[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 3;
	}

	public final void Prop_1_event_next(Iterator i) {

		Prop_1_state = Prop_1_transition_next[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 3;
	}

	public final void Prop_1_handler_match (Collection c, Iterator i){
		{
			System.out.println("Iterator is not used properly.");
			System.exit(0);
		}

	}

	public final void reset() {
		Prop_1_state = 0;
		Prop_1_Category_match = false;
	}

}

public aspect FailSafeIteratorMonitorAspect implements javamoprt.MOPObject {
	javamoprt.MOPMapManager FailSafeIteratorMapManager;
	public FailSafeIteratorMonitorAspect(){
		FailSafeIteratorMapManager = new javamoprt.MOPMapManager();
		FailSafeIteratorMapManager.start();
	}

	// Declarations for Locks
	static Object FailSafeItr_MOPLock = new Object();

	// Declarations for Timestamps
	static long FailSafeItr_timestamp = 1;

	// Declarations for Indexing Trees
	static javamoprt.MOPMap FailSafeItr_c_i_Map = new javamoprt.MOPMapOfMap(0);
	static Object FailSafeItr_c_i_Map_cachekey_0 = null;
	static Object FailSafeItr_c_i_Map_cachekey_1 = null;
	static Object FailSafeItr_c_i_Map_cachevalue = null;
	static javamoprt.MOPMap FailSafeItr_i_Map = new javamoprt.MOPMapOfSet(1);
	static Object FailSafeItr_i_Map_cachekey_1 = null;
	static Object FailSafeItr_i_Map_cachevalue = null;
	static javamoprt.MOPMap FailSafeItr_c_Map = new javamoprt.MOPMapOfSet(0);
	static Object FailSafeItr_c_Map_cachekey_0 = null;
	static Object FailSafeItr_c_Map_cachevalue = null;

	pointcut FailSafeItr_create(Collection c) : (call(Iterator Collection+.iterator()) && target(c)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	after (Collection c) returning (Iterator i) : FailSafeItr_create(c) {
		Object obj = null;
		javamoprt.MOPMap m;
		FailSafeItrWrapper mainWrapper;
		FailSafeItrWrapper origWrapper;
		FailSafeItrWrapper lastWrapper;
		FailSafeItrWrapper wrapper;
		javamoprt.MOPMap mainMap = null;
		javamoprt.MOPMap origMap = null;
		javamoprt.MOPMap lastMap = null;
		FailSafeItrWrapper_Set mainSet = null;
		FailSafeItrWrapper_Set origSet = null;
		FailSafeItrWrapper_Set monitors = null;
		FailSafeItrWrapper_Set lastSet = null;
		javamoprt.MOPWeakReference TempRef_c = null;
		javamoprt.MOPWeakReference TempRef_i = null;

		synchronized(FailSafeItr_MOPLock) {
			if(c == FailSafeItr_c_i_Map_cachekey_0 && i == FailSafeItr_c_i_Map_cachekey_1){
				obj = FailSafeItr_c_i_Map_cachevalue;
			}

			if (obj == null) {
				obj = FailSafeItr_c_i_Map.get(c);
				if (obj == null) {
					obj = new javamoprt.MOPMapOfMonitor(1);
					if (TempRef_c == null){
						TempRef_c = new javamoprt.MOPWeakReference(c);
					}
					FailSafeItr_c_i_Map.put(TempRef_c, obj);
				} else {
					if (TempRef_c == null){
						TempRef_c = FailSafeItr_c_i_Map.cachedKey;
					}
				}
				mainMap = (javamoprt.MOPMap)obj;
				mainWrapper = (FailSafeItrWrapper)mainMap.get(i);
				FailSafeItr_c_i_Map_cachekey_0 = c;
				FailSafeItr_c_i_Map_cachekey_1 = i;
				FailSafeItr_c_i_Map_cachevalue = mainWrapper;
			} else {
				mainWrapper = (FailSafeItrWrapper)obj;
			}

			// line 1 of Main in Algorithm D
			if (mainWrapper == null || mainWrapper.monitor == null) {
				if (mainWrapper == null) {
					mainWrapper = new FailSafeItrWrapper();
					if (TempRef_c == null){
						mainWrapper.MOPRef_c = TempRef_c = new javamoprt.MOPWeakReference(c);
					} else {
						mainWrapper.MOPRef_c = TempRef_c;
					}
					if (TempRef_i == null){
						mainWrapper.MOPRef_i = TempRef_i = new javamoprt.MOPWeakReference(i);
					} else {
						mainWrapper.MOPRef_i = TempRef_i;
					}
					mainMap.put(mainWrapper.MOPRef_i, mainWrapper);
				}

				if (mainWrapper.monitor == null) {
					// line 4 of defineNew in Algorithm D
					mainWrapper.monitor = new FailSafeItrMonitor();
					mainWrapper.tau = FailSafeItr_timestamp++;

					m = FailSafeItr_i_Map;
					obj = m.get(i);
					monitors = (FailSafeItrWrapper_Set)obj;
					if (monitors == null) {
						monitors = new FailSafeItrWrapper_Set();
						m.put(mainWrapper.MOPRef_i, monitors);
					}
					monitors.add(mainWrapper);

					m = FailSafeItr_c_Map;
					obj = m.get(c);
					monitors = (FailSafeItrWrapper_Set)obj;
					if (monitors == null) {
						monitors = new FailSafeItrWrapper_Set();
						m.put(mainWrapper.MOPRef_c, monitors);
					}
					monitors.add(mainWrapper);
				}

				// line 4-5 of Main in Algorithm D
				mainWrapper.disable = FailSafeItr_timestamp++;
			}
			// line 7 of Main in Algorithm D
			if (mainWrapper != null && mainWrapper.monitor != null) {
				if (mainWrapper.monitor != null){
					mainWrapper.event_create(c, i);
				}
			}
		}
	}

	pointcut FailSafeItr_updatesource(Collection c) : ((call(* Collection+.remove*(..)) || call(* Collection+.add*(..))) && target(c)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	after (Collection c) : FailSafeItr_updatesource(c) {
		Object obj = null;
		javamoprt.MOPMap m;
		FailSafeItrWrapper mainWrapper;
		FailSafeItrWrapper origWrapper;
		FailSafeItrWrapper lastWrapper;
		FailSafeItrWrapper wrapper;
		javamoprt.MOPMap mainMap = null;
		javamoprt.MOPMap origMap = null;
		javamoprt.MOPMap lastMap = null;
		FailSafeItrWrapper_Set mainSet = null;
		FailSafeItrWrapper_Set origSet = null;
		FailSafeItrWrapper_Set monitors = null;
		FailSafeItrWrapper_Set lastSet = null;
		javamoprt.MOPWeakReference TempRef_c = null;

		synchronized(FailSafeItr_MOPLock) {
			if(c == FailSafeItr_c_Map_cachekey_0){
				obj = FailSafeItr_c_Map_cachevalue;
			}

			if (obj == null) {
				mainSet = (FailSafeItrWrapper_Set)FailSafeItr_c_Map.get(c);
				if (mainSet != null){
					mainWrapper = ((FailSafeItrWrapper_Set)mainSet).node;
				} else {
					mainSet = new FailSafeItrWrapper_Set();
					if (TempRef_c == null){
						TempRef_c = new javamoprt.MOPWeakReference(c);
					}
					FailSafeItr_c_Map.put(TempRef_c, mainSet);
					mainWrapper = null;
				}
				FailSafeItr_c_Map_cachekey_0 = c;
				FailSafeItr_c_Map_cachevalue = mainSet;
			} else {
				mainSet = (FailSafeItrWrapper_Set)obj;
				mainWrapper = ((FailSafeItrWrapper_Set)mainSet).node;
			}

			// line 1 of Main in Algorithm D
			if (mainWrapper == null || mainWrapper.monitor == null) {
				if (mainWrapper == null) {
					mainWrapper = new FailSafeItrWrapper();
					if (TempRef_c == null){
						mainWrapper.MOPRef_c = TempRef_c = new javamoprt.MOPWeakReference(c);
					} else {
						mainWrapper.MOPRef_c = TempRef_c;
					}
					((FailSafeItrWrapper_Set)mainSet).node = mainWrapper;
				}

				if (mainWrapper.monitor == null) {
					// line 4 of defineNew in Algorithm D
					mainWrapper.monitor = new FailSafeItrMonitor();
					mainWrapper.tau = FailSafeItr_timestamp++;
					mainSet.add(mainWrapper);

				}

				// line 4-5 of Main in Algorithm D
				mainWrapper.disable = FailSafeItr_timestamp++;
			}
			// line 7 of Main in Algorithm D
			if (mainSet != null) {
				((FailSafeItrWrapper_Set)mainSet).event_updatesource(c);
			}
		}
	}

	pointcut FailSafeItr_next(Iterator i) : (call(* Iterator.next()) && target(i)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	before (Iterator i) : FailSafeItr_next(i) {
		Object obj = null;
		javamoprt.MOPMap m;
		FailSafeItrWrapper mainWrapper;
		FailSafeItrWrapper origWrapper;
		FailSafeItrWrapper lastWrapper;
		FailSafeItrWrapper wrapper;
		javamoprt.MOPMap mainMap = null;
		javamoprt.MOPMap origMap = null;
		javamoprt.MOPMap lastMap = null;
		FailSafeItrWrapper_Set mainSet = null;
		FailSafeItrWrapper_Set origSet = null;
		FailSafeItrWrapper_Set monitors = null;
		FailSafeItrWrapper_Set lastSet = null;
		javamoprt.MOPWeakReference TempRef_i = null;

		synchronized(FailSafeItr_MOPLock) {
			if(i == FailSafeItr_i_Map_cachekey_1){
				obj = FailSafeItr_i_Map_cachevalue;
			}

			if (obj == null) {
				mainSet = (FailSafeItrWrapper_Set)FailSafeItr_i_Map.get(i);
				if (mainSet != null){
					mainWrapper = ((FailSafeItrWrapper_Set)mainSet).node;
				} else {
					mainSet = new FailSafeItrWrapper_Set();
					if (TempRef_i == null){
						TempRef_i = new javamoprt.MOPWeakReference(i);
					}
					FailSafeItr_i_Map.put(TempRef_i, mainSet);
					mainWrapper = null;
				}
				FailSafeItr_i_Map_cachekey_1 = i;
				FailSafeItr_i_Map_cachevalue = mainSet;
			} else {
				mainSet = (FailSafeItrWrapper_Set)obj;
				mainWrapper = ((FailSafeItrWrapper_Set)mainSet).node;
			}

			// line 1 of Main in Algorithm D
			if (mainWrapper == null || mainWrapper.monitor == null) {
				if (mainWrapper == null) {
					mainWrapper = new FailSafeItrWrapper();
					if (TempRef_i == null){
						mainWrapper.MOPRef_i = TempRef_i = new javamoprt.MOPWeakReference(i);
					} else {
						mainWrapper.MOPRef_i = TempRef_i;
					}
					((FailSafeItrWrapper_Set)mainSet).node = mainWrapper;
				}

				if (mainWrapper.monitor == null) {
					// line 4 of defineNew in Algorithm D
					mainWrapper.monitor = new FailSafeItrMonitor();
					mainWrapper.tau = FailSafeItr_timestamp++;
					mainSet.add(mainWrapper);

				}

				// line 4-5 of Main in Algorithm D
				mainWrapper.disable = FailSafeItr_timestamp++;
			}
			// line 7 of Main in Algorithm D
			if (mainSet != null) {
				((FailSafeItrWrapper_Set)mainSet).event_next(i);
			}
		}
	}

}
