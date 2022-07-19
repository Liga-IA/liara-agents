/* This module implements MOVEMENT strategies */

/* MOVE TO DISPENSER */
+!moveTo(XDes,YDes,dispenser): movingToDispenser(XDes,YDes,Parameters) 
		& (position(XDes-1,YDes) | position(XDes+1,YDes) | position(XDes,YDes-1) | position(XDes,YDes+1))
	<-	.print("Arived at dispenser .. will collect Blocks");
		-movingToDispenser(XDes,YDes,Parameters);
		+collectingBlocks(XDes,YDes,Parameters);
		!!collectBlocks(XDes,YDes,Parameters).		
		
/* MOVE TO ROLE-ZONE */
+!moveTo(XDes,YDes,rolezone): position(XDes,YDes) | (position(XMy,YMy) & (roleZone(XMy,YMy)))
	<-	.print("Arived at RoleZone .. ");
		!adoptRole(XDes,YDes);
		-movingToRoleZone(XDes,YDes).	
		
		
/* MOVE TO GOAL-ZONE */
+!moveTo(XDes,YDes,goalzone): position(XDes,YDes) | (position(XMy,YMy) & (goalZone(XMy,YMy)))
	<-	.print("Arived at GoalZone .. ");
		// deliver the task
		-movingToGoalZone(XDes,YDes).
		
/* Otherwise - same for all */			
+!moveTo(XDes,YDes,_): thing(1,0,obstacle,_) & position(XMy,YMy) & XMy < XDes  <- clear(1,0).
+!moveTo(XDes,YDes,_): thing(-1,0,obstacle,_) & position(XMy,YMy) & XMy > XDes  <- clear(-1,0).
+!moveTo(XDes,YDes,_): thing(0,1,obstacle,_) & position(XMy,YMy) & YMy < YDes  <- clear(0,1).
+!moveTo(XDes,YDes,_): thing(0,-1,obstacle,_) & position(XMy,YMy) & YMy > YDes  <- clear(0,-1).
		
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes  <-  !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes  <-  !move(w).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes  <-  !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes  <-  !move(n).


/* MOVE with no absolute position (there is no information from the server, so it keeps a believe about it) */
+!move(n): position(X,Y) <- -position(X,Y); +position(X,Y-1); move(n).
+!move(s): position(X,Y) <- -position(X,Y); +position(X,Y+1); move(s).
+!move(e): position(X,Y) <- -position(X,Y); +position(X+1,Y); move(e).
+!move(w): position(X,Y) <- -position(X,Y); +position(X-1,Y); move(w).

