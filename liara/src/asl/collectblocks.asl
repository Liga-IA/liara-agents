

/* This file implements the strategies for collecting blocks  */

// (to do) (later)
// - include verification for checking if it already has a block at that position (when using 2 or more blocks)
// - include a better strategy: rotate and get another block (keep going with 2 blocks attached) 
// (maybe front and Back, so that facilitates movement)

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
	

