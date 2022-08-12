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
	<-	.abolish(movingToGoalZone(XDes,YDes));
		!continue.
		
/* Otherwise - same for all */
/* 0 BLOCKS */		
/* WITHOUT obstacles  */
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_))  <-  !move(s).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <-  !move(n).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_))  <-  !move(e).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <-  !move(w).

+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_)) <-  !move(e).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_)) <-  !move(e).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_)) <-  !move(s). 
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_)) <-  !move(s).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- !move(n).

/* WITH obstacles */
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy < YDes <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & YMy > YDes <- clear(0,-1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy < XDes <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(attached(_,_),0) & position(XMy,YMy) & XMy > XDes <- clear(-1,0).


/* 1 BLOCK */		
/* WITHOUT obstacles  */
/* block back going to S (0,1) */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_))  <-  !move(s).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_)) & not(thing(-1,1,obstacle,_) | thing(-1,1,entity,_)) <-  !move(s).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy < YDes & not(thing(0,1,obstacle,_) | thing(0,1,entity,_)) & not(thing(1,1,obstacle,_)  | thing(1,1,entity,_)) <-  !move(s).
/* block back going to N (0,-1) */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <-  !move(n).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) & not(thing(-1,-1,obstacle,_) | thing(-1,-1,entity,_)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) & not(thing(1,-1,obstacle,_) | thing(1,-1,entity,_)) <- !move(n).
/* block back (-1,0) going to E (1,0) */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_))  <-  !move(e).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_)) & not(thing(1,-1,obstacle,_)  | thing(1,-1,entity,_)) <-  !move(e).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_)) & not(thing(1,1,obstacle,_)  | thing(1,1,entity,_)) <-  !move(e).
/* block back (1,0) going to E (-1,0) */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <-  !move(w).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) & XMy > XDes & not(thing(-1,-1,obstacle,_) | thing(-1,-1,entity,_)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) & not(thing(-1,1,obstacle,_) | thing(-1,1,entity,_)) <- !move(w).

/* WITH obstacles */
/* block back */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy < YDes <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy > YDes <- clear(0,-1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy < XDes <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy > XDes <- clear(-1,0).

/* block front -> rotate to side there is no obstacle */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy < YDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy < YDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_))  <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy > YDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_))  <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy > YDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy < XDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_))  <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy < XDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy > XDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy > XDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_))  <- rotate(ccw).

/* block front and cannot rotate -> clear to rotate CW */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & position(XMy,YMy) & YMy < YDes & thing(-1,0,obstacle,_) <- clear(-1,0).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & position(XMy,YMy) & YMy > YDes & thing(1,0,obstacle,_)  <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & position(XMy,YMy) & XMy < XDes & thing(0,1,obstacle,_)  <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & position(XMy,YMy) & XMy > XDes & thing(0,-1,obstacle,_) <- clear(0,-1).

/* (TO DO) block right  */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & thing(-1,1,obstacle,_)  & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_)) & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & thing(1,-1,obstacle,_)  & position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) & not(thing(0,1,obstacle,_) | thing(0,1,entity,_)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & thing(-1,-1,obstacle,_) & position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) & not(thing(1,0,obstacle,_) | thing(1,0,entity,_)) <-  rotate(cw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & thing(1,1,obstacle,_)   & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_)) & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <-  rotate(cw).

/* (TO DO) block left  */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(-1,0) & thing(-1,1,obstacle,_) & position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) & not(thing(0,1,obstacle,_) | thing(0,1,entity,_)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(1,0)  & thing(1,1,obstacle,_)  & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_)) & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,-1) & thing(1,-1,obstacle,_) & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_)) & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <-  rotate(ccw).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & attached(0,1)  & thing(-1,1,obstacle,_) & position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) & not(thing(1,0,obstacle,_) | thing(1,0,entity,_)) <-  rotate(ccw).

/* TEMPORARY */
/* blocks by side, just try to move */
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_)  | thing(0,1,entity,_))  <- !move(s).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_) | thing(0,-1,entity,_)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_)  | thing(1,0,entity,_))  <- !move(e).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_) | thing(-1,0,entity,_)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & YMy < YDes & thing(0,1,entity,_)  <- !moveTo(XDes-1,YDes,_).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & YMy > YDes & thing(0,-1,entity,_) <- !moveTo(XDes+1,YDes,_).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & XMy < XDes & thing(1,0,entity,_)  <- !moveTo(XDes,YDes-1,_).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & XMy > XDes & thing(-1,0,entity,_) <- !moveTo(XDes,YDes+1,_).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & YMy < YDes  <-  clear(0,1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & YMy > YDes  <-  clear(0,-1).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & XMy < XDes  <-  clear(1,0).
+!moveTo(XDes,YDes,_): .count(attached(_,_),1) & position(XMy,YMy) & XMy > XDes  <-  clear(-1,0).
/* Temporary above */



/* MOVE action*/
+!move(s) <- move(s).
+!move(n) <- move(n).
+!move(e) <- move(e).
+!move(w) <- move(w).

/* update memory about position */
+!update_position(s): position(X,Y) <- -position(X,Y); +position(X,Y+1).
+!update_position(n): position(X,Y) <- -position(X,Y); +position(X,Y-1).
+!update_position(e): position(X,Y) <- -position(X,Y); +position(X+1,Y).
+!update_position(w): position(X,Y) <- -position(X,Y); +position(X-1,Y).



