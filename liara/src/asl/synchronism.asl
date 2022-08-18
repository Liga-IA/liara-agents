// Agent synchronism in project liara

team_group(List):- .findall(Name,mate_filter(Name,_,_)[_],List).

/* This module implements synchronism of agents (absolute position and things at grid) */

+!update_mate(S,XMy,YMy): name(Name) & team(Team)
	<- 	for(thing(XMate,YMate,entity,Team) & not( XMate==0 | YMate==0 ) ){
			+found_mate(XMate,YMate,XMy,YMy,S)[source(memory)]; 
			.broadcast(achieve,add_mate(Name,XMate,YMate,XMy,YMy,S));
		}.
	
+!clear_old_found_mate(S) 
	<- 	for(found_mate(XMate,YMate,X,Y,SO)[source(memory)] & SO+4 < S ){
			-found_mate(XMate,YMate,X,Y,SO)[source(memory)]
		}.

+!add_mate(Name,XO,YO,XOA,YOA,S): not(name(Name)) & 
		found_mate(XF,YF,XMA,YMA,S)[_] & (XF+XO) == 0 & (YF+YO) == 0 & 
		not(mate_filter(Name,_,_)[source(memory)])
	<- 	-found_mate(XF,YF,XMA,YMA,S)[_];
		+mate_filter(Name,((XF+XMA)-XOA),((YF+YMA)-YOA))[source(memory)].

+!add_mate(Name,XO,YO,XOA,YOA,S) <- true.

/* RECEIVEING INFORMATION from others agents in the group */

/* about DISPENSERS */
+inform_position(dispenser,XT,YT,Parameters)[source(TeamMate)]: mate_filter(TeamMate,XFilter,YFilter) 
	<- 	+thing(XT+XFilter,YT+YFilter,dispenser,Parameters)[source(memory)];
		-inform_position(dispenser,XT,YT,Parameters)[source(TeamMate)].

+inform_position(dispenser,XT,YT,Parameters)[source(TeamMate)]: not(mate_filter(TeamMate,XFilter,YFilter))
	<- 	-inform_position(dispenser,XT,YT,Parameters)[source(TeamMate)]. // ask for the filter, then can sync
	
/* about GoalZones */
+inform_position(goalzone,XZ,YZ)[source(TeamMate)]: mate_filter(TeamMate,XFilter,YFilter) 
	<-	+goalZone(XZ+XFilter,YZ+YFilter)[source(memory)];
		-inform_position(goalzone,XZ,YZ)[source(TeamMate)].
		
+inform_position(goalzone,XZ,YZ)[source(TeamMate)]: not(mate_filter(TeamMate,XFilter,YFilter)) 
	<-	-inform_position(goalzone,XZ,YZ)[source(TeamMate)].

/* about RoleZones */	
+inform_position(rolezone,XZ,YZ)[source(TeamMate)]: mate_filter(TeamMate,XFilter,YFilter) 
	<- 	+roleZone(XZ+XFilter,YZ+YFilter)[source(memory)];
		-inform_position(rolezone,XZ,YZ)[source(TeamMate)].

+inform_position(rolezone,XZ,YZ)[source(TeamMate)]: not(mate_filter(TeamMate,XFilter,YFilter))
	<- 	-inform_position(rolezone,XZ,YZ)[source(TeamMate)].