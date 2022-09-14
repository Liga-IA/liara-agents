
/* MAIN CODE */

//norm(n2,129,169,[requirement(role,default,10,"")],3)[entity(agentA1),source(percept)]


/* MODULES (it imports code from these files) */
{ include("move.asl") }     		// movement strategy
{ include("memory_updates.asl") }     		// movement strategy
{ include("strategy.asl") }  		// decision making strategy
{ include("collectblocks.asl") }  	// collect blocks strategy
{ include("adoptrole.asl") }  		// adopt role strategy
{ include("exploration.asl") }  	// exploration strategy
{ include("complete_task.asl") }  	// complete tasks strategy
{ include("synchronism.asl") }  	// synchronism strategy
{ include("task_delivery_organization.asl") }  	// task organization strategy
{ include("connect_and_deliver.asl") }  	// connect and deliver strategy
{ include("after_event.asl") }  	// after event strategy
{ include("change_round.asl") }  	// change round strategy



