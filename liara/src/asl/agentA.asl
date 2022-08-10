
/* MAIN CODE */


//+thing(XThing,YThing,dispenser,Parameters)[entity(Myname),source(percept)]: expected_position(XMy,YMy) & not(lastActionResult(random_failure)[_] & lastAction(move)[_])
//	<- 	+thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)].
//+thing(XThing,YThing,dispenser,Parameters)[entity(Myname),source(percept)]: expected_position(XMy,YMy) & not(lastActionResult(failed_path)[_] & lastAction(move)[_])
//	<- 	+thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)].	
//
//+roleZone(XZone,YZone)[entity(Myname),source(percept)]: expected_position(XMy,YMy) & not(lastActionResult(random_failure)[_] & lastAction(move)[_]) 
//	& not(roleZone(Xr,Yr)[source(memory)] & (Xr-XMy < XZone | Yr-YMy < YZone ))
//	<- 	+roleZone(XMy+XZone,YMy+YZone)[source(memory)].
//+roleZone(XZone,YZone)[entity(Myname),source(percept)]: expected_position(XMy,YMy) & not(lastActionResult(failed_path)[_] & lastAction(move)[_])
//	& not(roleZone(Xr,Yr)[source(memory)] & (Xr-XMy < XZone | Yr-YMy < YZone ))
//	<- 	+roleZone(XMy+XZone,YMy+YZone)[source(memory)].
//	
//+goalZone(XZone,YZone)[entity(Myname),source(percept)]: expected_position(XMy,YMy) & not(lastActionResult(random_failure)[_] & lastAction(move)[_])
//	& not(goalZone(Xr,Yr)[source(memory)] & (Xr-XMy < XZone | Yr-YMy < YZone ))
//	<- 	+goalZone(XMy+XZone,YMy+YZone)[source(memory)].
//+goalZone(XZone,YZone)[entity(Myname),source(percept)]: expected_position(XMy,YMy) & not(lastActionResult(failed_path)[_] & lastAction(move)[_])
//	& not(goalZone(Xr,Yr)[source(memory)] & (Xr-XMy < XZone | Yr-YMy < YZone ))
//	<- 	+goalZone(XMy+XZone,YMy+YZone)[source(memory)].

//+task(TName,394,10,[req(0,1,b0)])[entity(agentA1),source(percept)]

//norm(n2,129,169,[requirement(role,default,10,"")],3)[entity(agentA1),source(percept)]


/* MODULES (it imports code from these files) */
{ include("move.asl") }     		// movement strategy
{ include("memory_updates.asl") }     		// movement strategy
{ include("strategy.asl") }  		// decision making strategy
{ include("collectblocks.asl") }  	// collect blocks strategy
{ include("adoptrole.asl") }  		// adopt role strategy
{ include("exploration.asl") }  	// adopt role strategy
{ include("complete_task.asl") }  	// adopt role strategy