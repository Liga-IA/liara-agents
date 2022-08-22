/* This module implements MOVEMENT strategies */

obstacle_at(X,Y):- thing(X,Y,obstacle,_) | thing(X,Y,entity,_) | thing(X,Y,block,_).
obstacle_cannot_clear_at(X,Y):- team(Team) & thing(X,Y,entity,Team) | thing(X,Y,block,_).
safe_distance(4).

/* MOVE TO DISPENSER */
+!moveTo(XDes,YDes,dispenser): movingToDispenser(XDes+1,YDes,Parameters) & position(XDes,YDes)
		//& (position(XDes-1,YDes) | position(XDes+1,YDes) | position(XDes,YDes-1) | position(XDes,YDes+1))
	<-	-movingToDispenser(_,_,_);
		+collectingBlocks(XDes+1,YDes,Parameters);
		!collectBlocks(XDes+1,YDes,Parameters).	

/* when it ends over the dispenser it is going to */
+!moveTo(XDes,YDes,dispenser): thing(XDes,YDes,dispenser,_) & position(XDes,YDes) <- !moveTo(XDes-1,YDes,avoid).
		
		
/* MOVE TO ROLE-ZONE */
+!moveTo(XDes,YDes,rolezone): position(XDes,YDes) | (position(XMy,YMy) & (roleZone(XMy,YMy)[source(memory)]))
	<-	!adoptRole(XDes,YDes);
		-movingToRoleZone(XDes,YDes).
/* finds a better RoleZone */	
+!moveTo(XDes,YDes,rolezone): position(XMy,YMy) & roleZone(XO,YO)[source(memory)] & 
		((math.abs(XO-XMy) + math.abs(YO-YMy)) < (math.abs(XDes-XMy) + math.abs(YDes-YMy))) & 
		not(roleZone(XO2,YO2)[source(memory)] & (math.abs(XO2-XMy) + math.abs(YO2-YMy)) < (math.abs(XO-XMy) + math.abs(YO-YMy)))
	<-	-movingToRoleZone(XDes,YDes);
		+movingToRoleZone(XO,YO);
		!moveTo(XO,YO,avoid).
		
/* MOVE TO GOAL-ZONE */
+!moveTo(XDes,YDes,goalzone): position(XDes,YDes) | (position(XMy,YMy) & (goalZone(XMy,YMy)[source(memory)]))
	<-	-movingToGoalZone(XDes,YDes);
		!continue.
/* finds a better GoalZone */	
+!moveTo(XDes,YDes,goalzone): position(XMy,YMy) & goalzone(XO,YO)[source(memory)] & 
		((math.abs(XO-XMy) + math.abs(YO-YMy)) < (math.abs(XDes-XMy) + math.abs(YDes-YMy))) & 
		not(goalzone(XO2,YO2)[source(memory)] & (math.abs(XO2-XMy) + math.abs(YO2-YMy)) < (math.abs(XO-XMy) + math.abs(YO-YMy)))
	<-	-movingToGoalZone(XDes,YDes);
		+movingToGoalZone(XO,YO);
		!moveTo(XO,YO,goalzone).
		
		
///* MOVE to DELIVERY task with multiple blocks */
///* ABORE LEFT */
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & YZ<YO & /* approach from above to deliver above left | centred | right  */ 
//		position(XMy,YMy) & YMy<YZ & not(XMy == XZ)
//	<- 	!moveTo(XZ,YMy,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ<XO & YZ<YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy>(YZ+SF) & XMy>XZ 
//	<- 	!moveTo(XZ,YMy,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ<XO & YZ<YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy>YZ & XMy<XZ
//	<- 	!moveTo(XMy,YZ,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ<XO & YZ<YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy>YZ & XMy>(XZ+SF) 
//	<- 	!moveTo(XMy,YZ+1,avoid). 
///* ABORE RIGHT */ 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ>XO & YZ<YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy>YZ & XMy>XZ 
//	<- 	!moveTo(XMy,YZ,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ>XO & YZ<YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy>(YZ+SF) & XMy<XZ
//	<- 	!moveTo(XZ,YMy,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ>XO & YZ<YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy>YZ & XMy<(XZ+SF)
//	<- 	!moveTo(XMy,YZ+1,avoid). 
///* BELOW LEFT */
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & YZ>YO & /* approach from below to deliver below left | centred | right  */ 
//		position(XMy,YMy) & YMy>YZ & not(XMy == XZ)
//	<- 	!moveTo(XZ,YMy,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ<XO & YZ>YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy<(YZ+SF) & XMy>XZ 
//	<- 	!moveTo(XZ,YMy,avoid).
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ<XO & YZ>YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy<YZ & XMy<XZ
//	<- 	!moveTo(XMy,YZ,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ<XO & YZ>YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy<YZ & XMy>(XZ+SF) 
//	<- 	!moveTo(XMy,YZ+1,avoid). 
///* BELOW RIGHT */
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ>XO & YZ>YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy<YZ & XMy>XZ 
//	<- 	!moveTo(XMy,YZ,avoid).
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ>XO & YZ>YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy<(YZ+SF) & XMy<XZ
//	<- 	!moveTo(XZ,YMy,avoid). 
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ>XO & YZ>YO & safe_distance(SF) & 
//		position(XMy,YMy) & YMy<YZ & XMy<(XZ+SF)
//	<- 	!moveTo(XMy,YZ+1,avoid). 
//	
///* CENTRED */
//+!moveTo(XZ,YZ,delivery): helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,_) & XZ==XO & YZ<YO & /* approach from above to deliver above left | centred | right  */ 
//		position(XMy,YMy) & not(XMy==XZ)
//	<- 	!moveTo(XMy,YZ,avoid). 
//		

		
/* Otherwise - same for all */
/* 0 BLOCKS */		
/* WITHOUT obstacles  */
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1))  <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0))  <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) <- !move(w).

