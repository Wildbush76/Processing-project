class Player extends SquareHitBox {
  private int health;
  private double[] velocity;
  private final int[] playerColor = {255, 0, 0};
  private boolean grounded = false;
  private final double maxMoveSpeed = 5;
  private final double acceration = 0.9;
  private double jumpHeight = 3.5;// use math to make this be in block heights


  public Player(int x, int y, int xSize, int ySize) {
    super(x, y, xSize, ySize);
    health = 100;
    velocity = new double[2];

    jumpHeight = Math.sqrt(2 * (jumpHeight + 0.5) * World.gravity * World.blockSize);
  }

  public void takeDamgeNerd(int amount) {
    health -= amount;
    if (health <= 0) {
      println("you abosolute nerd");
    }
  }
  public int getOffset() {
    if (x > width/2 && x < theWorld.worldLength*World.blockSize - width/2) {
      return (x - (width/2));
    } else if (x > width/2) {
      return theWorld.worldLength*World.blockSize - width;
    } else {
      return 0;
    }
  }
  
  public void setSpawnPoint(int x, int y) {
  
  
    }

  public void run() {
    if (keys[65] && velocity[0] > -maxMoveSpeed) {
      velocity[0]  -= acceration;
    } else if (keys[68] && velocity[0] < maxMoveSpeed) {
      velocity[0] += acceration;
    } else if (velocity[0] != 0) {
      velocity[0] += (velocity[0] < 0) ? acceration : -acceration;
    }

    if (keys[32] && grounded) {
      velocity[1] -= jumpHeight;
    }

    //block collisons please work

    grounded = false;
    velocity[1] += World.gravity;
    int[] tempPos = {this.x, this.y};
    this.x += velocity[0];
    this.y += velocity[1];

    for (int i = 0; i < 2; i++) {
      tempPos[i] += velocity[i];
      for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {//alright.. so im lazy just have 2 thick margin around everything
          int blockIndex =((this.x + this.sizeX/2)/World.blockSize) + x + (((this.y + this.sizeY/2)/World.blockSize) + y) * theWorld.worldLength;
          if (theWorld.world[blockIndex].checkHit(tempPos[0], tempPos[1], this.sizeX, this.sizeY)) {
            int direction = (int)-Math.copySign(1, velocity[i]);
            if (i == 1 && velocity[1] > 0) {
              grounded = true;
            }
            velocity[i] = 0;
            while (theWorld.world[blockIndex].checkHit(tempPos[0], tempPos[1], this.sizeX, this.sizeY)) {
              tempPos[i] += direction;
            }
          }
        }
      }
    }
    this.x = tempPos[0];
    this.y = tempPos[1];

    fill(playerColor[0], playerColor[1], playerColor[2]);
    rect(x, y, sizeX, sizeY);
  }//run the player
}
