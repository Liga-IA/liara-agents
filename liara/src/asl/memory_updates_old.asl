/* Implements memory updates (things the agent needs to remember) */

+!update_memory 
	<-	!update_dispensers;
		!update_roleZones;
		!update_goalZones;
		!fix_carrying_blocks.
	
+!update_dispensers 
	<- 	!add_dispenser;
		!move_to_dispenser.
		
+!add_dispenser: position(XMy,YMy) &
	thing(XThing,YThing,dispenser,Parameters)[entity(Myname),source(percept)] &
	not(thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)]) 
	<- 	+thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)].
		
+!add_dispenser <- true.

+!update_roleZones: position(XMy,YMy) &
	roleZone(XZone,YZone)[entity(Myname),source(percept)] & 
	not(roleZone(XMy+XZone,YMy+YZone)[source(memory)])
	<- 	+roleZone(XMy+XZone,YMy+YZone)[source(memory)];
		!move_to_roleZone(XMy+XZone,YMy+YZone).
	
+!update_roleZones <- true.
	
+!update_goalZones: position(XMy,YMy) &
	goalZone(XZone,YZone)[entity(Myname),source(percept)] & 
	not(goalZone(XMy+XZone,YMy+YZone)[source(memory)])
	<- +goalZone(XMy+XZone,YMy+YZone)[source(memory)];
		!move_to_goalZone(XMy+XZone,YMy+YZone).
	
+!update_goalZones <- true.


/* Goals based on Memory */	

/* perceives a [THING] of the type [DISPENSER], it is doing nothing then exploring,
 * it has no block of the same type then it will move to the dispenser to collect a block. */ 
+!move_to_dispenser: position(XMy,YMy) & roleAbleBlocks & not(has_block(Parameters) & carryingMaxBlocks) &
		thing(XThing,YThing,dispenser,Parameters)[entity(Myname),source(percept)] 
		& not(movingToDispenser(XOther,YOther) &  (math.abs(XOther-XMy)+math.abs(YOther-YMy)) <= (math.abs(XThing-XMy) + math.abs(YThing-YMy)) )
	<-  -movingToDispenser(_,_); +movingToDispenser(XMy+XThing,YMy+YThing,Parameters).
	
+!move_to_dispenser <- true.
	
/* perceives a [ROLEZONE] */ 
+!move_to_roleZone(XZone,YZone): my_role(Role) & not(role(Role)[_]) & position(XMy,YMy)
		& not(movingToRoleZone(XOther,YOther) &  (math.abs(XOther-XMy) + math.abs(YOther-YMy)) <= (math.abs(XZone-XMy) + math.abs(YZone-YMy)) )
	<- 	-movingToRoleZone(_,_); +movingToRoleZone(XZone,YZone).
	
+!move_to_roleZone(XZone,YZone) <- true.

/* In case it is going to a GoalZone and finds another closer it updates */
+!move_to_goalZone(XZone,YZone): position(XMy,YMy) &
		movingToGoalZone(XOther,YOther) &  (math.abs(XOther-XMy)+math.abs(YOther-YMy)) > (math.abs(XZone-XMy) + math.abs(YZone-YMy))  
	<- 	-movingToGoalZone(_,_); +movingToGoalZone(XZone,YZone).
	
+!move_to_goalZone(XZone,YZone) <- true.
	
/* In case it lose the block because a clear event */
+!fix_carrying_blocks: not(attached(_,_)) & carrying_block <- -carrying_block.
+!fix_carrying_blocks <- -true.
	