+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy < XDes & not(obstacle_at(1,0))  <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy > XDes & not(obstacle_at(-1,0)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy < XDes & not(obstacle_at(1,0))  <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy > XDes & not(obstacle_at(-1,0)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy < YDes & not(obstacle_at(0,1))  <- !move(s). 
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy > YDes & not(obstacle_at(0,-1)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy < YDes & not(obstacle_at(0,1))  <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy > YDes & not(obstacle_at(0,-1)) <- !move(n).

/* WITH obstacles */
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) <- clear(0,-1).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) <- clear(-1,0).

+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy < YDes & obstacle_cannot_clear_at(0,1)  <- !move(w).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & YMy > YDes & obstacle_cannot_clear_at(0,-1) <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy < XDes & obstacle_cannot_clear_at(1,0)  <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),0) & position(XMy,YMy) & XMy > XDes & obstacle_cannot_clear_at(-1,0) <- !move(n).



/* 1 BLOCK */		
/* WITHOUT obstacles  */
/* going to S (0,1) */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1)) <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,2)) <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1)) & not(obstacle_at(-1,1)) <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy < YDes & not(obstacle_at(0,1)) & not(obstacle_at(-1,1)) <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy < YDes & not(obstacle_at(0,1)) & not(obstacle_at(1,1))  <- !move(s).
/* going to N (0,-1) */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-2)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  & YMy > YDes & not(obstacle_at(0,-1)) & not(obstacle_at(-1,-1)) <-!move(n).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) & YMy > YDes & not(obstacle_at(0,-1)) & not(obstacle_at(1,-1))  <-!move(n).
/* going to E (1,0) */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0)) <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy < XDes & not(obstacle_at(2,0)) <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy < XDes & not(obstacle_at(1,0)) & not(obstacle_at(1,-1)) <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy < XDes & not(obstacle_at(1,0)) & not(obstacle_at(1,1))  <- !move(e).
/* going to W (-1,0) */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-2,0)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  & XMy > XDes & not(obstacle_at(-1,0)) & not(obstacle_at(-1,-1)) <- !move(w).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) & XMy > XDes & not(obstacle_at(-1,0)) & not(obstacle_at(-1,1))  <- !move(w).

/* WITH obstacles */
/* block back */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy < YDes & thing(0,1,obstacle,_)  <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy > YDes & thing(0,-1,obstacle,_) <- clear(0,-1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy < XDes & thing(1,0,obstacle,_)  <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy > XDes & thing(-1,0,obstacle,_) <- clear(-1,0).
//+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy < YDes & obstacle_cannot_clear_at(0,1)  <- !move(w).
//+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy > YDes & obstacle_cannot_clear_at(0,-1) <- !move(e).
//+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy < XDes & obstacle_cannot_clear_at(1,0)  <- !move(s).
//+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy > XDes & obstacle_cannot_clear_at(-1,0) <- !move(n).

/*  block right  */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & thing(-1,1,obstacle,_)  & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1))  & not(obstacle_at(0,-1)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & thing(1,-1,obstacle,_)  & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) & not(obstacle_at(0,1))  <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & thing(-1,-1,obstacle,_) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) & not(obstacle_at(1,0))  <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & thing(1,1,obstacle,_)   & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0))  & not(obstacle_at(-1,0)) <- rotate(cw).

