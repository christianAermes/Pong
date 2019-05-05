class Puck {
  PVector pos, vel;
  float r;
  float speed;
  float rndAngle;
  Puck() {
    rndAngle = 3*PI/180; // on impact with player, enemy, or a border, the moving direction changes by a random amount
    float angle = random(-PI/4, PI/4); // initialize puck with a random moving direction

    float xPos = random(1)<0.5? width - 2*paddleWidth : 2*paddleWidth;
    pos = new PVector(xPos, height/2 + scoreDisplayHeight/2);
    float sign = xPos > width/2? -1 : 1;
    
    vel = PVector.fromAngle(angle);
    r = 10;
    speed = puckSpeed;
    vel.mult(speed*sign);
  }
  
  void move() {
    // check if the puck hit the upper or lower border
    // limit the puck position and reflect the puck
    if (pos.y-r <= scoreDisplayHeight) {
      pos.y = r + scoreDisplayHeight;
      vel.y *= -1;
      float dA = random(-rndAngle, rndAngle);
      vel.rotate(dA);
    }
    if (pos.y+r >= height) {
      pos.y = height-r;
      vel.y *= -1;
      float dA = random(-rndAngle, rndAngle);
      vel.rotate(dA);
    }
    pos.add(vel);
    
  }
  
  void hitPlayer() {
    // check if the puck hit the player
    // if so, invert the velocity
    // also, the direction of velocity vector is rotated by a random amount
    if (pos.x+r >= player.pos.x-paddleWidth/2) {
      if (pos.y <= player.pos.y+paddleSize/2 && pos.y >= player.pos.y-paddleSize) {
        pos.x = player.pos.x-paddleWidth/2-r;
        vel.x *= -1;
        float dA = random(-rndAngle, rndAngle);
        vel.rotate(dA);
      }
    }
  }
  
  void hitEnemy() {
    // check if the puck hit the enemy
    // if so, invert the velocity
    // also, the direction of velocity vector is rotated by a random amount
    if (pos.x-r <= enemy.pos.x+paddleWidth/2) {
      if (pos.y <= enemy.pos.y+paddleSize/2 && pos.y >= enemy.pos.y-paddleSize/2) {
        pos.x = enemy.pos.x+paddleWidth/2+r;
        vel.x *= -1;
        float dA = random(-rndAngle, rndAngle);
        vel.rotate(dA);
      }
    }
  }
  
  boolean hitLR() {
    // check if the puck went past the player or the enemy
    // if so, increase the respective score
    if (pos.x-r <= paddleWidth) {
      scorePlayer++;
    }
    if (pos.x+r >= width - paddleWidth) {
      scoreEnemy++;
    }
    if (pos.x-r <= paddleWidth || pos.x+r >= width - paddleWidth) {
      return true;
    }
    return false;
  }
  
  void show() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, 2*r, 2*r);
  }
}
