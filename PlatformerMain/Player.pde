class Player extends SquareHitBox {
  private int health;
  private double[] velocity;
  private final int[] playerColor = {255, 0, 0};
  private boolean grounded = false;
  private final double maxMoveSpeed = 5;
  private final double acceration = 0.5;
  private final double jumpHeight = 10;// use math to make this be in block heights

  public Player(int x, int y, int xSize, int ySize) {
    super(x, y, xSize, ySize);
    health = 100;
    velocity = new double[2];
    
    //cry about the quadratic formula here
  }



  public void run() {
    if (keys[65] && velocity[0] > -maxMoveSpeed) {
      velocity[0]  -= acceration;
    } else if (keys[68] && velocity[0] < maxMoveSpeed) {
      velocity[0] += acceration;
    } else if(velocity[0] != 0) {
      velocity[0] += (velocity[0] < 0) ? acceration : -acceration;
    }

    if (keys[32] && grounded) {
      velocity[1] -= jumpHeight;
    }

  y += velocity[1] += World.gravity;
    x += velocity[0];

    //temp
    if (y + sizeY >= height) {
      grounded = true;
      velocity[1] = 0;
      if (y + sizeY > height) {
        y += height - (y + sizeY);
      }
    } else {
      grounded = false;
    }
    //temp


    fill(playerColor[0], playerColor[1], playerColor[2]);
    rect(x, y, sizeX, sizeY);
  }//run the player
}