+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & thing(-1,1,obstacle,_)  & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1))  & thing(0,-1,obstacle,_) <- clear(0,-1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & thing(1,-1,obstacle,_)  & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) & thing(0,1,obstacle,_)  <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & thing(-1,-1,obstacle,_) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) & thing(1,0,obstacle,_)  <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & thing(1,1,obstacle,_)   & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0))  & thing(-1,0,obstacle,_) <- clear(-1,0).

/* block left  */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & thing(-1,-1,obstacle,_) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) & not(obstacle_at(0,1))  <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & thing(1,1,obstacle,_)   & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1))  & not(obstacle_at(0,-1)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & thing(1,-1,obstacle,_)  & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0))  & not(obstacle_at(-1,0)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & thing(-1,1,obstacle,_)  & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) & not(obstacle_at(1,0))  <- rotate(ccw).

+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & thing(-1,-1,obstacle,_) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) & thing(0,1,obstacle,_)  <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & thing(1,1,obstacle,_)   & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1))  & thing(0,-1,obstacle,_) <- clear(0,-1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & thing(1,-1,obstacle,_)  & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0))  & thing(-1,0,obstacle,_) <- clear(-1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & thing(-1,1,obstacle,_)  & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) & thing(1,0,obstacle,_)  <- clear(1,0).


/* block front and no obstacles */

+!moveTo(XDes,YDes,_): .count(has_block(_),1) & attached(0,1)  & position(XMy,YMy) & YMy < YDes & not(obstacle_at(-1,0)) <- rotate(cw).

/* block front -> rotate to side there is no obstacle */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy < YDes & not(obstacle_at(-1,0)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy < YDes & not(obstacle_at(1,0))  <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(1,0))  <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(-1,0)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy < XDes & not(obstacle_at(0,1))  <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy < XDes & not(obstacle_at(0,-1)) <- rotate(ccw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(0,-1)) <- rotate(cw).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(0,1))  <- rotate(ccw).

/* block front and cannot rotate -> clear to rotate CW */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,1,_)  & position(XMy,YMy) & YMy < YDes & thing(-1,0,obstacle,_) <- clear(-1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(0,-1,_) & position(XMy,YMy) & YMy > YDes & thing(1,0,obstacle,_)  <- clear(1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(1,0,_)  & position(XMy,YMy) & XMy < XDes & thing(0,1,obstacle,_)  <- clear(0,1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & has_block_at(-1,0,_) & position(XMy,YMy) & XMy > XDes & thing(0,-1,obstacle,_) <- clear(0,-1).



/* TEMPORARY */
/* blocks by side, just try to move */
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & YMy < YDes & not(obstacle_at(0,1))  <- !move(s).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & YMy > YDes & not(obstacle_at(0,-1)) <- !move(n).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & XMy < XDes & not(obstacle_at(1,0))  <- !move(e).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & XMy > XDes & not(obstacle_at(-1,0)) <- !move(w).

+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & YMy < YDes & obstacle_at(0,1)  <- !moveTo(XDes-1,YDes,avoid).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & YMy > YDes & obstacle_at(0,-1) <- !moveTo(XDes+1,YDes,avoid).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & XMy < XDes & obstacle_at(1,0)  <- !moveTo(XDes,YDes-1,avoid).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & XMy > XDes & obstacle_at(-1,0) <- !moveTo(XDes,YDes+1,avoid).

+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & YMy < YDes  <-  clear(0,1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & YMy > YDes  <-  clear(0,-1).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & XMy < XDes  <-  clear(1,0).
+!moveTo(XDes,YDes,_): .count(has_block(_),1) & position(XMy,YMy) & XMy > XDes  <-  clear(-1,0).

+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes <-  !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes <-  !move(n).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes <-  !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes <-  !move(w).

+!moveTo(XDes,YDes,_): position(XDes,YDes) <- true.

/* Temporary above */

// (TO DO) do something when arrive at position 


/* MOVE action*/
+!move(X) <- move(X).
//+!move(s) <- move(s).
//+!move(n) <- move(n).
//+!move(e) <- move(e).
//+!move(w) <- move(w).

/* update memory about position */
+!update_position(s): position(X,Y) <- -position(X,Y); +position(X,Y+1).
+!update_position(n): position(X,Y) <- -position(X,Y); +position(X,Y-1).
+!update_position(e): position(X,Y) <- -position(X,Y); +position(X+1,Y).
+!update_position(w): position(X,Y) <- -position(X,Y); +position(X-1,Y).



