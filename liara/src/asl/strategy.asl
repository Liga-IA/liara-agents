// Agent strategy in project liara

/* Initial beliefs and rules */
position(0,0). 		// initial position
maxBlocks(2).  		// max of blocks
goingDirection(w). 	// going to W at begin

has_block(Type):- thing(X,Y,block,Type) & attached(X,Y).

doingSomething:- movingToDispenser(XThing,YThing,Parameters)[_].
carryingMaxBlocks:- maxBlocks(Max) & .count(attached(_,_),Qnt) &  Qnt >= Max.
roleAbleBlocks:- role(worker) | role(constructor).

/* Initial goals */

/* perceives a [THING] of the type [DISPENSER], 
 * it is doing nothing then exploring,
 * it has no block of the same type
 * then it will move to the dispenser to collect a block. */ 
+thing(XThing,YThing,dispenser,Parameters)[source(memory)]: 
		not(doingSomething) & not(carryingMaxBlocks) &
		position(XMy,YMy) & roleAbleBlocks & not(has_block(Parameters))
	<- 	+movingToDispenser(XThing,YThing,Parameters).
	
/* perceives a [ROLEZONE] */ 
+roleZone(XThing,YThing)[source(memory)]: my_role(Role) & not(role(Role)[_]) 
				& not(movingToRoleZone(XOther,YOther))
	<- 	-+movingToRoleZone(XThing,YThing).
		
/* In case it fails last MOVE action randomly - it repeats the action 
 * (TO DO) - Update position(X,Y) to previous one according the direction
 * */
+step(X): lastActionResult(random_failure)[_] & lastAction(move)[_] & lastActionParams([Direction])[_] 
	<-  !update_back_position(Direction);
		!move(Direction).
		
/* It perceives it has the block required for a SIMPLE task (1 block) */
+step(X): task(TName,Deadline,Reward,[req(0,1,Type)])[_] & has_block(Type) & goalZone(X1,Y1)[source(memory)] 
	<- 	!deliver_task(TName,Deadline,Reward,[req(0,1,Type)]).

/* It knows a simple task (1 block) and knows dispenser and goal zone
+step(X): task(TName,Deadline,Reward,[req(0,1,Type)])[_] & not(has_block(Type)) & thing(XD,YD,dispenser,Type) & goalZone(X1,Y1)[source(memory)] 
	<- 	+movingToDispenser(XD,YD,Parameters);
		!moveTo(XD,YD,dispenser). //trigger the move_to dispenser

/* MOVING TO ROLE ZONES */
+step(X) : movingToRoleZone(XDes,YDes)
	<- 	.print("<<<<<<< MOVE TO ROLE-ZONE >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,rolezone).

/* MOVING TO DISPENSERS */
+step(X) : movingToDispenser(XDes,YDes,Parameters) 
	<- 	.print("<<<<<<< MOVE TO DISPENSER >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,dispenser).

/* MOVING TO GOAL ZONES */
+step(X) : movingToGoalZone(XDes,YDes)
	<- 	.print("<<<<<<< MOVE TO ROLE-ZONE >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,golezone).
		
/* COLLECTING BLOCKS */		
+step(X) : collectingBlocks(XDes,YDes,Parameters)
	<- 	.print("<<<<<<< COLLECTING BLOCKS >>>>>>> (", XDes,",",YDes,") ---- ");
		!collectBlocks(XDes,YDes,Parameters).
		
/* EXPLORATION STRATEGY */	
	
/* In case the last MOVE action fails, it changes direction		*/
+step(X): goingDirection(Direction) & lastActionResult(failed_path)[_] & lastAction(move)[_] & lastActionParams([Direction])[_]
	<- 	.print("<<<<<<< EXPLORE >>>>>>> ");
		!explore_next(Direction).
		
+step(X): lastActionResult(failed_path)[_] & lastAction(move)[_] & lastActionParams([Direction])[_] 
	<- 	!update_back_position(Direction);
		!explore_next(Direction).
		
/* Otherwise It keeps going to the previous direction */
+step(X): goingDirection(Direction)
	<- 	.print("<<<<<<< EXPLORE >>>>>>> ");
		!explore(Direction).
		
+no_action(_): goingDirection(Direction)
	<- 	.print("<<<<<<< EXPLORE >>>>>>> ");
		!explore(Direction).

