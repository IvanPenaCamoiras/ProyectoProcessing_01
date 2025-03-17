//Variables de muros
PVector[] muros;
float ancho_muro, alto_muro;
float WallDamage = 0.5;
int muros_num;

//Variables de Jugador
float pj_vel = 5;
float pj_size = 20;
PVector pj_pos;

float alfa = 0.1;
boolean colision = false;

boolean using_mouse = false;

public enum Item_type {VEL, FREEZE, INMORTAL, CURE, DAMAGE, VENOM, SLOW, COUNT};

public class Item {
  boolean powerUp;
  boolean isTaken = false;
  Item_type type;
  PVector pos;
}

public class Pnj {
  boolean isDead = false;
    float vel;
    float size;
    float dist;
    float hp;
    PVector pos = new PVector(random(0, width), random (0, height));
}

public class Timer {
  boolean isStarted = false;
  float finalTime = 0;
  
  void StartTimer(float time)
  {
    if (!isStarted)
    {
       finalTime = millis() + time;
       isStarted = true;
    }  
  }
  boolean CheckTimer()
  {
    if (millis() >= finalTime)
    {
      isStarted = false;
      return true;
    }
    else
    {
      return false;
    }
  }
}

public class Enemy {
 PVector pos;
 float vel;
 float size;
 boolean isDead;
 float detectionDistance;
 Enemy_type type;
}

Pnj pnj1 = new Pnj();
Pnj pnj2 = new Pnj();

// Variables de Enemy
Enemy[] enemies;
float spawnEnemiesTime;

// Variables de Item
Item[] items;
int items_num;
int items_size = 10;

void setup() {
  // Creamos la ventana
  size(600, 600);
  
  //Inicializamos las variables de los PNJ
  pnj1.vel = 0.5;
  pnj1.size = 20.0;
  pnj1.dist = 25.0;
  pnj1.hp = 100;
  pnj2.vel = 0.2;
  pnj2.size = 15.0;
  pnj2.dist = 75.0;
  pnj2.hp = 100;
  
  // Inicializamos los muros
  // El número de muros es un número aleatorio entre 6 y 20
  muros_num = (int)random(6, 20);
  
  // Inicializamos el array y la mida de los muros, también es aleatoria.
  muros = new PVector[muros_num];
  ancho_muro = width / random(5, 20);
  alto_muro = height / random(20, 50);
  
  // Inicializamos la posición de los muros
   for (int i=0; i<muros_num; i++) {
    muros[i] = new PVector(0, 0); // Reservamos cuantas coords por elemento
    muros[i].x = random(0, width - ancho_muro); // Coord X punto inferior izquierdo
    muros[i].y = random(0, height - alto_muro); // Coord Y punto inferior izquierdo
   }
  
  //Inicializamos los ítems
  //El número de ítems es un número aleatorio
  items_num = (int)random(6, 12);
  
  //Inicializamos el array de ítems
  items = new Item[items_num];
  
  for(int i = 0; i < items_num; i++)
  {
    items[i] = new Item();
    items[i].pos = new PVector(0,0);
    do 
    {
      items[i].pos.x = random(0, width - items_size);
      items[i].pos.y = random(0, height - items_size);
    } while (!FreeSpot(items[i].pos, i));
    if (i < 3)
    {
      items[i].powerUp = true;
      items[i].type = (enum)random(0, 3);
    }
    else
    {
      items[i].powerUp = false;
      items[i].type = (enum)random(4, COUNT);
    }
  }
  
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
    if (key == 'd' || key == 'D') {
      pj_pos.x += pj_vel;
    }
    if (key == 'a' || key == 'A') {
      pj_pos.x -= pj_vel;
    }
    if (key == 's' || key == 'S') {
      pj_pos.y += pj_vel;
    }
    colision = WallColision(pj_pos, pj_size);
  }
  if (using_mouse)
  {
    pj_pos.y = mouseY;
    pj_pos.x = mouseX;
  }
  // Si la distancia entre el pj y el pnj1 es mayor a 
  // la distancia establecida en el pnj1_dist que acerque
  if (DistanceBetween(pnj1.pos, pj_pos) > pnj1.dist)
  {
    pnj1.pos.x = MoveTowards(pnj1.pos.x, pj_pos.x, pnj1.vel);
    pnj1.pos.y = MoveTowards(pnj1.pos.y, pj_pos.y, pnj1.vel);
  }
   if (DistanceBetween(pnj2.pos, pj_pos) > pnj2.dist)
  {
    pnj2.pos.x = MoveTowards(pnj2.pos.x, pj_pos.x, pnj2.vel);
    pnj2.pos.y = MoveTowards(pnj2.pos.y, pj_pos.y, pnj2.vel);
  }
  DrawInstances();
    if (WallColision(pnj2.pos, pnj2.size))
  {
      GetDamage(pnj2, WallDamage);
  }
}

