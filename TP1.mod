{string} EMPLEADOS = ...;
int COSTOREEMP[EMPLEADOS] = ...;
{string} TAREAS = ...;
{string} TAREAS_CON_NO_TRABAJA = ...;
int EFICIENCIA[TAREAS] = ...;
{string} DIAS = ...;
{string} CATEGORIAS = ...;
{string} EMPLEADOS_CATEGORIA_1 = ...;
{string} EMPLEADOS_CATEGORIA_2 = ...;
{string} EMPLEADOS_CATEGORIA_3 = ...;
{string} EMPLEADOS_CATEGORIA_4 = ...;


/*Variables relacionadas a la cantidad de empleados
por dia en cada tarea y los que no trabajan
-- Las tareas son numeradas desde 1 a 4 en el siguiente orden ["m","pp","co","nt"]
-- Los dias martes no hay tarea mercaderia*/
dvar int Edt[DIAS][TAREAS_CON_NO_TRABAJA];

/*Variables relacionadas a la eficiencia de cada 
tarea*/
dvar int EdtEf[DIAS][TAREAS];

/*Variables que indican la cantidad de empleados que
trabajan de la categoria Cj*/
dvar int Ncd[CATEGORIAS][DIAS];

/*Variables que indican si el empleado i trabaja en el dia
d en alguna de las tareas o si no trabaja
-- Las tareas son numeradas desde 1 a 4 en el siguiente orden ["m","pp","co","nt"]
-- Los dias martes no hay tarea mercaderia*/
dvar boolean Yidt[EMPLEADOS][DIAS][TAREAS_CON_NO_TRABAJA];

/*Variables que indican si el empleado i
trabaja lunes, martes, miercoes*/
dvar boolean Yid[EMPLEADOS][DIAS];

/*Variables que indican si un empleado
es eficiente en la tarea que realiza el 
dia que trabaja*/
dvar boolean YiEfdt[EMPLEADOS][DIAS][TAREAS];

/*Variables que indican si el empleado es
eficiente y ademas trabajara en dicha tarea*/
dvar boolean YiTEfdt[EMPLEADOS][DIAS][TAREAS];

/* Funcional */
minimize
  sum (empleado in EMPLEADOS) ((sum(d in DIAS) Yid[empleado][d]) * COSTOREEMP[empleado]); 
  
