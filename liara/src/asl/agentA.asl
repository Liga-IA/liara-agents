
/* MAIN CODE */

	
+actionID(X) : true <-
	.print("Determining my action.", X).
	//!doSomething.

+thing(XThing,YThing,dispenser,Parameters)[entity(_),source(percept)]: position(XMy,YMy)
	<- 	.print("Perceived a Thing, named ",dispenser," at position (",XThing,",",YThing,"). with parameters: ",Parameters,
			  ". Which is (",XMy+XThing,",",YMy+YThing,") considering my absolute position (",XMy,",",YMy,")"
		      );
	+thing(XMy+XThing,YMy+YThing,dispenser,Parameters)[source(memory)].

+roleZone(XZone,YZone)[entity(_),source(percept)]: position(XMy,YMy)
	<- 	.print("Perceived a RoleZone at position (",XZone,",",YZone,"). with parameters: ",Parameters,
				". Which is (",XMy+XZone,",",YMy+YZone,") considering my absolute position (",XMy,",",YMy,")"
			  );
	+roleZone(XMy+XZone,YMy+YZone)[source(memory)].


//+task(TName,394,10,[req(0,1,b0)])[entity(agentA1),source(percept)]

//norm(n2,129,169,[requirement(role,default,10,"")],3)[entity(agentA1),source(percept)]


/* MODULES (import code from those files) */
{ include("move.asl") }     		// movement strategy
{ include("strategy.asl") }  		// decision making strategy
{ include("collectblocks.asl") }  	// collect blocks strategy
{ include("adoptrole.asl") }  		// adopt role strategy
{ include("exploration.asl") }  		// adopt role strategy