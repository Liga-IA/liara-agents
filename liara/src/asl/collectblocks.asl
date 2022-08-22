

/* This file implements the strategies for collecting blocks  */

// (to do) (later)
// - include verification for checking if it already has a block at that position (when using 2 or more blocks)
// - include a better strategy: rotate and get another block (keep going with 2 blocks attached) 
// (maybe front and Back, so that facilitates movement)

/* current version collect always at E (avoid two agents connecting the same block) */

+!collectBlocks(XDes,YDes,Blocks): position(XMy,YMy) & thing(XDes,YDes,dispenser,_)[source(memory)] & not(thing(XDes-XMy,YDes-YMy,dispenser,_)[entity(Myname),source(percept)]) <- -thing(XDes,YDes,dispenser,_)[source(memory)]; -collectingBlocks(_,_,_); !continue. // temporary to fix a issue

+!collectBlocks(XDes,YDes,Blocks): position(XDes-1,YDes) & thing(1,0,block,Blocks) 
	<-	attach(e).
	
+!collectBlocks(XDes,YDes,Blocks): position(XDes+1,YDes) & thing(-1,0,block,Blocks)
	<-	attach(w).
	
+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes-1) & thing(0,1,block,Blocks)
	<-	attach(s).

+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes+1) & thing(0,-1,block,Blocks)
	<-	attach(n).

+!collectBlocks(XDes,YDes,Blocks): position(XDes-1,YDes) & thing(XDes,YDes,dispenser,Blocks)
	<-	request(e).
	
+!collectBlocks(XDes,YDes,Blocks): position(XDes+1,YDes) & thing(XDes,YDes,dispenser,Blocks)
	<-	request(w).	
		
+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes-1) & thing(XDes,YDes,dispenser,Blocks)
	<- 	request(s).
		
+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes+1) & thing(XDes,YDes,dispenser,Blocks)
	<-	request(n).
	

