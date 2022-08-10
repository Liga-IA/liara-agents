/* This module implements MOVEMENT strategies */

/* MOVE TO DISPENSER */
+!moveTo(XDes,YDes,dispenser): movingToDispenser(XDes,YDes,Parameters) 
		& (position(XDes-1,YDes) | position(XDes+1,YDes) | position(XDes,YDes-1) | position(XDes,YDes+1))
	<-	-movingToDispenser(XDes,YDes,Parameters);
		+collectingBlocks(XDes,YDes,Parameters);
		!collectBlocks(XDes,YDes,Parameters).		
		
/* MOVE TO ROLE-ZONE */
+!moveTo(XDes,YDes,rolezone): position(XDes,YDes) | (position(XMy,YMy) & (roleZone(XMy,YMy)[source(memory)]))
	<-	!adoptRole(XDes,YDes);
		-movingToRoleZone(XDes,YDes).	
		
/* MOVE TO GOAL-ZONE */
+!moveTo(XDes,YDes,goalzone): position(XDes,YDes) | (position(XMy,YMy) & (goalZone(XMy,YMy)[source(memory)]))
	<-	-movingToGoalZone(XDes,YDes);
		!continue.
		
/* Otherwise - same for all */		
/* Without obstacles */

+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  <-  !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) <-  !move(n).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  <-  !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) <-  !move(w).

+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes  <-  clear(0,1).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes  <-  clear(0,-1).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes  <-  clear(1,0).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes  <-  clear(-1,0).

/* MOVE with no absolute position (there is no information from the server, so it keeps a believe about it) */
//+!move(s): position(X,Y) <- -position(X,Y); move(s); +position(X,Y+1).
//+!move(n): position(X,Y) <- -position(X,Y); move(n); +position(X,Y-1).
//+!move(e): position(X,Y) <- -position(X,Y); move(e); +position(X+1,Y).
//+!move(w): position(X,Y) <- -position(X,Y); move(w); +position(X-1,Y).

+!move(s) <- move(s).
+!move(n) <- move(n).
+!move(e) <- move(e).
+!move(w) <- move(w).

///* Fix Memory when the MOVE action fails */
//+!update_back_position(s): expected_position(X,Y) <- -expected_position(X,Y); +expected_position(X,Y-1).
//+!update_back_position(n): expected_position(X,Y) <- -expected_position(X,Y); +expected_position(X,Y+1).
//+!update_back_position(e): expected_position(X,Y) <- -expected_position(X,Y); +expected_position(X-1,Y).
//+!update_back_position(w): expected_position(X,Y) <- -expected_position(X,Y); +expected_position(X+1,Y).

/* update memory about position */
+!update_position(s): position(X,Y) <- -position(X,Y); +position(X,Y+1).
+!update_position(n): position(X,Y) <- -position(X,Y); +position(X,Y-1).
+!update_position(e): position(X,Y) <- -position(X,Y); +position(X+1,Y).
+!update_position(w): position(X,Y) <- -position(X,Y); +position(X-1,Y).



