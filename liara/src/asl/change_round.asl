
/* Implements the change of rounds */

// goalZone(X,Y)[source(memory)].
// thing(X,Y,dispenser,P)[source(memory)].
// found_mate(XMate,YMate,XMy,YMy,S)[source(memory)].
// mate_filter(Name,X,Y)[source(memory)]. 

// inform_position(dispenser,XT,YT,Parameters)[list(List),source(TeamMate)].
// cost(Distance,BlockType,TName)[source(TeamMate)].


// cannot_deliver(TName).
// movingToGoalZone(_,_).
// movingToDispenser(_,_,_).
// movingToRoleZone(_,_).
// carrying_block.
// collectingBlocks(X,Y,P).
// waiting_away(Ag,TName,XMy,YMy+4,S+4).
// submitting(_,_). 
// helping(_,TName,MyBlock,_,_,_,_,_).
// requested_colaboration(TName,XZ,YZ,_,_,BlockType).



/* Reset these ones */
//position(0,0). 		    // initial position
//goingDirection(w). 	    // going to W at begin

//my_role(worker). // manter?


+!change_round 
	<- 	.abolish(_[source(memory)]); // exclude everything with the source memory
		.abolish(inform_position(dispenser,_,_,_)[list(_),source(_)]);
		.abolish(cost(_,_,_)[source(_)]);
		.abolish(cannot_deliver(_));
		-movingToGoalZone(_,_);
		-movingToDispenser(_,_,_);
		-movingToRoleZone(_,_);
		-carrying_block;
		-collectingBlocks(_,_,_);
		-waiting_away(_,_,_,_,_);
		-submitting(_,_);
		.abolish(helping(_,_,_,_,_,_,_,_));
		.abolish(requested_colaboration(_,_,_,_,_,_));
		-position(_,_);
		+position(0,0);
		-goingDirection(_);
		+goingDirection(w);
		.