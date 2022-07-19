// Agent complete_task in project liara

/* Initial beliefs and rules */

has_block(Type):- thing(X,Y,block,Type) & attached(X,Y).

/* Initial goals */
	
+!deliver_task(TName,Deadline,Reward,[req(0,1,Type)])[_]: goalZone(X,Y)[source(memory)] 
	<- 	-+movingToGoalZone(X,Y);
		!moveTo(X,Y,goalzone).