// Agent complete_task in project liara

/* Initial beliefs and rules */

has_block(Type):- thing(X,Y,block,Type) & attached(X,Y).

/* Initial goals */

/* Simple task (1 block) */
/* In case the block is at correct position - DELIVER */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(XDel,YDel)
	<- 	-movingToGoalZone(X,Y);
		!submit_task(TName).

/* In case the block is not at correct position - ROTATE (CW - clockwise | or | CCW - counterclockwise) */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y)
	<- 	rotate(cw).
	
/* in case it is not at goalZone - MOVE */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: goalZone(X,Y)[source(memory)] 
	<- 	-+movingToGoalZone(X,Y);
		!moveTo(X,Y,goalzone).
		
+!submit_task(TName) <- submit(TName).