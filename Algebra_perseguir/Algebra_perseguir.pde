
// VARIABLES
float x_pnj1,y_pnj1,x_pnj2,y_pnj2,x_pj,y_pj;
float alfa;
float dist_pnj1 = 2.5, dist_pnj2 = 1.5;
// SETUP
void setup(){
  // Ventana
  size(400,400);
  alfa = 0.05; // 10 pasitos entre el PNJ y el PJ (alfa entre 0 y 1)
  x_pnj1=width/2.0;
  y_pnj1=height/2.0;
}
// DRAW
void draw(){
  // Empezamos borrando el fondo de la ventana
  background(255); // Blanco
  // PNJ persigue a PJ
  x_pj=mouseX;
  y_pj=mouseY;
  // Calculos
  // Ecuacion parametrica de la recta:
  // p(alfa)=PNJ+alfa*PJ --> p(alfa) = (1-alfa)*PNJ + alfa*PJ
  // PNJ1
  if (sqrt(pow(x_pnj1 - x_pj, 2.0) + pow(y_pnj1 - y_pj, 2.0)) > dist_pnj1)
  {
    x_pnj1 = (1.0 - alfa) * x_pnj1 + alfa * x_pj - dist_pnj1;
    y_pnj1 = (1.0 - alfa) * y_pnj1 + alfa * y_pj - dist_pnj1;
  }
  // PNJ2
    if (sqrt(pow(x_pnj2 - x_pj, 2.0) + pow(y_pnj2 - y_pj, 2.0)) > dist_pnj2)
  {
    x_pnj2 = (1.0 - 0.3 * alfa) * x_pnj1 + alfa * x_pj;
    y_pnj2 = (1.0 - 0.3 * alfa) * y_pnj1 + alfa * y_pj;
  }
  // Pintarlo
  // PNJ1
  fill(255,0,0);
  ellipse(x_pnj1,y_pnj1,width/20.0,height/20.0);
  // PNJ2
  fill(0,0,255);
  ellipse(x_pnj2,y_pnj2,width/20.0,height/20.0);
  // PJ
  fill(0,255,0);
  ellipse(x_pj,y_pj,width/20.0,height/20.0);
}
// FUNCIONES
