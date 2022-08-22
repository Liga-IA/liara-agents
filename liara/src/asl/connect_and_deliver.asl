// Agent connect_and_deliver in project liara

/* Initial beliefs and rules */

/* Initial goals */

/* agent1 is on (3,3) and agent2 is on (3,7). agent1 has a block attached on (3,4) and one attached to that block on (3,5). 
 * agent2 has a block attached on (3,6). Both agents want to connect their attached blocks, namely those 
 * on (3,5) (of agent1) and (3,6) (attached to agent2). Then, agent1 has to perform connect(agent2,0,2), 
 * while agent2 has to perform connect(agent1,0,-1) in the same step. If both actions succeed, the blocks will be connected 
 * and still attached to both agents.
 */

/* the delivery is below the agent */
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(0,1,Type) & team(Team) & thing(XO-XMy,YO-YMy,entity,Team) <- connect(Ag,0,1).
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(0,1,Type) <- skip.

+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(-1,0,Type) & thing(0,1,obstacle,_) <- clear(0,1).	
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(-1,0,Type) & not(obstacle_at(0,1)) <- rotate(ccw).
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(1,0,Type)  & thing(0,1,obstacle,_) <- clear(0,1).
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(1,0,Type)  & not(obstacle_at(0,1)) <- rotate(cw).
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(0,-1,Type) & thing(1,0,obstacle,_)  & not(obstacle_at(-1,0)) <- rotate(ccw).
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) & not(obstacle_at(1,0))  <- rotate(cw).	
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(0,-1,Type) & thing(-1,0,obstacle,_) & thing(1,0,obstacle,_) <- clear(1,0).
+!connect(Ag,XMy,YMy,XO,YO): YMy < YO & has_block_at(0,-1,Type) & not(obstacle_at(1,0)) & not(obstacle_at(-1,0)) <- rotate(cw).

/* the delivery is above the agent */
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(0,-1,Type) & team(Team) & thing(XO-XMy,YO-YMy,entity,Team) <- connect(Ag,0,-1).				 
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(0,-1,Type) <- skip.	

+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(-1,0,Type) & thing(0,-1,obstacle,_) <- clear(0,-1).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(-1,0,Type) & not(obstacle_at(0,-1)) <- rotate(cw).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(1,0,Type)  & thing(0,-1,obstacle,_) <- clear(0,-1).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(1,0,Type)  & not(obstacle_at(0,-1)) <- rotate(ccw).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(0,1,Type)  & thing(1,0,obstacle,_)  & not(obstacle_at(-1,0)) <- rotate(cw).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) & not(obstacle_at(1,0))  <- rotate(ccw).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(0,1,Type)  & thing(-1,0,obstacle,_) & thing(1,0,obstacle,_)  <- clear(1,0).
+!connect(Ag,XMy,YMy,XO,YO): YMy > YO & has_block_at(0,1,Type)  & not(obstacle_at(-1,0)) & not(obstacle_at(1,0)) <- rotate(cw).

// last case just rotate CCW -> helps agents coming
+!connect(Ag,XMy,YMy,XO,YO)<- rotate(ccw).

//+!connect(Ag,XMy,YMy,XO,YO): helping(Ag,_,_,_,_,_,_,_) <- -helping(Ag,_,_,_,_,_,_,_); !continue. //temporary ( bad )

//task(task13,271,40,[req(-1,1,b0),req(0,1,b1)])[entity(agentA1),source(percept)]   (-1X) B - B - N
//task(task11,269,40,[req(0,1,b1),req(0,2,b0)])[entity(agentA1),source(percept)]    (+1Y) N - B - N 
//task(task10,240,40,[req(0,1,b1),req(1,1,b1)])[entity(agentA1),source(percept)]    (+1X) N - B - B