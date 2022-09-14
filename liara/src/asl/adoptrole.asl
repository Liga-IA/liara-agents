
/* This module implements strategies to adopt roles */

 // inferir papel a partir dos papeis do servidor baseado nas ações que cada papel executa 
 // my_role(Role):- role(Role,[ações]) & lista_ações_eu_executo & lista é sublista completa de ações
 
my_role(worker).

+!adoptRole(XDes,YDes): my_role(Role) <- adopt(Role).	