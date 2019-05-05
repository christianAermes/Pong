class Enemy {
  PVector pos;
  Enemy() {
    float x = paddleWidth;
    float y = random(paddleSize*0.5 + scoreDisplayHeight, height - paddleSize*0.5);
    pos = new PVector(x, y);
  }
  
  void show() {
    fill(255);
    stroke(255);
    rectMode(CENTER);
    rect(pos.x, pos.y, paddleWidth, paddleSize);
  }
  
  void move() {
    if (puck.vel.x < 0) {
      // calculate the predicted arrival point of the puck based on its current direction of motion
      // move toward this destination
      PVector dir = new PVector(puck.vel.x, puck.vel.y);
      dir.normalize();
      float n = (pos.x+paddleWidth/2 - puck.pos.x-puck.r)/dir.x;
      
      float destY = PVector.add(puck.pos, dir.mult(n)).y;
      PVector dest = new PVector(paddleWidth, destY);

      PVector vel = PVector.sub(dest, pos);
      pos.add(vel.limit(dy/2));
      
      // limit the position
      if (pos.y - paddleSize/2 <= scoreDisplayHeight) {
        pos.y = paddleSize/2 + scoreDisplayHeight;
      }
      if (pos.y + paddleSize/2 >= height) {
        pos.y = height-paddleSize/2;
      }
    }
  }
}
