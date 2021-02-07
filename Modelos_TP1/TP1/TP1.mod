/*********************************************
 * OPL 20.1.0.0 Model
 * Author: jowi
 * Creation Date: Feb 4, 2021 at 5:45:19 PM
 *********************************************/
/*Variables relacionadas a la cantidad de empleados
por dia en cada tarea y los que no trabajan*/
dvar int Elrm;
dvar int Exrm;
dvar int Elpp;
dvar int Empp;
dvar int Expp;
dvar int Elco;
dvar int Emco;
dvar int Exco;
dvar int Elnt;
dvar int Emnt;
dvar int Exnt;

/*Variables relacionadas a la eficiencia de cada 
tarea*/
dvar int ElrmEf;
dvar int ExrmEf;
dvar int ElppEf;
dvar int EmppEf;
dvar int ExppEf;
dvar int ElcoEf;
dvar int EmcoEf;
dvar int ExcoEf;

/*Variables que indican la cantidad de empleados que
trabajan de la categoria Cj*/

int Njl[1..4][1..3];
/*Variables que indican si el empleado i trabaja en el dia
d en alguna de las tareas o si no trabaja*/
//Lunes recibir mercaderia
dvar boolean Yilm[1..20][1..3];
//Miercoles recibir mercaderia 
dvar boolean Yixm[1..20];
//Lunes preparar pedidos
dvar boolean Yilpp[1..20];
//Martes preparar pedidos
dvar boolean Yimpp[1..20];
//Miercoles preparar pedidos
dvar boolean Yixpp[1..20];
//Lunes cargar ofertas
dvar boolean Yilco[1..20];
//Martes cargar ofertas
dvar boolean Yimco[1..20];
//Miercoles cargar ofertas
dvar boolean Yixco[1..20];
//Lunes no trabaja
dvar boolean Yilnt[1..20];
//Martes no trabaja
dvar boolean Yimnt[1..20];
//Miercoles no trabaja
dvar boolean Yixnt[1..20];

/*Variables que indican si el empleado i
trabaja lunes, martes, miercoes*/
//Lunes
dvar boolean Yil[1..20];
//Martes 
dvar boolean Yim[1..20];
//Miercoles
dvar boolean Yix[1..20];

/*Variables que indican si un empleado
es eficiente en la tarea que realiza el 
dia que trabaja*/
//Lunes reponer mercaderia
dvar boolean YiEfLm[1..20];
//Miercoles reponer mercaderia
dvar boolean YiEfXm[1..20];
//Lunes preparar pedidos
dvar boolean YiEfLpp[1..20];
//Martes preparar pedidos
dvar boolean YiEfMpp[1..20];
//Miercoles preparar pedidos
dvar boolean YiEfXpp[1..20];
//Lunes cargar ofertas
dvar boolean YiEfLco[1..20];
//Martes cargar ofertas
dvar boolean YiEfMco[1..20];
//Miercoles cargar ofertas
dvar boolean YiEfXco[1..20];

/*Variables que indican si el empleado es
eficiente y ademas trabajara en dicha tarea*/
//Lunes recibir mercaderia
dvar boolean YiTEfLm[1..20];
//Miercoles recibir mercaderia
dvar boolean YiTEfXm[1..20];
//Lunes preparar pedido
dvar boolean YiTEfLpp[1..20];
//Martes preparar pedido
dvar boolean YiTEfMpp[1..20];
//Miercoles preparar pedido
dvar boolean YiTEfXpp[1..20];
//Lunes cargar oferta
dvar boolean YiTEfLco[1..20];
//Martes cargar oferta
dvar boolean YiTEfMco[1..20];
//Miercoles cargar oferta
dvar boolean YiTEfXco[1..20];

range N = 1..20;

maximize
  50 * Exnt;
  
subject to {
  /*Restricciones en la cantidad de empleados 
  de cada dia*/
  Elrm + Elpp + Elco + Elnt == 20; //Lunes
  Empp + Emco + Emnt == 20; //Martes
  Exrm + Expp + Exco + Exnt == 20; //Miercoles
  
  /*Restricciones en la cantidad de empleados 
  que trabajan en cada tarea cada dia*/
  //Lunes recibiendo mercaderia
  Elrm == sum (i in N) (sum (i in N) Yilm[i][1]);
  //Lunes preparando pedidos
  //Elpp == sum (i in N) (Yilm[i]);
  //Elpp == sum (i in Yi);
  //Lunes cargado oferta
  //Elco == ;
  //Martes preparando pedidos
  //Empp == ;
  //Martes cargado oferta
  //Emco == ;
  //Miercoles recibiendo mercaderia
  //Exrm == ;
  //Miercoles preparando pedidos 
  //Expp == ;
  //Miercoles cargado oferta 
  //Exco == ;

  /*Ecuaciones sobre la cantidad de empleados 
  que trabajan de forma eficiente en cada tarea 
  cada día*/
}



