// Agent strategy in project liara

/* Initial beliefs and rules */
position(0,0).
maxBlocks(2).
goingDirection(w).

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
	<- 	.print("Perceived a [DISPENSER] at position (",XThing,",",YThing,") fo the type: ", Parameters,	" going to there..");
	+movingToDispenser(XThing,YThing,Parameters).
	
/* perceives a [ROLEZONE] */ 
+roleZone(XThing,YThing)[source(memory)]: my_role(Role) & not(role(Role)[_]) 
				& not(movingToRoleZone(XOther,YOther))
	<- 	.print("################################ <<<<<>>>>>> ###########################");
		-+movingToRoleZone(XThing,YThing).
		
/* IT PERCEIVES IT HAS THE BLOCK REQUIRED FOR A SIMPLE TASK (1 block) */
+step(X): task(TName,Deadline,Reward,[req(0,1,Type)])[_] & has_block(Type) & goalZone(X1,Y1)[source(memory)] 
	<- !deliver_task(TName,Deadline,Reward,[req(0,1,Type)]).
		
/* MOVING TO DISPENSERS */
+step(X) : movingToDispenser(XDes,YDes,Parameters) 
	<- 	.print("<<<<<<< MOVE TO DISPENSER >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,dispenser).

/* MOVING TO ROLE ZONES */
+step(X) : movingToRoleZone(XDes,YDes)
	<- 	.print("<<<<<<< MOVE TO ROLE-ZONE >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,rolezone).

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
		
/* Otherwise It keeps going to the previous direction */
+step(X): goingDirection(Direction)
	<- 	.print("<<<<<<< EXPLORE >>>>>>> ");
		!explore(Direction).

