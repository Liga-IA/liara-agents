// Agent strategy in project liara

/* Initial beliefs and rules */
position(0,0). 		    // initial position
maxBlocks(1).  		    // max of blocks
goingDirection(w). 	    // going to W at begin

carryingMaxBlocks:- maxBlocks(Max) & .count(has_block(_),Qnt) &  Qnt >= Max.
roleAbleBlocks:- role(worker) | role(constructor).

/* Initial goals */

/* reset the agents */
+simEnd[entity(_),source(percept)] <- !change_round.

+step(X): lastActionResult(failed_status)[_] & deactivated(true)[_]
	<-  skip.
	
/* fails to connect because the partner, and it is the auxiliar agent -> move away 4 blocks */	
+step(X): lastActionResult(failed_partner)[_] & lastAction(connect)[_] & helping(Ag,TName,XMy,YMy,_,_,_,2)
	<-  +waiting_away(Ag,TName,XMy,YMy+4,S+4);
		!moveTo(XMy,YMy+4,away).
	

/* In case it generates the random_failure - it repeats the last action 
 * (TO DO) - implement it to all actions with random_failure
 * */
+step(X): lastAction(move)[_] & lastActionResult(random_failure)[_] & lastActionParams([Direction])[_] 
	<-  !move(Direction).
		
/* In case the last MOVE action fails, it changes direction	CW */
+step(X): lastAction(move)[_] & lastActionResult(failed_path)[_] & lastActionParams([w])[_] & position(XMy,YMy) <- !change_direction(w); !moveTo(XMy,YMy-1,avoid).
+step(X): lastAction(move)[_] & lastActionResult(failed_path)[_] & lastActionParams([e])[_] & position(XMy,YMy) <- !change_direction(e); !moveTo(XMy,YMy+1,avoid).
+step(X): lastAction(move)[_] & lastActionResult(failed_path)[_] & lastActionParams([s])[_] & position(XMy,YMy) <- !change_direction(s); !moveTo(XMy-1,YMy,avoid).
+step(X): lastAction(move)[_] & lastActionResult(failed_path)[_] & lastActionParams([n])[_] & position(XMy,YMy) <- !change_direction(n); !moveTo(XMy+1,YMy,avoid).

/* In case it has success on moving, update its position */
+step(X): lastActionResult(success)[_] & lastAction(move)[_] & lastActionParams([Direction])[_] 
	<-  !update_position(Direction);
		?position(XMy,YMy);
		!update_memory(XMy,YMy); 
		!!update_mate(X,XMy,YMy);
		!!clear_old_found_mate(X);
		!continue.
		
/* fails at target for clear action -> go to CCW */		
+step(X): lastAction(clear)[_] & lastActionResult(failed_target)[_] & position(XMy,YMy) & lastActionParams([-1,0])[_] & thing(-1,0,entity,_)[_] <- !moveTo(XMy,YMy-1,avoid).
+step(X): lastAction(clear)[_] & lastActionResult(failed_target)[_] & position(XMy,YMy) & lastActionParams([1,0])[_]  & thing(1,0,entity,_)[_]  <- !moveTo(XMy,YMy+1,avoid).
+step(X): lastAction(clear)[_] & lastActionResult(failed_target)[_] & position(XMy,YMy) & lastActionParams([0,-1])[_] & thing(0,-1,entity,_)[_] <- !moveTo(XMy+1,YMy,avoid).
+step(X): lastAction(clear)[_] & lastActionResult(failed_target)[_] & position(XMy,YMy) & lastActionParams([0,1])[_]  & thing(0,1,entity,_)[_]  <- !moveTo(XMy-1,YMy,avoid).

/* fails submitting task -> normally it is because goalZone disappeared */
+step(X): lastAction(submit)[_]  & lastActionResult(failed)[_] 			<- !fix_goalZones; !continue.
+step(X): lastAction(adopt)[_] & lastActionResult(failed_location)[_] 	<- !fix_roleZones; !continue.

/* fails rotating */		
+step(X): lastAction(rotate)[_] & lastActionResult(failed)[_] & lastActionParams([ccw])[_] & position(XMy,YMy) <- !moveTo(XMy+1,YMy,avoid).
+step(X): lastAction(rotate)[_] & lastActionResult(failed)[_] & lastActionParams([cw])[_]  & position(XMy,YMy) <- !moveTo(XMy-1,YMy,avoid).

/* success attaching a block */
+step(X): lastAction(attach)[_] & lastActionResult(success)[_] <- -collectingBlocks(_,_,_); +carrying_block;  !continue.
/* success submit task */
+step(X): lastAction(submit)[_] & lastActionResult(success)[_] <- -submitting(_,_); -carrying_block;  !continue.

