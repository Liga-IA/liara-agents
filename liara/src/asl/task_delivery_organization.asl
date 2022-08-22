/* Task Delivery Organization strategy */

closest(goalZone,XZ,YZ):- position(XMy,YMy) & goalZone(XZ,YZ)[source(memory)] & not(goalZone(XOther,YOther)[source(memory)] &  ( math.abs(XOther-XMy)+math.abs(YOther-YMy)) < (math.abs(XZ-XMy)+math.abs(YZ-YMy)) ).
closest(roleZone,XZ,YZ):- position(XMy,YMy) & roleZone(XZ,YZ)[source(memory)] & not(roleZone(XOther,YOther)[source(memory)] &  ( math.abs(XOther-XMy)+math.abs(YOther-YMy)) < (math.abs(XZ-XMy)+math.abs(YZ-YMy)) ).
closest(dispenser,BlockType,XZ,YZ):- position(XMy,YMy) & thing(XZ,YZ,dispenser,BlockType)[source(memory)] & not(thing(XOther,YOther,dispenser,BlockType)[source(memory)] & ( math.abs(XOther-XMy)+math.abs(YOther-YMy)) < (math.abs(XZ-XMy)+math.abs(YZ-YMy)) ).

closest_teamMate(TeamMate,TName,BlockType):- cost(Distance,BlockType,TName)[source(TeamMate)] & not(cost(Distance2,BlockType,TName)[source(TeamMate2)] & Distance2 < Distance).

/* same type of blocks */
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type),req(XDel2,YDel2,Type)],List): name(Name) & .min(List,First) & (Firt<Name) 
	<- 	+cannot_deliver(TName);
		!moveTo(XDel1,YDel1,avoid).	
		
/* different type of blocks */
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type1) & math.abs(XDel1+YDel1)==1) & XDel1 < XDel2 <- !query_team(TName,Type2,List,e).
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type1) & math.abs(XDel1+YDel1)==1) & XDel1 > XDel2 <- !query_team(TName,Type2,List,w).
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type1) & math.abs(XDel1+YDel1)==1) & YDel1 < YDel2 <- !query_team(TName,Type2,List,s).
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type1) & math.abs(XDel1+YDel1)==1) & YDel1 > YDel2 <- !query_team(TName,Type2,List,n).

+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type2) & math.abs(XDel2+YDel2)==1) & XDel1 < XDel2 <- !query_team(TName,Type1,List,w).
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type2) & math.abs(XDel2+YDel2)==1) & XDel1 > XDel2 <- !query_team(TName,Type1,List,e).
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type2) & math.abs(XDel2+YDel2)==1) & YDel1 < YDel2 <- !query_team(TName,Type1,List,n).
+!organize_task_delivery(TName,[req(XDel1,YDel1,Type1),req(XDel2,YDel2,Type2)],List): (has_block(Type2) & math.abs(XDel2+YDel2)==1) & YDel1 > YDel2 <- !query_team(TName,Type1,List,s).

+!query_team(TName,BlockType,List,e): closest(goalZone,XMZ,YMZ) & name(Name) 
		<-  +requested_colaboration(TName,XMZ,YMZ,(XMZ+1),(YMZ+2),BlockType);
			.send(List,achieve,tell_distance(Name,TName,(XMZ+1),(YMZ+2),BlockType));
			!moveTo(XMZ,YMZ,avoid).

+!query_team(TName,BlockType,List,w): closest(goalZone,XMZ,YMZ) & name(Name) 
		<-  +requested_colaboration(TName,XMZ,YMZ,(XMZ-1),(YMZ+2),BlockType);
			.send(List,achieve,tell_distance(Name,TName,(XMZ-1),(YMZ+2),BlockType));
			!moveTo(XMZ,YMZ,avoid).
			
+!query_team(TName,BlockType,List,s): closest(goalZone,XMZ,YMZ) & name(Name) 
		<-  +requested_colaboration(TName,XMZ,YMZ,XMZ,(YMZ+3),BlockType);
			.send(List,achieve,tell_distance(Name,TName,XMZ,(YMZ+3),BlockType));
			!moveTo(XMZ,YMZ,avoid).
			
+!query_team(TName,BlockType,List,n): closest(goalZone,XMZ,YMZ) & name(Name) 
		<-  +requested_colaboration(TName,XMZ,YMZ,XMZ,(YMZ-3),BlockType);
			.send(List,achieve,tell_distance(Name,TName,XMZ,(YMZ-3),BlockType));
			!moveTo(XMZ,YMZ,avoid).

+!decide_collaborator(TName,XZ,YZ,BlockType): not(cost(Ag,BlockType,TName))
	<- 	+cannot_deliver(TName);
		-requested_colaboration(TName,_,_,_,_,BlockType);
		!moveTo(XZ,YZ,avoid).	
		
+!decide_collaborator(TName,XZ,YZ,BlockType): 
		requested_colaboration(TName,XZ,YZ,XO,YO,BlockType) & not(helping(_,_,_,_,_,_,_,_)) &
		has_block(MyBlock) & closest_teamMate(Ag,TName,BlockType) 
	<- 	+helping(Ag,TName,MyBlock,XZ,YZ,XO,YO,1);
		.send(Ag,tell,allocate_help(TName,BlockType,XO,YO,XZ,YZ)); 
		-requested_colaboration(TName,_,_,_,_,BlockType);
		-movingToGoalZone(_,_);
		!moveTo(XZ,YZ,avoid).
		
+!decide_collaborator(TName,XZ,YZ,BlockType)
	<- 	+cannot_deliver(TName);
		-requested_colaboration(TName,_,_,_,_,BlockType);
		!moveTo(XZ,YZ,avoid).	

+!tell_distance(TeamMate,TName,XZ,YZ,BlockType):
		not(name(TeamMate)) & has_block(BlockType) & name(Name) & not(helping(_,_,_,_,_,_,_,_)) & not(requested_colaboration(TName,_,_,_,_,BlockType)  & TeamMate < Name ) &
		mate_filter(TeamMate,XFilter,YFilter) & position(XMy,YMy) 
	<- 	.send(TeamMate,tell,cost((math.abs(XMy-(XZ+XFilter))+math.abs(YMy-(YZ+YFilter))),BlockType,TName)).
	
+!tell_distance(TeamMate,TName,XZ,YZ,BlockType) <- true.

//cancel allocation if got another before (or the longer one)

+allocate_help(TName,BlockType,XZ,YZ,XO,YO)[source(TeamMate)]: mate_filter(TeamMate,XFilter,YFilter)
	<- 	-movingToGoalZone(_,_);
		+helping(TeamMate,TName,BlockType,XZ+XFilter,YZ+YFilter,XO+XFilter,YO+YFilter,2);
		-allocate_help(TName,BlockType,XZ,YZ,XO,YO)[source(TeamMate)]; 
		!moveTo(XZ+XFilter,YZ+YFilter,avoid).

+cost(Distance,BlockType,TName)[source(TeamMate)]: task(TName,DeadLine,_,[req(XDel,YDel,Type)])[_] & step(Step) & Step-Deadline > (Distance+5) <- -cost(Distance,BlockType,TName)[source(TeamMate)].



//+!review_help: .count(helping(TeamMate,TName,BlockType,_,_,_,_,_),N) & N > 1 <- true.