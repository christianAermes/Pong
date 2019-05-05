Puck puck;
Player player;
Enemy enemy;

int scorePlayer = 0;
int scoreEnemy = 0;

float paddleSize = 100;
float paddleWidth = 20;

float dy = 5; // moving speed of the player. enemy moves with half the speed
float puckSpeed = 8;

boolean playerAI = !true; // let two AIs play against each other

float scoreDisplayHeight = 75;


void setup() {
  size(700, 475);
  puck = new Puck();
  player = new Player();
  enemy = new Enemy();
}


void draw() {
  background(0);
  
  textSize(42);
  fill(255); stroke(255); strokeWeight(1);
  textAlign(LEFT, CENTER);
  text(scoreEnemy, 2*paddleWidth, scoreDisplayHeight/2);
  textAlign(RIGHT, CENTER);
  text(scorePlayer, width-2*paddleWidth, scoreDisplayHeight/2);
  textAlign(CENTER, CENTER);
  text("-", width/2, scoreDisplayHeight/2);
  strokeWeight(4);
  line(0,scoreDisplayHeight, width, scoreDisplayHeight);
  
  puck.move();
  puck.hitPlayer();
  puck.hitEnemy();
  puck.show();
  if (puck.hitLR()) {
    println("Enemy:", scoreEnemy, "Player:", scorePlayer);
    puck = new Puck();
  }
  
  enemy.move();
  enemy.show();
  
  player.move();
  player.show();
  
  
}

void keyPressed() {
  if (keyCode == 32) {
    // start new game by pressin space bar
    scoreEnemy = 0;
    scorePlayer = 0;
    puck = new Puck();
  }
}
