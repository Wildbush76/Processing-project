class Player extends SquareHitBox {
  private int health;
  private double[] velocity;
  private final int[] playerColor = {255, 0, 0};
  private boolean grounded = false;
  private final double maxMoveSpeed = 5;
  private final double acceration = 0.5;
  private double jumpHeight = 3;// use math to make this be in block heights


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
    y += velocity[1] += World.gravity;
    int maxY = ((this.y + this.sizeY)/World.blockSize > theWorld.worldHeight-1) ? 0 : 1;
    int minY = (this.y < World.blockSize) ? 0 : -1;
    int maxX = ((this.x + this.sizeX)/World.blockSize > theWorld.worldLength-1) ? 0 : 1;
    int minX = (this.x < World.blockSize) ? 0 : -1;
    for (int y = minY; y <= maxY; y++) {
      for (int x = minX; x <= maxX; x++) {
        int index = ((this.x + this.sizeX/2)/World.blockSize) + x + (((this.y + this.sizeY/2)/World.blockSize) + y) * theWorld.worldLength;
        if (theWorld.world[index].checkHit(this)) {
          int d = (int)-Math.copySign(1, velocity[1]);
          if (velocity[1] > 0) {
            grounded = true;
          }
          velocity[1] = 0;
          while (theWorld.world[index].checkHit(this))
            this.y += d;
        }
      }
    }

    x += velocity[0];
    //maxY = ((this.y + this.sizeY)/World.blockSize > theWorld.worldHeight-1) ? 0 : 1;
    //minY = (this.y < World.blockSize) ? 0 : -1;//i don't think these are needed but uncomment if it causes issues
    maxX = ((this.x + this.sizeX)/World.blockSize > theWorld.worldLength-1) ? 0 : 1;
    minX = (this.x < World.blockSize) ? 0 : -1;
    for (int y = minY; y <= maxY; y++) {
      for (int x = minX; x <= maxX; x++) {
        int index = ((this.x + this.sizeX/2)/World.blockSize) + x + (((this.y + this.sizeY/2)/World.blockSize) + y) * theWorld.worldLength;
        if (theWorld.world[index].checkHit(this)) {
          int d = (int)-Math.copySign(1, velocity[0]);
          velocity[0] = 0;

          while (theWorld.world[index].checkHit(this))
            this.x += d;
        }
      }
    }

    fill(playerColor[0], playerColor[1], playerColor[2]);
    rect(x, y, sizeX, sizeY);
  }//run the player
}
