// Agent complete_task in project liara

/* Initial beliefs and rules */

has_block(Type):- thing(X,Y,block,Type) & attached(X,Y) & (math.abs(X) + math.abs(Y)) == 1.
has_block_at(XDel,YDel,Type) :- thing(XDel,YDel,block,Type) & attached(XDel,YDel) & (math.abs(XDel) + math.abs(YDel)) == 1.

/* Initial goals */

/* Simple task (1 block) */
/* In case the block is at correct position - DELIVER */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(XDel,YDel,Type)
	<- 	-movingToGoalZone(_,_);
		!submit_task(TName).

/* In case the block is not at correct position - ROTATE (CW - clockwise | or | CCW - counterclockwise) */
/* In case cannot rotate because obstacles, clear the obstacles */

+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & thing(0,1,obstacle,_)      <- clear(0,1).	
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & not(thing(0,1,obstacle,_)) <- rotate(ccw).
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & thing(0,1,obstacle,_)      <- clear(0,1).	
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & not(thing(0,1,obstacle,_)) <- rotate(cw).
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & thing(1,0,obstacle,_)  & not(thing(-1,0,obstacle,_)) <- rotate(ccw).	
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) & not(thing(1,0,obstacle,_))  <- rotate(cw).	
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) & thing(1,0,obstacle,_)       <- clear(1,0).	

+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & thing(0,-1,obstacle,_)      <- clear(0,-1).	
+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & not(thing(0,-1,obstacle,_)) <- rotate(cw).
+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & thing(0,-1,obstacle,_)      <- clear(0,-1).	
+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & not(thing(0,-1,obstacle,_)) <- rotate(ccw).
+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & thing(1,0,obstacle,_)  & not(thing(-1,0,obstacle,_)) <- rotate(cw).	
+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) & not(thing(1,0,obstacle,_))  <- rotate(ccw).	
+!deliver_task(TName,Deadline,Reward,[req(0,-1,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) & thing(1,0,obstacle,_)       <- clear(1,0).	

+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_)      <- clear(-1,0).	
+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & not(thing(-1,0,obstacle,_)) <- rotate(ccw).
+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_)      <- clear(-1,0).	
+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & not(thing(-1,0,obstacle,_)) <- rotate(cw).
+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & thing(0,-1,obstacle,_)  & not(thing(0,1,obstacle,_)) <- rotate(cw).	
+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & thing(0,1,obstacle,_) & not(thing(0,-1,obstacle,_))  <- rotate(ccw).	
+!deliver_task(TName,Deadline,Reward,[req(-1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(1,0,Type)  & thing(0,1,obstacle,_) & thing(0,-1,obstacle,_)       <- clear(0,1).	

+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & thing(1,0,obstacle,_)      <- clear(1,0).	
+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,-1,Type) & not(thing(1,0,obstacle,_)) <- rotate(cw).
+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & thing(1,0,obstacle,_)      <- clear(1,0).	
+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(0,1,Type)  & not(thing(1,0,obstacle,_)) <- rotate(ccw).
+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & thing(0,-1,obstacle,_)  & not(thing(0,1,obstacle,_)) <- rotate(ccw).	
+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & thing(0,1,obstacle,_) & not(thing(0,-1,obstacle,_))  <- rotate(cw).	
+!deliver_task(TName,Deadline,Reward,[req(1,0,Type)])[_]: position(X,Y) & goalZone(X,Y) & has_block_at(-1,0,Type) & thing(0,1,obstacle,_) & thing(0,-1,obstacle,_)       <- clear(0,-1).	

/* OLD */
//+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(-1,0) & thing(0,-1,obstacle,_) <- 	clear(0,-1).	
//+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(0,1) & thing(-1,0,obstacle,_)  <- 	clear(-1,0).
//+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(1,0) & thing(0,1,obstacle,_)   <- 	clear(0,1).
//+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) & attached(0,-1) & thing(1,0,obstacle,_) 	<- 	clear(1,0).
	
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: position(X,Y) & goalZone(X,Y) <- rotate(cw).


/* in case it is not at goalZone - MOVE */
+!deliver_task(TName,Deadline,Reward,[req(XDel,YDel,Type)])[_]: goalZone(X,Y)[source(memory)] // (TO DO) get the closer one
	<- 	-movingToGoalZone(_,_);
		+movingToGoalZone(X,Y)
		!moveTo(X,Y,goalzone).
		
+!submit_task(TName) <- submit(TName).