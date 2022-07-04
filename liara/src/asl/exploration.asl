

// in case it fails the previous move action, it change direction
+!explore_next(w) <- !explore(s).
+!explore_next(e) <- !explore(n).
+!explore_next(n) <- !explore(w).
+!explore_next(s) <- !explore(e).

/* Exploration Strategy without blocks */
+!explore(w): not(thing(-2,0,obstacle,_)) <- move(w).
+!explore(w): not(thing(0,-2,obstacle,_)) <- -+goingDirection(n); move(n).
+!explore(w): not(thing(0,2,obstacle,_)) <- -+goingDirection(s); move(s).
+!explore(w) <- -+goingDirection(e); move(e).

+!explore(e): not(thing(2,0,obstacle,_)) <- move(e).
+!explore(e): not(thing(0,2,obstacle,_)) <- -+goingDirection(s); move(s).
+!explore(e): not(thing(0,-2,obstacle,_)) <- -+goingDirection(n); move(n).
+!explore(e) <- -+goingDirection(w); move(w).

+!explore(s): not(thing(0,2,obstacle,_)) <- move(s).
+!explore(s): not(thing(2,0,obstacle,_)) <- -+goingDirection(e); move(e).
+!explore(s): not(thing(-2,0,obstacle,_)) <- -+goingDirection(w); move(w).
+!explore(s) <- -+goingDirection(n); move(n).

+!explore(n): not(thing(0,-2,obstacle,_)) <- move(n).
+!explore(n): not(thing(2,0,obstacle,_)) <- -+goingDirection(e); move(e).
+!explore(n): not(thing(-2,0,obstacle,_)) <- -+goingDirection(w); move(w).
+!explore(n) <- -+goingDirection(s); move(s).

/* Exploration Strategy with blocks (or keep only one block and rotate it back, or keep more and check obstacles for blocks */

// - to do 