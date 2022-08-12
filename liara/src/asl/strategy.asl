// Agent strategy in project liara

/* Initial beliefs and rules */
position(0,0). 		    // initial position
maxBlocks(1).  		    // max of blocks
goingDirection(w). 	    // going to W at begin

doingSomething:- movingToDispenser(XThing,YThing,Parameters)[_].
carryingMaxBlocks:- maxBlocks(Max) & .count(attached(_,_),Qnt) &  Qnt >= Max.
roleAbleBlocks:- role(worker) | role(constructor).

/* Initial goals */

/* reset the agent */
//+step(-1) <- .abolish(_[source(memory)]); -position(_,_); +position(0,0).

/* In case it generates the random_failure - it repeats the last action 
 * (TO DO) - implement it to all actions with random_failure
 * */
+step(X): lastActionResult(random_failure)[_] & lastAction(move)[_] & lastActionParams([Direction])[_] 
	<-  !move(Direction).
		
/* In case the last MOVE action fails, it changes direction		*/
+step(X): lastActionResult(failed_path)[_] & lastAction(move)[_] & lastActionParams([Direction])[_] 
	<- 	!change_direction(Direction);
		!continue.

/* In case it has success on moving, update its position */
+step(X): lastActionResult(success)[_] & lastAction(move)[_] & lastActionParams([Direction])[_] 
	<-  !update_position(Direction);
		!update_memory;
		!continue.
		
/* fails at target for clear action -> go to CCW */		
+step(X): lastActionResult(failed_target)[_] & position(XMy,YMy) & lastAction(clear)[_] & lastActionParams([-1,0])[_] & thing(-1,0,entity,_)[_] <- !moveTo(XMy,YMy-1,avoid).
+step(X): lastActionResult(failed_target)[_] & position(XMy,YMy) & lastAction(clear)[_] & lastActionParams([1,0])[_]  & thing(1,0,entity,_)[_]  <- !moveTo(XMy,YMy+1,avoid).
+step(X): lastActionResult(failed_target)[_] & position(XMy,YMy) & lastAction(clear)[_] & lastActionParams([0,-1])[_] & thing(0,-1,entity,_)[_] <- !moveTo(XMy+1,YMy,avoid).
+step(X): lastActionResult(failed_target)[_] & position(XMy,YMy) & lastAction(clear)[_] & lastActionParams([0,1])[_]  & thing(0,1,entity,_)[_]  <- !moveTo(XMy-1,YMy,avoid).


		
/* It continues after treating failures */		
+step(X) <- !continue.
		
/* It perceives it has the block required for a SIMPLE task (1 block) */
+!continue: task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_] & has_block(Type) & goalZone(X1,Y1)[source(memory)] 
	<- 	!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)]).

/* MOVING TO ROLE ZONES */
/* It doesn't has a role yet and knows any RoleZone	*/
+!continue: my_role(Role) & not(role(Role)[_]) & not(movingToRoleZone(_,_)) & roleZone(XThing,YThing)[source(memory)] 
	<- 	+movingToRoleZone(XThing,YThing);
	  	!moveTo(XThing,YThing,rolezone).
	  	
/* It is going already */
+!continue: movingToRoleZone(XDes,YDes) 
	<- 	!moveTo(XDes,YDes,rolezone).

/* MOVING TO DISPENSERS */
+!continue: movingToDispenser(XDes,YDes,Parameters) 
	<- 	!moveTo(XDes,YDes,dispenser).

/* MOVING TO GOAL ZONES */
+!continue: movingToGoalZone(XDes,YDes)
	<- 	!moveTo(XDes,YDes,goalzone).
		
/* COLLECTING BLOCKS */		
+!continue: collectingBlocks(XDes,YDes,Parameters)
	<- 	!collectBlocks(XDes,YDes,Parameters).
			
			
/* EXPLORATION STRATEGY */	
		
/* Otherwise It keeps going to the previous direction */
+!continue : goingDirection(Direction)
	<- 	!explore(Direction).
		
+no_action(_)
	<- 	!explore(w).
	
	
	