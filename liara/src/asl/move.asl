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
/* When it is not aligned and there is path to align X or Y */
//+!moveTo(XDes,YDes,_): thing(1,0,obstacle,_)  & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)) <- !move(s).	
//+!moveTo(XDes,YDes,_): thing(1,0,obstacle,_)  & position(XMy,YMy) & YMy > YDes & not(thing(0,1,obstacle,_)) <- !move(n).	
//+!moveTo(XDes,YDes,_): thing(-1,0,obstacle,_) & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)) <- !move(s).
//+!moveTo(XDes,YDes,_): thing(-1,0,obstacle,_) & position(XMy,YMy) & YMy > YDes & not(thing(0,1,obstacle,_)) <- !move(n).
//+!moveTo(XDes,YDes,_): thing(0,1,obstacle,_)  & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)) <- !move(w).
//+!moveTo(XDes,YDes,_): thing(0,1,obstacle,_)  & position(XMy,YMy) & XMy > XDes & not(thing(1,0,obstacle,_)) <- !move(e).
//+!moveTo(XDes,YDes,_): thing(0,-1,obstacle,_) & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)) <- !move(w).
//+!moveTo(XDes,YDes,_): thing(0,-1,obstacle,_) & position(XMy,YMy) & XMy > XDes & not(thing(1,0,obstacle,_)) <- !move(e).

/* Otherwise clear the obstacles */
+!moveTo(XDes,YDes,_): thing(1,0,obstacle,_) & position(XMy,YMy) & XMy < XDes  <- clear(1,0).
+!moveTo(XDes,YDes,_): thing(-1,0,obstacle,_) & position(XMy,YMy) & XMy > XDes  <- clear(-1,0).
+!moveTo(XDes,YDes,_): thing(0,1,obstacle,_) & position(XMy,YMy) & YMy < YDes  <- clear(0,1).
+!moveTo(XDes,YDes,_): thing(0,-1,obstacle,_) & position(XMy,YMy) & YMy > YDes  <- clear(0,-1).

/* Otherwise (no obstacles) just move */	
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes  <-  !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes  <-  !move(w).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes  <-  !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes  <-  !move(n).

/* MOVE with no absolute position (there is no information from the server, so it keeps a believe about it) */
+!move(n): position(X,Y) <- -position(X,Y); move(n); +position(X,Y-1).
+!move(s): position(X,Y) <- -position(X,Y); move(s); +position(X,Y+1).
+!move(e): position(X,Y) <- -position(X,Y); move(e); +position(X+1,Y).
+!move(w): position(X,Y) <- -position(X,Y); move(w); +position(X-1,Y).

/* Fix Memory when the MOVE action fails */
+!update_back_position(n): position(X,Y) <- -position(X,Y); +position(X,Y+1).
+!update_back_position(s): position(X,Y) <- -position(X,Y); +position(X,Y-1).
+!update_back_position(e): position(X,Y) <- -position(X,Y); +position(X-1,Y).
+!update_back_position(w): position(X,Y) <- -position(X,Y); +position(X+1,Y).



