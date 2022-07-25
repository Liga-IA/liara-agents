/* This module implements EXPLORATION strategies */

has_block_at(w):- thing(X,Y,block,Type) & attached(X,Y) & position(X,Y+1).
has_block_at(e):- thing(X,Y,block,Type) & attached(X,Y) & position(X,Y-1).
has_block_at(s):- thing(X,Y,block,Type) & attached(X,Y) & position(X+1,Y).
has_block_at(n):- thing(X,Y,block,Type) & attached(X,Y) & position(X-1,Y).

/* in case it fails the previous move action, it change direction */
+!explore_next(w): position(X,Y) <- -position(X,Y); +position(X+1,Y); -goingDirection(_); +goingDirection(s); !explore(s).
+!explore_next(e): position(X,Y) <- -position(X,Y); +position(X-1,Y); -goingDirection(_); +goingDirection(n); !explore(n).
+!explore_next(n): position(X,Y) <- -position(X,Y); +position(X,Y+1); -goingDirection(_); +goingDirection(w); !explore(w).
+!explore_next(s): position(X,Y) <- -position(X,Y); +position(X,Y-1); -goingDirection(_); +goingDirection(e); !explore(e).

/* Exploration Strategy without blocks */
+!explore(w): not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_)) <- !move(w).
+!explore(w): not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_)) <- -goingDirection(_); +goingDirection(n); !move(n).
+!explore(w): not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- -goingDirection(_); +goingDirection(s); !move(s).
+!explore(w) <- -goingDirection(_); +goingDirection(e); !move(e).

+!explore(e): not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))   <- !move(e).
+!explore(e): not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- -goingDirection(_); +goingDirection(s); !move(s).
+!explore(e): not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_)) <- -goingDirection(_); +goingDirection(n); !move(n).
+!explore(e) <- -goingDirection(_); +goingDirection(w); !move(w).

+!explore(s): not(thing(0,1,obstacle,_)) & not(thing(0,1,entity,_))   <- !move(s).
+!explore(s): not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))   <- -goingDirection(_); +goingDirection(e); !move(e).
+!explore(s): not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_)) <- -goingDirection(_); +goingDirection(w); !move(w).
+!explore(s) <- -goingDirection(_); +goingDirection(n); !move(n).

+!explore(n): not(thing(0,-1,obstacle,_)) & not(thing(0,-1,entity,_))  <- !move(n).
+!explore(n): not(thing(1,0,obstacle,_)) & not(thing(1,0,entity,_))    <- -goingDirection(_); +goingDirection(e); !move(e).
+!explore(n): not(thing(-1,0,obstacle,_)) & not(thing(-1,0,entity,_))  <- -goingDirection(_); +goingDirection(w); !move(w).
+!explore(n) <- -goingDirection(_); +goingDirection(s); !move(s).

/* Exploration Strategy with blocks (keep at most 2 blocks, one in front (or back) and another at right/left
 * then it requires only check 1/2 spaces front and 2 spaces side
 * 
 *  ( TO DO )
 */

// - to do 