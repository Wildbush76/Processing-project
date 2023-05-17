class Player extends SquareHitBox {
  private float health;
  private double[] velocity;
  private final int[] playerColor = {255, 0, 0};
  private boolean grounded = false;
  private final double maxMoveSpeed = 5;
  private final double acceration = 0.9;
  private double jumpHeight = 3.5;// use math to make this be in block heights
  private int[] spawnPoint = new int[2];

  //grapple stuff
  private boolean grappled;
  private int[] grappleLocation;
  private double grappleVelocity;
  private double grappleDistance;
  private double currentGrappleAngle;
  private final double maxGrappleDistance;



  public Player(int x, int y, int xSize, int ySize) {
    super(x, y, xSize, ySize);
    health = 100;
    velocity = new double[2];
    jumpHeight = Math.sqrt(2 * (jumpHeight + 0.5) * World.gravity * World.blockSize);
    grappleLocation = new int[2];
    grappleVelocity = 0.0;
    grappled = false;
    maxGrappleDistance = Math.pow(100, 2);
    currentGrappleAngle = 0;
  }

  public void takeDamageNerd(int amount) {
    health -= amount;
    if (health <= 0) {
      die();
    }
  }
  public int getOffset() {
    if (position[0] > width/2 && position[0] < theWorld.worldLength*World.blockSize - width/2) {
      return (position[0] - (width/2));
    } else if (position[0] > width/2) {
      return theWorld.worldLength*World.blockSize - width;
    } else {
      return 0;
    }
  }

  public void setSpawnPoint(int[] pos) {
    spawnPoint = pos;
    die();
  }

  private void die() {
    health = 100;
    position = spawnPoint.clone();
    velocity[1] = 0;
    velocity[0] = 0;
  }

  private void startGrapple() {
    int[] bestPos = {-1, -1};
    double score = 8000;
    double distance = 0;
    for (Block b : theWorld.world) {
      if (b instanceof GrappleNode) {
        distance = Math.pow(b.position[0] - position[0], 2) + Math.pow(b.position[1] - position[1], 2);
        if (distance < score && distance < maxGrappleDistance) {
          bestPos = b.position;
          score = distance;
        }
      }
    }
    if (bestPos[0] != -1 && bestPos[1] != -1) {
      grappled = true;
      grappleLocation = bestPos;//add a clone if needed
      currentGrappleAngle =Math.atan2(bestPos[0] - position[0], bestPos[1] - position[1])
        grappleVelocity = currentGrappleAngle - Math.atan2(bestPos[0] - (position[0] + velocity[0]), bestPos[1] - (position[1] + velocity[1]));
      grappleDistance = distance;
    }
  }

  private void stopGrapple () {
    grappled = false;

    //add new movement speed logic here
  }

  private void blockCollisions() {
    grounded = false;
    velocity[1] += World.gravity;
    for (int i = 0; i < 2; i++) {
      position[i] += velocity[i];
      for (int y = -sizeY/World.blockSize; y <= sizeY/World.blockSize; y++) {
        for (int x = -sizeX/World.blockSize; x <= sizeX/World.blockSize; x++) {//alright.. so im lazy just have 2 thick margin around everything
          int blockIndex =((position[0] + this.sizeX/2)/World.blockSize) + x + (((position[1] + this.sizeY/2)/World.blockSize) + y) * theWorld.worldLength;
          if (theWorld.world[blockIndex].checkHit(this)) {
            theWorld.world[blockIndex].onHit();
            int direction = (int)-Math.copySign(1, velocity[i]);
            if (i == 1 && velocity[1] > 0) {
              grounded = true;
            }
            velocity[i] = 0;
            while (theWorld.world[blockIndex].checkHit(this)) {
              position[i] += direction;
            }
          }
        }
      }
    }
  }

  private void swingCollisions() {
    grappleVelocity = (-1 * World.gravity * Math.sin(currentGrappleAngle)) / grappleDistance;
    currentGrappleAngle += grappleVelocity;
    position[0] = Math.sin(currentGrappleAngle) * grappleDistance + grappleLocation[0];
    position[1] = Math.cos(currentGrappleAngl) * grappleDistane + grappleLocation[1];

    line(position[0] + World.blockSize/2, position[1] + World.blockSize/2, grappleLocation[0] + World.blockSize/2, grappleLocation[1] + World.blockSize/2);
  }

  public void run() {
    if (keys[65] && velocity[0] > -maxMoveSpeed) {
      velocity[0]  -= acceration;
    } else if (keys[68] && velocity[0] < maxMoveSpeed) {
      velocity[0] += acceration;
    } else if (velocity[0] != 0) {
      velocity[0] += (velocity[0] < 0) ? acceration : -acceration;
    }

    if ((keys[32] || keys[87]) && grounded && !grappled) {
      velocity[1] -= jumpHeight;
    }

    if (grappled) {
      if (!keys[16]) {
        stopGrapple();
      } else {
        swingCollisions();
      }
    } else {
      blockCollisions();
      if (keys[16]) {
        startGrapple();
      }
    }


    fill(playerColor[0], playerColor[1], playerColor[2]);
    rect(position[0], position[1], sizeX, sizeY);

    fill(255, 0, 0);
    rect(position[0], position[1] - 10, sizeX, 5);
    fill(0, 255, 0);
    rect(position[0], position[1] - 10, sizeX *(health/100), 5);
  }//run the player
}
