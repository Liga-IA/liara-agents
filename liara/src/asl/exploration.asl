/* This module implements EXPLORATION strategies */

has_block_at(w):- position(X,Y) & thing(X-1,Y,block,Type) & attached(X-1,Y).
has_block_at(e):- position(X,Y) & thing(X+1,Y,block,Type) & attached(X+1,Y).
has_block_at(s):- position(X,Y) & thing(X,Y+1,block,Type) & attached(X,Y+1).
has_block_at(n):- position(X,Y) & thing(X,Y-1,block,Type) & attached(X,Y-1).

/* in case it fails the previous move action, it change direction */
+!change_direction(w) <-  -goingDirection(_); +goingDirection(s).
+!change_direction(e) <-  -goingDirection(_); +goingDirection(n).
+!change_direction(n) <-  -goingDirection(_); +goingDirection(w).
+!change_direction(s) <-  -goingDirection(_); +goingDirection(e).


/* Exploration Strategy without blocks */
+!explore(w): position(XMy,YMy) & not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_)) <- !moveTo(XMy-1,YMy,exploration).
+!explore(w): position(XMy,YMy) & not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- -goingDirection(_); +goingDirection(s); !moveTo(XMy,YMy+1,exploration).
+!explore(w): position(XMy,YMy) & not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_)) <- -goingDirection(_); +goingDirection(n); !moveTo(XMy,YMy-1,exploration).
+!explore(w) <- clear(-1,0).

+!explore(e): position(XMy,YMy) & not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))   <- !moveTo(XMy+1,YMy,exploration).
+!explore(e): position(XMy,YMy) & not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- -goingDirection(_); +goingDirection(s); !moveTo(XMy,YMy+1,exploration).
+!explore(e): position(XMy,YMy) & not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_)) <- -goingDirection(_); +goingDirection(n); !moveTo(XMy,YMy-1,exploration).
+!explore(e) <- clear(1,0).

+!explore(s): position(XMy,YMy) & not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- !moveTo(XMy,YMy+1,exploration).
+!explore(s): position(XMy,YMy) & not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_)) <- -goingDirection(_); +goingDirection(w); !moveTo(XMy-1,YMy,exploration).
+!explore(s): position(XMy,YMy) & not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))   <- -goingDirection(_); +goingDirection(e); !moveTo(XMy+1,YMy,exploration).
+!explore(s) <- clear(0,1).

+!explore(n): position(XMy,YMy) & not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_))  <-!moveTo(XMy,YMy-1,exploration).
+!explore(n): position(XMy,YMy) & not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_))  <- -goingDirection(_); +goingDirection(w); !moveTo(XMy-1,YMy,exploration).
+!explore(n): position(XMy,YMy) & not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))    <- -goingDirection(_); +goingDirection(e); !moveTo(XMy+1,YMy,exploration).
+!explore(n) <- clear(0,-1).



/* OLD */
//+!explore(w): not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_)) <- !move(w).
//+!explore(w): not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- -goingDirection(_); +goingDirection(s); !move(s).
//+!explore(w): not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_)) <- -goingDirection(_); +goingDirection(n); !move(n).
//+!explore(w) <- clear(-1,0).
//
//+!explore(e): not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))   <- !move(e).
//+!explore(e): not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- -goingDirection(_); +goingDirection(s); !move(s).
//+!explore(e): not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_)) <- -goingDirection(_); +goingDirection(n); !move(n).
//+!explore(e) <- clear(1,0).
//
//+!explore(s): not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- !move(s).
//+!explore(s): not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_)) <- -goingDirection(_); +goingDirection(w); !move(w).
//+!explore(s): not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))   <- -goingDirection(_); +goingDirection(e); !move(e).
//+!explore(s) <- clear(0,1).
//
//+!explore(n): not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_))  <- !move(n).
//+!explore(n): not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_))  <- -goingDirection(_); +goingDirection(w); !move(w).
//+!explore(n): not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))    <- -goingDirection(_); +goingDirection(e); !move(e).
//+!explore(n) <- clear(0,-1).

/* Exploration Strategy with blocks (keep at most 2 blocks, one in front (or back) and another at right/left
 * then it requires only check 1/2 spaces front and 2 spaces side
 * 
 *  ( TO DO )
 */

// - to do 