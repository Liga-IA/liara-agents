/* This module implements exploration strategies */

/* MOVE TO DISPENSER */
+!moveTo(XDes,YDes,dispenser): movingToDispenser(XDes,YDes,Parameters) 
		& (position(XDes-1,YDes) | position(XDes+1,YDes) | position(XDes,YDes-1) | position(XDes,YDes+1))
	<-	.print("Arived at dispenser .. will collect Blocks");
		-movingToDispenser(XDes,YDes,Parameters);
		+collectingBlocks(XDes,YDes,Parameters);
		!!collectBlocks(XDes,YDes,Parameters).		

// - Include verification for obstacles (similar to exploration)
+!moveTo(XDes,YDes,dispenser): position(XMy,YMy) & XMy < XDes  <- move(e).
+!moveTo(XDes,YDes,dispenser): position(XMy,YMy) & XMy > XDes  <- move(w).
+!moveTo(XDes,YDes,dispenser): position(XMy,YMy) & YMy < YDes  <- move(s).
+!moveTo(XDes,YDes,dispenser): position(XMy,YMy) & YMy > YDes  <- move(n).
		
/* MOVE TO ROLE-ZONE */

+!moveTo(XDes,YDes,rolezone): position(XDes,YDes) | (position(XMy,YMy) & (roleZone(XMy,YMy)))
	<-	.print("Arived at RoleZone .. ");
		!adoptRole(XDes,YDes);
		-movingToRoleZone(XDes,YDes).	

// - Include verification for obstacles (similar to exploration)
+!moveTo(XDes,YDes,rolezone): position(XMy,YMy) & XMy < XDes  <-  move(e).
+!moveTo(XDes,YDes,rolezone): position(XMy,YMy) & XMy > XDes  <-  move(w).
+!moveTo(XDes,YDes,rolezone): position(XMy,YMy) & YMy < YDes  <- move(s).
+!moveTo(XDes,YDes,rolezone): position(XMy,YMy) & YMy > YDes  <-  move(n).