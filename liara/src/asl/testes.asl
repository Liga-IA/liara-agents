// Agent testes in project liara
/* WITHOUT obstacles or blocks */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  & .count(attached(_,_),0) <-  !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) & .count(attached(_,_),0) <-  !move(n).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  & .count(attached(_,_),0) <-  !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) & .count(attached(_,_),0) <-  !move(w).

/* Without obstacles and 1 block at back */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  & .count(attached(_,_),1) & attached(0,-1) <-  !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) & .count(attached(_,_),1) & attached(0,1)  <-  !move(n).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  & .count(attached(_,_),1) & attached(-1,0) <-  !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) & .count(attached(_,_),1) & attached(1,0)  <-  !move(w).
/* Without obstacles and 1 block at right */
/* no obstacles to the block */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  & .count(attached(_,_),1) & attached(-1,0) & not(thing(-1,1,obstacle,_))  <- !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) & .count(attached(_,_),1) & attached(1,0)  & not(thing(1,-1,obstacle,_))  <- !move(n).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  & .count(attached(_,_),1) & attached(0,1)  & not(thing(1,1,obstacle,_))   <- !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) & .count(attached(_,_),1) & attached(0,-1) & not(thing(-1,-1,obstacle,_)) <- !move(w).
/* with obstacles to the block */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  & .count(attached(_,_),1) & attached(-1,0) & thing(-1,1,obstacle,_)  <- rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) & .count(attached(_,_),1) & attached(1,0)  & thing(1,-1,obstacle,_)  <- rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  & .count(attached(_,_),1) & attached(0,1)  & thing(1,1,obstacle,_)   <- rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) & .count(attached(_,_),1) & attached(0,-1) & thing(-1,-1,obstacle,_) <- rotate(cw).
/* Without obstacles and 1 block at left */
/* no obstacles to the block */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  & .count(attached(_,_),1) & attached(1,0)  & not(thing(1,1,obstacle,_))   <- !move(s).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) & .count(attached(_,_),1) & attached(-1,0) & not(thing(-1,-1,obstacle,_)) <- !move(n).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  & .count(attached(_,_),1) & attached(0,-1) & not(thing(1,-1,obstacle,_))  <- !move(e).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) & .count(attached(_,_),1) & attached(0,1)  & not(thing(-1,1,obstacle,_))  <- !move(w).
/* obstacles to the block */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & not(thing(0,1,obstacle,_))  & .count(attached(_,_),1) & attached(1,0)  & thing(1,1,obstacle,_)   <- rotate(ccw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & not(thing(0,-1,obstacle,_)) & .count(attached(_,_),1) & attached(-1,0) & thing(-1,-1,obstacle,_) <- rotate(ccw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & not(thing(1,0,obstacle,_))  & .count(attached(_,_),1) & attached(0,-1) & thing(1,-1,obstacle,_)  <- rotate(ccw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & not(thing(-1,0,obstacle,_)) & .count(attached(_,_),1) & attached(0,1)  & thing(-1,1,obstacle,_)  <- rotate(ccw).

/* keeps the block back to move */
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & .count(attached(_,_),1) & attached(-1,0) & thing(-1,1,obstacle,_) <-  rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy < YDes & .count(attached(_,_),1) & attached(1,0) & thing(1,1,obstacle,_) <-   rotate(ccw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & .count(attached(_,_),1) & attached(1,0) & thing(1,-1,obstacle,_) <-   rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & YMy > YDes & .count(attached(_,_),1) & attached(-1,0) & thing(-1,-1,obstacle,_) <-  rotate(ccw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & .count(attached(_,_),1) & attached(0,1) & thing(1,1,obstacle,_) <-   rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy < XDes & .count(attached(_,_),1) & attached(0,-1) & thing(1,-1,obstacle,_) <-  rotate(ccw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & .count(attached(_,_),1) & attached(0,-1) & thing(-1,-1,obstacle,_) <-  rotate(cw).
+!moveTo(XDes,YDes,_): position(XMy,YMy) & XMy > XDes & .count(attached(_,_),1) & attached(0,1) & thing(-1,1,obstacle,_)<-   rotate(ccw).