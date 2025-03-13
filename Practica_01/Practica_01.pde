
float pj_vel = 5;
float pj_size = 10;
float pnj1_size = 20;
float pnj2_size = 15;
float pnj1_dist = 25;
float pnj2_dist = 75;
float pnj1_vel = 0.5;
float pnj2_vel = 0.2;
float alfa = 0.1;
PVector pj_pos;
PVector pnj1_pos;
PVector pnj2_pos;

void setup()
{
  // Creamos la ventana
  size(600, 600);
 
  // Inicializamos la posicion del jugador en medio de la ventana
  pj_pos = new PVector(width / 2.0, height / 2.0);
  pnj1_pos = new PVector(random(0, width), random (0, height));
  pnj2_pos = new PVector(random(0, width), random (0, height));
}

void draw()
{
  background(255);
  // KEY PRESSED
  
  // Movimiento del PJ (WASD)
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      pj_pos.y -= pj_vel;
    }
    if (key == 'd' || key == 'D') {
      pj_pos.x += pj_vel;
    }
    if (key == 'a' || key == 'A') {
      pj_pos.x -= pj_vel;
    }
    if (key == 's' || key == 'S') {
      pj_pos.y += pj_vel;
    }
  }
  // Si la distancia entre el pj y el pnj1 es mayor a 
  // la distancia establecida en el pnj1_dist que acerque
  if (sqrt(pow(pnj1_pos.x - pj_pos.x, 2.0) + pow(pnj1_pos.y - pj_pos.y, 2.0)) > pnj1_dist)
  {
    pnj1_pos.x = (1.0 - alfa) * pnj1_pos.x + alfa * pj_pos.x;
    pnj1_pos.y = (1.0 - alfa) * pnj1_pos.y + alfa * pj_pos.y;
  }
   if (sqrt(pow(pnj2_pos.x - pj_pos.x, 2.0) + pow(pnj2_pos.y - pj_pos.y, 2.0)) > pnj2_dist)
  {
    pnj2_pos.x = (1.0 - alfa) * pnj2_pos.x + alfa * pj_pos.x;
    pnj2_pos.y = (1.0 - alfa) * pnj2_pos.y + alfa * pj_pos.y;
  }
  
    //Pintar al PJ
    fill(0, 255, 0);
    ellipse(pj_pos.x, pj_pos.y, pj_size, pj_size);
    
    //Pintar al PNJ1 i 2
     fill(0, 0, 255);
    ellipse(pnj1_pos.x, pnj1_pos.y, pnj1_size, pnj1_size);
     fill(255, 0, 0);
    ellipse(pnj2_pos.x, pnj2_pos.y, pnj2_size, pnj2_size);
}