/* fails attaching a block -> tries again */
+step(X): lastAction(attach)[_] & lastActionResult(random_failure)[_] & lastActionParams([Direction])[_] <- attach(Direction).
/* fails requesting block at dispenser -> tries again */
+step(X): lastAction(request)[_] & lastActionResult(random_failure)[_] & lastActionParams([Direction])[_] <- request(Direction).

/* submit task of 2 blocks -> (TO DO) need change after considering more than 2 blocks */
+step(X): lastAction(connect)[_] & lastActionResult(success)[_] & helping(_,TName,_,_,_,_,_,1) <- +submitting(TName,1); !continue.
+step(X): lastAction(connect)[_] & lastActionResult(success)[_] & helping(_,TName,_,_,_,_,_,2) <- +submitting(TName,2); !continue.

		
/* It continues after treating failures */		
+step(X) <- !continue.

+!continue: waiting_away(Ag,TName,X,Y,S) & step(S2) & S<=S2
	<- 	-waiting_away(Ag,TName,X,Y,S).

+!continue: waiting_away(Ag,TName,X,Y,S)
	<- 	!moveTo(X,Y,away).

/* MOVING TO ROLE ZONES */
/* It doesn't has a role yet and knows any RoleZone	*/
+!continue: not(movingToRoleZone(_,_)) & my_role(Role) & not(role(Role)[_]) & closest(roleZone,XZ,YZ)
	<- 	+movingToRoleZone(XZ,YZ);
	  	!moveTo(XZ,YZ,rolezone).


/* SUBMITTING TASKS */
/* It perceives it has the block required for a DOUBLE (2 blocks) task  */
+!continue: submitting(TName,_) & task(TName,_,_,_)[_] & helping(_,TName,MyBlock,_,_,_,_,_) & has_block(MyBlock)
	<- 	submit(TName).	
	
+!continue: (submitting(TName,_) | helping(_,TName,_,_,_,_,_,_)) & not(task(TName,_,_,_)[_])
	<- 	-submitting(TName,_);
		-helping(_,TName,_,_,_,_,_,_);
		!continue.	

+!continue: helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & task(TName,_,_,_)[_] & has_block(MyBlock) & position(XZ,YZ) // ( TO DO ) test if it is not a goalzone anymore
	<- 	!connect(Ag,XZ,YZ,XO,YO).

+!continue: helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & task(TName,_,_,_)[_] & has_block(MyBlock) & not(position(XZ,YZ))  
	<- 	!moveTo(XZ,YZ,delivery).
	
+!continue: helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & task(TName,_,_,_)[_] & not(has_block(MyBlock)) & closest(dispenser,MyBlock,XD,YD) 
	<- 	+movingToDispenser(XD,YD,MyBlock);
		!moveTo((XD-1),YD,dispenser).

+!continue: requested_colaboration(TName,XZ,YZ,_,_,BlockType)
	<- 	!decide_collaborator(TName,XZ,YZ,BlockType).

+!continue: task(TName,_,_,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)])[_] 
		& not(cannot_deliver(TName)) & team_group(List) & not(.empty(List)) 
		& ((has_block(Type1) & math.abs(XDel1+YDel1)==1) | (has_block(Type2) & math.abs(XDel2+YDel2)==1)) // has the primary block 
		& goalZone(X1,Y1)[source(memory)] 
	<- 	!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List).

		
/* It perceives it has the block required for a SIMPLE task (1 block) */
+!continue: task(TName,_,_,[req(XDel,YDel,Type)])[_] & has_block(Type) & goalZone(X1,Y1)[source(memory)] 
	<- 	!deliver_task(TName,[req(XDel,YDel,Type)]).

/* Get a block in case it is doing nothing else */
+!continue: not(has_block(_)) & not(movingToDispenser(_,_,_)) & not(collectingBlocks(_,_,_)) & my_role(Role) & role(Role)[_] & closest(dispenser,BlockType,XD,YD)
	<- 	+movingToDispenser(XD,YD,BlockType);
		!moveTo((XD-1),YD,dispenser).
	  	
/* It is going already */
/* MOVING TO ROLE ZONES */
+!continue: movingToRoleZone(XDes,YDes) 
	<- 	!moveTo(XDes,YDes,rolezone).

/* MOVING TO DISPENSERS */
+!continue: movingToDispenser(XDes,YDes,Parameters) 
	<- 	!moveTo(XDes-1,YDes,dispenser).

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
	
	
	