
/* This module implements strategies to adopt roles */

my_role(worker).

+!adoptRole(XDes,YDes): my_role(Role) <- +role(Role)[source(memory)]; adopt(Role).	