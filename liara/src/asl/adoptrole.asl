
/* This module implements strategies to adopt roles */

 // inferir papel a partir dos papeis do servidor baseado nas a��es que cada papel executa 
 // my_role(Role):- role(Role,[a��es]) & lista_a��es_eu_executo & lista � sublista completa de a��es
 
my_role(worker).

+!adoptRole(XDes,YDes): my_role(Role) <- adopt(Role).	