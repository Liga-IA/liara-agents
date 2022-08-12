

/* This file implements the strategies for collecting blocks  */

// (to do)
// - include verification for checking if it already has a block at that position (when using 2 or more blocks)
// - include a better strategy: rotate and get another block (keep going with 2 blocks attached) 
// (maybe front and Back, so that facilitates movement)

+!collectBlocks(XDes,YDes,Blocks): position(XDes-1,YDes) & not(requested(XDes,YDes,Blocks))
	<-	request(e);
		+requested(XDes,YDes,Blocks).

+!collectBlocks(XDes,YDes,Blocks): position(XDes+1,YDes) & not(requested(XDes,YDes,Blocks))
	<-	request(w);
		+requested(XDes,YDes,Blocks).
		
+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes-1) & not(requested(XDes,YDes,Blocks))
	<-	request(s);
		+requested(XDes,YDes,Blocks).
		
+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes+1) & not(requested(XDes,YDes,Blocks))
	<-	request(n);
		+requested(XDes,YDes,Blocks).
		
	
+!collectBlocks(XDes,YDes,Blocks): position(XDes-1,YDes) & requested(XDes,YDes,Blocks)
	<-	-requested(XDes,YDes,Blocks);
		attach(e);
		-collectingBlocks(XDes,YDes,Blocks).
	
+!collectBlocks(XDes,YDes,Blocks): position(XDes+1,YDes) & requested(XDes,YDes,Blocks)
	<-	-requested(XDes,YDes,Blocks);
		attach(w);
		-collectingBlocks(XDes,YDes,Blocks).
	
+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes-1) & requested(XDes,YDes,Blocks)
	<-	-requested(XDes,YDes,Blocks);
		attach(s);
		-collectingBlocks(XDes,YDes,Blocks).

+!collectBlocks(XDes,YDes,Blocks): position(XDes,YDes+1) & requested(XDes,YDes,Blocks)
	<-	-requested(XDes,YDes,Blocks);
		attach(n);
		-collectingBlocks(XDes,YDes,Blocks).