void KeyPressed()
{
   if (key == 'g' || key == 'G')
    {
      if (using_mouse)
      {
        using_mouse = false;
      }
      else
      {
        using_mouse = true;
      }
    }
}

float DistanceBetween(PVector point1, PVector point2)
{
  return sqrt(pow(point2.x - point1.x, 2.0) + pow(point2.y - point1.y, 2.0));
}

float MoveTowards(float thisPoint, float finalPoint, float speed)
{
  float move = (1.0 - speed * alfa) * thisPoint + speed * alfa * finalPoint;
  return move;
}

float MoveAway(float thisPoint, float finalPoint, float speed)
{
  float move = (1.0 + speed * alfa) * thisPoint - speed * alfa * finalPoint;
  return move;
}

Boolean FreeSpot(PVector pos, int index)
{
  pos = new PVector(0,0);
  if (WallColision(pos, items_size))
  {
    return false;
  }
  for(int i = 0; i < index; i++)
  {
    if (DistanceBetween(pos, items[i].pos) >= items_size)
    {
      continue;
    }
    else
    {
      return false;
    }
  }
  return true;
}

Boolean WallColision(PVector p, float p_size)
{
    float p_max_x = p.x + p_size / 2;
    float p_max_y = p.y + p_size / 2;
    float p_min_x = p.x - p_size / 2;
    float p_min_y = p.y - p_size / 2;
    
    // Caja 1 con la 2: xmax1 > xmin2 - Caja 2 con la 1: xmax2 > xmin1
    // Caja 1 con la 2: ymax1 > ymin2 - Caja 2 con la 1: ymax2 > ymin1
    // Suponemos que el PJ es 1 y el muro es 2
    //if (((PJ_max.x > muros[i].x)||(coord_max_muro.x > PJ_min.x))
    //&&
    //((PJ_max.y > muros[i].y)||(coord_max_muro.y > PJ_min.y))) {
      
    for(int i = 0; i < muros_num; i++)
    {
      PVector max_muro = new PVector(0,0);

      max_muro.x = muros[i].x + ancho_muro;
      max_muro.y = muros[i].y + alto_muro;

      if (p_max_x < max_muro.x - ancho_muro || p_max_y < max_muro.y - alto_muro || max_muro.x < p_min_x || max_muro.y < p_min_y) 
      {
        continue;
      }
      else
      {
        return true;
      }
    }
    return false;
 }

void DrawInstances()
{
   //Pintar al PJ
   if (colision)
   {
    fill(0, 255, 0);
   }
   else
   {
     fill(255, 0, 0);
   }
    ellipse(pj_pos.x, pj_pos.y, pj_size, pj_size);
    
    //Pintar al PNJ1 i 2
    if (!pnj1.isDead)
    {
      fill(0, 0, 255);
      ellipse(pnj1.pos.x, pnj1.pos.y, pnj1.size, pnj1.size);
    }
    if (!pnj2.isDead)
    {
      fill(255, 0, 0);
      ellipse(pnj2.pos.x, pnj2.pos.y, pnj2.size, pnj2.size);
    }
     
    rectMode(CENTER);
     for(int i = 0; i < muros_num; i++)
     {
        fill(255, 0, 0);
        rect(muros[i].x + ancho_muro/2.0, muros[i].y + alto_muro/2.0, ancho_muro, alto_muro);
     }
     
      for(int i = 0; i < items_num; i++)
     {
        fill(0, 255, 0);
        ellipse(items[i].pos.x, items[i].pos.y, items_size, items_size);
     }
}

void GetDamage(Pnj pnj, float damage)
{
  pnj.hp -= damage;
  if (pnj.hp <= 0)
  {
    pnj.isDead = true;
  }
}
