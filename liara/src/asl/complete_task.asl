// Agent complete_task in project liara

/* Initial beliefs and rules */

has_block(Type):- thing(X,Y,block,Type) & attached(X,Y).

/* Initial goals */

/* Simple task (1 block) */
/* In case the block is at correct position - DELIVER */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(XDel,YDel) & thing(XDel,YDel,block,Type)
	<- 	-movingToGoalZone(_,_);
		!submit_task(TName).


/* In case the block is not at correct position - ROTATE (CW - clockwise | or | CCW - counterclockwise) */
/* In case cannot rotate because obstacles, clear the obstacles */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(-1,0) & thing(0,-1,obstacle,_)
	<- 	clear(0,-1).	
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(0,1) & thing(-1,0,obstacle,_)
	<- 	clear(-1,0).
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(1,0) & thing(0,1,obstacle,_)
	<- 	clear(0,1).
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(0,-1) & thing(1,0,obstacle,_)
	<- 	clear(1,0).
	
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y)
	<- 	rotate(cw).


/* in case it is not at goalZone - MOVE */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: goalZone(X,Y)[source(memory)] 
	<- 	-+movingToGoalZone(_,_);
		!moveTo(X,Y,goalzone).
		
+!submit_task(TName) <- submit(TName).