subject to {
  forall(empleado in EMPLEADOS){
    Yidt[empleado]["M"]["RM"] == 0;
    YiTEfdt[empleado]["M"]["RM"] == 0;
    YiEfdt[empleado]["M"]["RM"] == 0;  
  }
  Edt["M"]["RM"] == 0;
  EdtEf["M"]["RM"] == 0;
  
    /*Restricciones en la cantidad de empleados 
  de cada dia*/
  forall (d in DIAS) {
    sum (t in TAREAS_CON_NO_TRABAJA) (Edt[d][t]) == 20;
  }
  
  /*Restricciones en la cantidad de empleados 
  que trabajan en cada tarea cada dia*/
  forall (d in DIAS) {
    forall (t in TAREAS) {
       Edt[d][t] == sum (empleado in EMPLEADOS) (Yidt[empleado][d][t]);
    }
  }
  
  /*Restricciones sobre la cantidad de empleados 
  que trabajan de forma eficiente en cada tarea 
  cada día*/
  forall (d in DIAS) {
    forall (t in TAREAS) {
      EdtEf[d][t] == sum(empleado in EMPLEADOS) (YiTEfdt[empleado][d][t]);
    }
  }
  
  /*Restricciones sobre que cada empleado 
    puede trabajar en una sola tarea por dia
  */
  forall(empleado in EMPLEADOS){
    forall(dia in DIAS){
        sum(tarea in TAREAS_CON_NO_TRABAJA) Yidt[empleado][dia][tarea] == 1;
    }
  }

  /*Restriccion sobre la eficiencia de 
  los empleados en cada tarea*/
  /* Dia lunes */
  forall(empleado in EMPLEADOS){
      forall(tarea in TAREAS) {
       YiEfdt[empleado]["L"][tarea] == 1; 
      }
  }
  /* Dia Martes */
  forall(empleado in EMPLEADOS){
      YiEfdt[empleado]["M"]["PP"] == 1 - Yidt[empleado]["L"]["PP"];
      YiEfdt[empleado]["M"]["CO"] == 1 - Yidt[empleado]["L"]["CO"]; 
  }
  
  /* Dia miercoles*/
  forall(empleado in EMPLEADOS){
      forall(tarea in TAREAS) {
        YiEfdt[empleado]["X"][tarea] == 1 - Yidt[empleado]["M"][tarea]; 
      }
    YiEfdt[empleado]["X"]["RM"] == 1;
   }
  
  /** Restriccion de problemas de conflicto entre personas*/
  /* Empleado 12 y 20*/
  forall(tarea in TAREAS){
    forall(dia in DIAS){
      Yidt["Ariel Arregui"][dia][tarea] + Yidt["Tamara Tapia"][dia][tarea] <= 1;
    }
  }
  /* Empleado 3 y 6*/
  forall(tarea in TAREAS){
    forall(dia in DIAS){
      Yidt["Carlos Colautti"][dia][tarea] + Yidt["Fabiana Fernández"][dia][tarea] <= 1;
    }
  }
  /* Empleado 9 y 10*/
  forall(tarea in TAREAS){
    forall(dia in DIAS){
      Yidt["Ignacio Ibarra"][dia][tarea] + Yidt["Julieta Jerez"][dia][tarea] <= 1;
    }
  }
  
  /*Restricciones en las producciones
  minimas de cada dia*/
  Edt["L"]["RM"] * 100 * 8 + EdtEf["L"]["RM"] * 100 * 0.1 * 8 >= 2200; //Lunes reponer mercaderia
  Edt["X"]["RM"] * 100 * 8 + EdtEf["X"]["RM"] * 100 * 0.1 * 8 >= 2600; //Miercoles reponer mercaderia
  
  Edt["L"]["PP"] * 20 * 8 + EdtEf["L"]["PP"] * 20 * 0.1 * 8 >= 1000; //Lunes preparar pedidos
  Edt["M"]["PP"] * 20 * 8 + EdtEf["M"]["PP"] * 20 * 0.1 * 8 >= 1200; //Martes preparar pedidos
  Edt["X"]["PP"] * 20 * 8 + EdtEf["X"]["PP"] * 20 * 0.1 * 8 >= 1112; //Miercoles preparar pedidos
  
  Edt["L"]["CO"] * 60 * 8 + EdtEf["L"]["CO"] * 60 * 0.1 * 8 >= 1624; //Lunes cargar oferta
  Edt["M"]["CO"] * 60 * 8 + EdtEf["M"]["CO"] * 60 * 0.1 * 8 >= 3200; //Martes cargar oferta
  Edt["X"]["CO"] * 60 * 8 + EdtEf["X"]["CO"] * 60 * 0.1 * 8 >= 1664; //Miercoles cargar oferta  

  /*Restricciones en relacion a las
  categorias*/
  forall (c in CATEGORIAS) {
    forall (d in DIAS) {      
      Ncd[c][d] >= 1;
    }
  }
  
  Ncd["1"]["L"] == sum (i in EMPLEADOS_CATEGORIA_1) (Yid[i]["L"]);
  Ncd["2"]["L"] == sum (i in EMPLEADOS_CATEGORIA_2) (Yid[i]["L"]);
  Ncd["3"]["L"] == sum (i in EMPLEADOS_CATEGORIA_3) (Yid[i]["L"]);
  Ncd["4"]["L"] == sum (i in EMPLEADOS_CATEGORIA_4) (Yid[i]["L"]);
  
  Ncd["1"]["M"] == sum (i in EMPLEADOS_CATEGORIA_1) (Yid[i]["M"]);
  Ncd["2"]["M"] == sum (i in EMPLEADOS_CATEGORIA_2) (Yid[i]["M"]);
  Ncd["3"]["M"] == sum (i in EMPLEADOS_CATEGORIA_3) (Yid[i]["M"]);
  Ncd["4"]["M"] == sum (i in EMPLEADOS_CATEGORIA_4) (Yid[i]["M"]);
  
  Ncd["1"]["X"] == sum (i in EMPLEADOS_CATEGORIA_1) (Yid[i]["X"]);
  Ncd["2"]["X"] == sum (i in EMPLEADOS_CATEGORIA_2) (Yid[i]["X"]);
  Ncd["3"]["X"] == sum (i in EMPLEADOS_CATEGORIA_3) (Yid[i]["X"]);
  Ncd["4"]["X"] == sum (i in EMPLEADOS_CATEGORIA_4) (Yid[i]["X"]);
  
  /*Restricciones en la eficiencia de un empleado y si
  trabaja o no en esa tarea*/
  forall(tarea in TAREAS){
    forall(dia in DIAS){
      forall(empleado in EMPLEADOS){
        2 * YiTEfdt[empleado][dia][tarea] <= YiEfdt[empleado][dia][tarea] + Yidt[empleado][dia][tarea];
        YiEfdt[empleado][dia][tarea] + Yidt[empleado][dia][tarea] <= 1 + YiTEfdt[empleado][dia][tarea];
      }
    }
  }
  
  /*Relacion entre la tarea trabajada y si trabaja
  o no*/
  forall(empleado in EMPLEADOS){
    forall(dia in DIAS){
        sum(tarea in TAREAS) Yidt[empleado][dia][tarea] == Yid[empleado][dia];
    }
  }
}

