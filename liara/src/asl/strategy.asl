// Agent strategy in project liara

/* Initial beliefs and rules */
maxBlocks(2).
goingDirection(w).

doingSomething:- movingToDispenser(XThing,YThing,Parameters)[_].
carryingMaxBlocks:- maxBlocks(Max) & .count(attached(_,_),Qnt) &  Qnt >= Max.
roleAbleBlocks:- role(worker) | role(constructor).

/* Initial goals */


// perceives a [THING] of the type [DISPENSER], and it is doing nothing then exploring, then it will move to it to collect blocks.
+thing(XThing,YThing,dispenser,Parameters)[source(memory)]: 
		not(doingSomething) & not(carryingMaxBlocks) &
		position(XMy,YMy) & roleAbleBlocks
	<- 	.print("Perceived a [DISPENSER] at position (",XThing,",",YThing,") fo the type: ", Parameters,	" going to there..");
	+movingToDispenser(XThing,YThing,Parameters).
	
// perceives a [ROLEZONE]  
+roleZone(XThing,YThing)[source(memory)]: my_role(Role) & not(role(Role)[_]) 
				& not(movingToRoleZone(XOther,YOther))
	<- 	.print("################################ <<<<>>>>>> ###########################");
		-+movingToRoleZone(XThing,YThing).



+step(X) : movingToDispenser(XDes,YDes,Parameters) 
	<- 	.print("<<<<<<< MOVE TO DISPENSER >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,dispenser).

+step(X) : movingToRoleZone(XDes,YDes)
	<- 	.print("<<<<<<< MOVE TO ROLE-ZONE >>>>>>> (", XDes,",",YDes,") ---- ");
		!moveTo(XDes,YDes,rolezone).
		
+step(X) : collectingBlocks(XDes,YDes,Parameters)
	<- 	.print("<<<<<<< COLLECTING BLOCKS >>>>>>> (", XDes,",",YDes,") ---- ");
		!collectBlocks(XDes,YDes,Parameters).
		
+step(X): goingDirection(Direction) & lastActionResult(failed_path)[_] & lastAction(move)[_] & lastActionParams([Direction])[_]
	<- 	.print("<<<<<<< EXPLORE >>>>>>> ");
		!explore_next(Direction).

+step(X): goingDirection(Direction)
	<- 	.print("<<<<<<< EXPLORE >>>>>>> ");
		!explore(Direction).

