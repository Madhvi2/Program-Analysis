import java.io.*;
import java.util.*;
import javamoprt.*;
import java.lang.ref.*;
import org.aspectj.lang.*;

class SafeHashSetMonitor_Set implements javamoprt.MOPSet {
	protected SafeHashSetMonitor[] elementData;
	public int size;

	public SafeHashSetMonitor_Set(){
		this.size = 0;
		this.elementData = new SafeHashSetMonitor[4];
	}

	public final int size(){
		while(size > 0 && elementData[size-1].MOP_terminated) {
			elementData[--size] = null;
		}
		return size;
	}

	public final boolean add(MOPMonitor e){
		ensureCapacity();
		elementData[size++] = (SafeHashSetMonitor)e;
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
			SafeHashSetMonitor monitor = (SafeHashSetMonitor)elementData[i + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i + num_terminated_monitors + 1 < size){
					do{
						monitor = (SafeHashSetMonitor)elementData[i + (++num_terminated_monitors)];
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

	public final void event_add(HashSet t, Object o) {
		int num_terminated_monitors = 0 ;
		for(int i = 0; i + num_terminated_monitors < this.size; i ++){
			SafeHashSetMonitor monitor = (SafeHashSetMonitor)this.elementData[i + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (SafeHashSetMonitor)this.elementData[i + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i + num_terminated_monitors + 1 < this.size);
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
				this.elementData[i] = monitor;
			}
			monitor.Prop_1_event_add(t, o);
			if(monitor.Prop_1_Category_match) {
				monitor.Prop_1_handler_match(t, o);
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i = this.size; i < this.size + num_terminated_monitors; i++){
				this.elementData[i] = null;
			}
		}
	}

	public final void event_unsafe_contains(HashSet t, Object o) {
		int num_terminated_monitors = 0 ;
		for(int i = 0; i + num_terminated_monitors < this.size; i ++){
			SafeHashSetMonitor monitor = (SafeHashSetMonitor)this.elementData[i + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (SafeHashSetMonitor)this.elementData[i + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i + num_terminated_monitors + 1 < this.size);
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
				this.elementData[i] = monitor;
			}
			monitor.Prop_1_event_unsafe_contains(t, o);
			if(monitor.MOP_conditionFail){
				monitor.MOP_conditionFail = false;
			} else {
				if(monitor.Prop_1_Category_match) {
					monitor.Prop_1_handler_match(t, o);
				}
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i = this.size; i < this.size + num_terminated_monitors; i++){
				this.elementData[i] = null;
			}
		}
	}

	public final void event_remove(HashSet t, Object o) {
		int num_terminated_monitors = 0 ;
		for(int i = 0; i + num_terminated_monitors < this.size; i ++){
			SafeHashSetMonitor monitor = (SafeHashSetMonitor)this.elementData[i + num_terminated_monitors];
			if(monitor.MOP_terminated){
				if(i + num_terminated_monitors + 1 < this.size){
					do{
						monitor = (SafeHashSetMonitor)this.elementData[i + (++num_terminated_monitors)];
					} while(monitor.MOP_terminated && i + num_terminated_monitors + 1 < this.size);
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
				this.elementData[i] = monitor;
			}
			monitor.Prop_1_event_remove(t, o);
			if(monitor.Prop_1_Category_match) {
				monitor.Prop_1_handler_match(t, o);
			}
		}
		if(num_terminated_monitors != 0){
			this.size -= num_terminated_monitors;
			for(int i = this.size; i < this.size + num_terminated_monitors; i++){
				this.elementData[i] = null;
			}
		}
	}
}

class SafeHashSetMonitor extends javamoprt.MOPMonitor implements Cloneable, javamoprt.MOPObject {
	public Object clone() {
		try {
			SafeHashSetMonitor ret = (SafeHashSetMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}
	int hashcode;

	boolean MOP_conditionFail = false;
	int Prop_1_state;
	static final int Prop_1_transition_add[] = {1, 3, 3, 3};;
	static final int Prop_1_transition_unsafe_contains[] = {3, 2, 2, 3};;
	static final int Prop_1_transition_remove[] = {3, 3, 3, 3};;

	boolean Prop_1_Category_match = false;

	public SafeHashSetMonitor () {
		Prop_1_state = 0;

	}

	public final void Prop_1_event_add(HashSet t, Object o) {
		MOP_lastevent = 0;

		Prop_1_state = Prop_1_transition_add[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 2;
		{
			hashcode = o.hashCode();
		}
	}

	public final void Prop_1_event_unsafe_contains(HashSet t, Object o) {
		if (!(hashcode != o.hashCode()
		)) {
			MOP_conditionFail = true;
			return;
		}
		MOP_lastevent = 1;

		Prop_1_state = Prop_1_transition_unsafe_contains[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 2;
	}

	public final void Prop_1_event_remove(HashSet t, Object o) {
		MOP_lastevent = 2;

		Prop_1_state = Prop_1_transition_remove[Prop_1_state];
		Prop_1_Category_match = Prop_1_state == 2;
	}

	public final void Prop_1_handler_match (HashSet t, Object o){
		{
			System.err.println("HashCode changed for Object " + o + " while being in a   Hashtable!");
			System.exit(1);
		}

	}

	public final void reset() {
		MOP_lastevent = -1;
		Prop_1_state = 0;
		Prop_1_Category_match = false;
	}

	public javamoprt.MOPWeakReference MOPRef_t;
	public javamoprt.MOPWeakReference MOPRef_o;

	//alive_parameters_0 = [HashSet t, Object o]
	public boolean alive_parameters_0 = true;

	public final void endObject(int idnum){
		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
			case 1:
			alive_parameters_0 = false;
			break;
		}
		switch(MOP_lastevent) {
			case -1:
			return;
			case 0:
			//add
			//alive_t && alive_o
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

			case 1:
			//unsafe_contains
			//alive_t && alive_o
			if(!(alive_parameters_0)){
				MOP_terminated = true;
				return;
			}
			break;

			case 2:
			//remove
			return;
		}
		return;
	}

}

public aspect SafeHashSetMonitorAspect implements javamoprt.MOPObject {
	javamoprt.MOPMapManager SafeHashSetMapManager;
	public SafeHashSetMonitorAspect(){
		SafeHashSetMapManager = new javamoprt.MOPMapManager();
		SafeHashSetMapManager.start();
	}

	// Declarations for Locks
	static Object SafeHashSet_MOPLock = new Object();

	// Declarations for Indexing Trees
	static javamoprt.MOPMap SafeHashSet_t_o_Map = new javamoprt.MOPMapOfMap(0);
	static Object SafeHashSet_t_o_Map_cachekey_0 = null;
	static Object SafeHashSet_t_o_Map_cachekey_1 = null;
	static Object SafeHashSet_t_o_Map_cachevalue = null;
	static javamoprt.MOPMap SafeHashSet_o_Map = new javamoprt.MOPMapOfSet(1);
	static Object SafeHashSet_o_Map_cachekey_1 = null;
	static Object SafeHashSet_o_Map_cachevalue = null;
	static javamoprt.MOPMap SafeHashSet_t_Map = new javamoprt.MOPMapOfSet(0);
	static Object SafeHashSet_t_Map_cachekey_0 = null;
	static Object SafeHashSet_t_Map_cachevalue = null;

	pointcut SafeHashSet_add(HashSet t, Object o) : (call(* Collection+.add(Object)) && target(t) && args(o)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	after (HashSet t, Object o) : SafeHashSet_add(t, o) {
		Object obj = null;
		javamoprt.MOPMap m;
		SafeHashSetMonitor monitor = null;
		SafeHashSetMonitor_Set monitors = null;
		javamoprt.MOPWeakReference TempRef_t;
		javamoprt.MOPWeakReference TempRef_o;

		synchronized(SafeHashSet_MOPLock) {
			if(t == SafeHashSet_t_o_Map_cachekey_0 && o == SafeHashSet_t_o_Map_cachekey_1){
				obj = SafeHashSet_t_o_Map_cachevalue;
			}

			if(obj == null) {
				obj = SafeHashSet_t_o_Map.get(t);
				if (obj == null) {
					obj = new javamoprt.MOPMapOfMonitor(1);
					TempRef_t = new javamoprt.MOPWeakReference(t);
					SafeHashSet_t_o_Map.put(TempRef_t, obj);
				} else {
					TempRef_t = SafeHashSet_t_o_Map.cachedKey;
				}
				m = (javamoprt.MOPMap)obj;
				obj = m.get(o);

				monitor = (SafeHashSetMonitor) obj;
				if (monitor == null){
					monitor = new SafeHashSetMonitor();
					monitor.MOPRef_t = TempRef_t;
					monitor.MOPRef_o = new javamoprt.MOPWeakReference(o);
					m.put(monitor.MOPRef_o, monitor);

					m = SafeHashSet_o_Map;
					obj = m.get(o);
					monitors = (SafeHashSetMonitor_Set)obj;
					if (monitors == null) {
						monitors = new SafeHashSetMonitor_Set();
						m.put(monitor.MOPRef_o, monitors);
					}
					monitors.add(monitor);

					m = SafeHashSet_t_Map;
					obj = m.get(t);
					monitors = (SafeHashSetMonitor_Set)obj;
					if (monitors == null) {
						monitors = new SafeHashSetMonitor_Set();
						m.put(monitor.MOPRef_t, monitors);
					}
					monitors.add(monitor);
				}
				SafeHashSet_t_o_Map_cachekey_0 = t;
				SafeHashSet_t_o_Map_cachekey_1 = o;
				SafeHashSet_t_o_Map_cachevalue = monitor;
			} else {
				monitor = (SafeHashSetMonitor) obj;
			}
			monitor.Prop_1_event_add(t, o);
			if(monitor.Prop_1_Category_match) {
				monitor.Prop_1_handler_match(t, o);
			}
		}
	}

	pointcut SafeHashSet_unsafe_contains(HashSet t, Object o) : (call(* Collection+.contains(Object)) && target(t) && args(o)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	before (HashSet t, Object o) : SafeHashSet_unsafe_contains(t, o) {
		Object obj = null;
		javamoprt.MOPMap m;
		SafeHashSetMonitor monitor = null;
		SafeHashSetMonitor_Set monitors = null;
		javamoprt.MOPWeakReference TempRef_t;
		javamoprt.MOPWeakReference TempRef_o;

		synchronized(SafeHashSet_MOPLock) {
			if(t == SafeHashSet_t_o_Map_cachekey_0 && o == SafeHashSet_t_o_Map_cachekey_1){
				obj = SafeHashSet_t_o_Map_cachevalue;
			}

			if(obj == null) {
				obj = SafeHashSet_t_o_Map.get(t);
				if (obj == null) {
					obj = new javamoprt.MOPMapOfMonitor(1);
					TempRef_t = new javamoprt.MOPWeakReference(t);
					SafeHashSet_t_o_Map.put(TempRef_t, obj);
				} else {
					TempRef_t = SafeHashSet_t_o_Map.cachedKey;
				}
				m = (javamoprt.MOPMap)obj;
				obj = m.get(o);

				monitor = (SafeHashSetMonitor) obj;
				if (monitor == null){
					monitor = new SafeHashSetMonitor();
					monitor.MOPRef_t = TempRef_t;
					monitor.MOPRef_o = new javamoprt.MOPWeakReference(o);
					m.put(monitor.MOPRef_o, monitor);

					m = SafeHashSet_o_Map;
					obj = m.get(o);
					monitors = (SafeHashSetMonitor_Set)obj;
					if (monitors == null) {
						monitors = new SafeHashSetMonitor_Set();
						m.put(monitor.MOPRef_o, monitors);
					}
					monitors.add(monitor);

					m = SafeHashSet_t_Map;
					obj = m.get(t);
					monitors = (SafeHashSetMonitor_Set)obj;
					if (monitors == null) {
						monitors = new SafeHashSetMonitor_Set();
						m.put(monitor.MOPRef_t, monitors);
					}
					monitors.add(monitor);
				}
				SafeHashSet_t_o_Map_cachekey_0 = t;
				SafeHashSet_t_o_Map_cachekey_1 = o;
				SafeHashSet_t_o_Map_cachevalue = monitor;
			} else {
				monitor = (SafeHashSetMonitor) obj;
			}
			monitor.Prop_1_event_unsafe_contains(t, o);
			if(monitor.MOP_conditionFail){
				monitor.MOP_conditionFail = false;
			} else {
				if(monitor.Prop_1_Category_match) {
					monitor.Prop_1_handler_match(t, o);
				}
			}
		}
	}

	pointcut SafeHashSet_remove(HashSet t, Object o) : (call(* Collection+.remove(Object)) && target(t) && args(o)) && !within(javamoprt.MOPObject+) && !adviceexecution();
	after (HashSet t, Object o) : SafeHashSet_remove(t, o) {
		Object obj = null;
		javamoprt.MOPMap m;
		SafeHashSetMonitor monitor = null;
		SafeHashSetMonitor_Set monitors = null;
		javamoprt.MOPWeakReference TempRef_t;
		javamoprt.MOPWeakReference TempRef_o;

		synchronized(SafeHashSet_MOPLock) {
			if(t == SafeHashSet_t_o_Map_cachekey_0 && o == SafeHashSet_t_o_Map_cachekey_1){
				obj = SafeHashSet_t_o_Map_cachevalue;
			}

			if(obj == null) {
				obj = SafeHashSet_t_o_Map.get(t);
				if (obj == null) {
					obj = new javamoprt.MOPMapOfMonitor(1);
					TempRef_t = new javamoprt.MOPWeakReference(t);
					SafeHashSet_t_o_Map.put(TempRef_t, obj);
				} else {
					TempRef_t = SafeHashSet_t_o_Map.cachedKey;
				}
				m = (javamoprt.MOPMap)obj;
				obj = m.get(o);

				monitor = (SafeHashSetMonitor) obj;
				if (monitor == null){
					monitor = new SafeHashSetMonitor();
					monitor.MOPRef_t = TempRef_t;
					monitor.MOPRef_o = new javamoprt.MOPWeakReference(o);
					m.put(monitor.MOPRef_o, monitor);

					m = SafeHashSet_o_Map;
					obj = m.get(o);
					monitors = (SafeHashSetMonitor_Set)obj;
					if (monitors == null) {
						monitors = new SafeHashSetMonitor_Set();
						m.put(monitor.MOPRef_o, monitors);
					}
					monitors.add(monitor);

					m = SafeHashSet_t_Map;
					obj = m.get(t);
					monitors = (SafeHashSetMonitor_Set)obj;
					if (monitors == null) {
						monitors = new SafeHashSetMonitor_Set();
						m.put(monitor.MOPRef_t, monitors);
					}
					monitors.add(monitor);
				}
				SafeHashSet_t_o_Map_cachekey_0 = t;
				SafeHashSet_t_o_Map_cachekey_1 = o;
				SafeHashSet_t_o_Map_cachevalue = monitor;
			} else {
				monitor = (SafeHashSetMonitor) obj;
			}
			monitor.Prop_1_event_remove(t, o);
			if(monitor.Prop_1_Category_match) {
				monitor.Prop_1_handler_match(t, o);
			}
		}
	}

}
