
float pj_vel = 5;
float pj_size = 10;
PVector pj_pos;

void setup()
{
  // Creamos la ventana
  size(600, 600);
 
  // Inicializamos la posicion del jugador en medio de la ventana
  pj_pos = new PVector(width / 2.0, height / 2.0);
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
    else if (key == 'd' || key == 'D') {
      pj_pos.x += pj_vel;
    }
    else if (key == 'a' || key == 'A') {
      pj_pos.x -= pj_vel; 
    }
    else if (key == 's' || key == 'S') {
      pj_pos.y += pj_vel;
    }
  }  
    //Pintar al PJ
    fill(0, 255, 0);
    ellipse(pj_pos.x, pj_pos.y, pj_size, pj_size);
}
