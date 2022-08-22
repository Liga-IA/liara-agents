// Agent after_event in project liara

/* Initial beliefs and rules */

/* Initial goals */

+!collect_blocks_after_event: thing(0,1,block_)  <- attach(s).
+!collect_blocks_after_event: thing(0,-1,block_) <- attach(n).
+!collect_blocks_after_event: thing(1,0,block_)  <- attach(e).
+!collect_blocks_after_event: thing(-1,0,block_) <- attach(w).

+!collect_blocks_after_event <- true.