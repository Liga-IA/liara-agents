// Agent synchronism in project liara

team_group(List):- .findall(Name,mate_filter(Name,_,_)[_],List).

/* This module implements synchronism of agents (absolute position and things at grid) */

+!update_mate(S,XMy,YMy): name(Name)
	<- 	for(thing(XMate,YMate,entity,"A") & not( XMate==0 | YMate==0 ) ){
			+found_mate(XMate,YMate,XMy,YMy,S)[source(memory)]; 
			.broadcast(achieve,add_mate(Name,XMate,YMate,XMy,YMy,S));
		}
		!!clear_old_found_mate(S).
	
+!clear_old_found_mate(S) 
	<- 	for(found_mate(XMate,YMate,X,Y,S2)[_] & S2+2 < S ){
			-found_mate(XMate,YMate,X,Y,S2)[_]
		}.

+!add_mate(Name,XO,YO,XOA,YOA,S): not(name(Name)) & 
		found_mate(XF,YF,XMA,YMA,S)[_] & (XF+XO) == 0 & (YF+YO) == 0 & 
		not(mate_filter(Name,_,_)[source(memory)])
	<- 	.abolish(found_mate(XF,YF,XMA,YMA,S)[_]);
		+mate_filter(Name,((XF+XMA)-XOA),((YF+YMA)-YOA))[source(memory)].

+!add_mate(Name,XO,YO,XOA,YOA,S) <- true.

// thing(1,1,entity,"A")[entity(agentA2),source(percept)]
// thing(-1,-1,entity,"A")[entity(agentA3),source(percept)]

// thing(0,-3,entity,"A")[entity(agentA2),source(percept)]
// thing(0,3,entity,"A")[entity(agentA3),source(percept)]