/* Implments memory updates (things the agent needs to remember) */

+!update_memory 
	<-	!update_dispensers;
		!update_roleZones;
		!update_goalZones.
	
+!update_dispensers: position(XMy,YMy) &
	thing(XThing,YThing,dispenser,Parameters)[entity(Myname),source(percept)] &
	not(thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)]) 
	<- 	+thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)];
		!move_to_dispenser(XMy+XThing,YMy+YThing,Parameters).

+!update_dispensers <- true.

+!update_roleZones: position(XMy,YMy) &
	roleZone(XZone,YZone)[entity(Myname),source(percept)] & 
	not(roleZone(Xr,Yr)[source(memory)] & (Xr-XMy <= XZone | Yr-YMy <= YZone ))
	<- 	+roleZone(XMy+XZone,YMy+YZone)[source(memory)];
		!move_to_roleZone(XMy+XZone,YMy+YZone).
	
+!update_roleZones <- true.
	
+!update_goalZones: position(XMy,YMy) &
	goalZone(XZone,YZone)[entity(Myname),source(percept)] & 
	not(goalZone(Xr,Yr)[source(memory)] & (Xr-XMy <= XZone | Yr-YMy <= YZone ))
	<- +goalZone(XMy+XZone,YMy+YZone)[source(memory)].
	
+!update_goalZones <- true.

/* Goals based on Memory */	

/* perceives a [THING] of the type [DISPENSER], it is doing nothing then exploring,
 * it has no block of the same type then it will move to the dispenser to collect a block. */ 
+!move_to_dispenser(XThing,YThing,Parameters): 
		not(doingSomething) & not(carryingMaxBlocks) &
		position(XMy,YMy) & roleAbleBlocks & not(has_block(Parameters))
	<- 	+movingToDispenser(XThing,YThing,Parameters).
	
+!move_to_dispenser(XThing,YThing,Parameters) <- true.
	
/* perceives a [ROLEZONE] */ 
+!move_to_roleZone(XZone,YZone): my_role(Role) & not(role(Role)[_]) & position(XMy,YMy)
		& not(movingToRoleZone(XOther,YOther) & (XOther > XZone | YOther > YZone ))
	<- 	-+movingToRoleZone(XZone,YZone).
+!move_to_roleZone(XZone,YZone) <- true.