class Player extends SquareHitBox {
  private final int MAXHEALTH = 100;
  private float health;
  private double[] velocity;
  private boolean grounded = false;
  private final double MAX_MOVE_SPEED = 5;
  private final double ACCERATION = 0.9;
  private double jumpHeight = 3.5;// use math to make this be in block heights
  private int[] spawnPoint = new int[2];

  //grapple stuff
  private boolean grappled;
  private int[] grappleLocation;
  private double grappleVelocity;
  private double grappleDistance;
  private double currentGrappleAngle;
  private final double maxGrappleDistance;

  //visiual things
  private PImage spriteLeft;
  private PImage spriteRight;
  private boolean facingRight;


  public Player(int x, int y, int xSize, int ySize) {
    super(x, y, xSize, ySize);
    spriteLeft = loadImage("playerGuyLeft.png");
    spriteRight = loadImage("playerGuyRight.png");

    health = MAXHEALTH;
    velocity = new double[2];
    jumpHeight = Math.sqrt(2 * (jumpHeight + 0.5) * World.gravity * World.BLOCK_SIZE);
    grappleLocation = new int[2];
    grappleVelocity = 0.0;
    grappled = false;
    maxGrappleDistance = Math.pow(200, 2);
    currentGrappleAngle = 0;
  }

  public void takeDamageNerd(int amount) {
    //health -= amount;
    if (health <= 0) {
      die();
    }
  }
  public int getOffset() {
    if (position[0] > width/2 && position[0] < theWorld.WORLD_LENGTH*World.BLOCK_SIZE - width/2) {
      return (position[0] - (width/2));
    } else if (position[0] > width/2) {
      return theWorld.WORLD_LENGTH*World.BLOCK_SIZE - width;
    } else {
      return 0;
    }
  }

  public void setSpawnPoint(int[] pos) {
    spawnPoint = pos;
    die();
  }

  public void die() {
    health = MAXHEALTH;
    position = spawnPoint.clone();
    velocity[1] = 0;
    velocity[0] = 0;
  }

  private void startGrapple() {
    int[] bestPos = {-1, -1};
    double score = maxGrappleDistance + 10;
    double distance = 0;
    for (Block b : theWorld.world) {
      if (b instanceof GrappleNode) {
        distance = Math.pow(b.position[0] - position[0], 2) + Math.pow(b.position[1] - position[1], 2);
        if (distance < score && distance < maxGrappleDistance && theWorld.checkLineOfSight(position[0] + sizeX/2, position[1] + sizeY/2, b.position[0] + World.BLOCK_SIZE/2, b.position[1] + World.BLOCK_SIZE/2)) {
          bestPos = b.position;
          score = distance;
        }
      }
    }
    if (bestPos[0] != -1 && bestPos[1] != -1) {
      grappled = true;
      grappleLocation = bestPos;//add a clone if needed

      currentGrappleAngle =Math.atan2(position[0] - bestPos[0], position[1] - bestPos[1]);

      grappleVelocity = currentGrappleAngle - Math.atan2((position[0] + velocity[0]) - bestPos[0], (position[1] + velocity[1]) - bestPos[1]);
      grappleDistance = Math.sqrt(score);
    }
  }

  private void stopGrapple () {
    grappled = false;
    currentGrappleAngle += grappleVelocity;
    double tempX = (Math.sin(currentGrappleAngle) * grappleDistance + grappleLocation[0]);
    double tempY = (Math.cos(currentGrappleAngle) * grappleDistance + grappleLocation[1]);
    velocity[0] = tempX - position[0];
    velocity[1] = tempY - position[1];
    blockCollisions();
    //add new movement speed logic here -- not really needed
  }

  private void blockCollisions() {
    grounded = false;
    velocity[1] += World.gravity;
    for (int i = 0; i < 2; i++) {
      position[i] += velocity[i];
      for (int y = -sizeY/World.BLOCK_SIZE; y <= sizeY/World.BLOCK_SIZE; y++) {
        for (int x = -sizeX/World.BLOCK_SIZE; x <= sizeX/World.BLOCK_SIZE; x++) {//alright.. so im lazy just have 2 thick margin around everything
          int blockIndex =((position[0] + this.sizeX/2)/World.BLOCK_SIZE) + x + (((position[1] + this.sizeY/2)/World.BLOCK_SIZE) + y) * theWorld.WORLD_LENGTH;
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
    grappleVelocity += (-World.gravity * Math.sin(currentGrappleAngle)) / grappleDistance;
    currentGrappleAngle += grappleVelocity;
    position[0] = (int)(Math.sin(currentGrappleAngle) * grappleDistance + grappleLocation[0]);
    position[1] = (int)(Math.cos(currentGrappleAngle) * grappleDistance + grappleLocation[1]);
    line(position[0] + sizeX/2, position[1] +sizeY/2, grappleLocation[0] + World.BLOCK_SIZE/2, grappleLocation[1] + World.BLOCK_SIZE/2);

    for (int y = -1; y <= sizeY/World.BLOCK_SIZE; y++) {
      for (int x = -1; x <= sizeX/World.BLOCK_SIZE; x++) {//fix this logic to be better sometime, (do it in block collisions too)
        int blockIndex =((position[0] + this.sizeX/2)/World.BLOCK_SIZE) + x + (((position[1] + this.sizeY/2)/World.BLOCK_SIZE) + y) * theWorld.WORLD_LENGTH;
        if (theWorld.world[blockIndex].checkHit(this)) {
          currentGrappleAngle -= grappleVelocity;
          position[0] = (int)(Math.sin(currentGrappleAngle) * grappleDistance + grappleLocation[0]);
          position[1] = (int)(Math.cos(currentGrappleAngle) * grappleDistance + grappleLocation[1]);
          keys[16] = false;
          stopGrapple();
          blockCollisions();
          return;
        }
      }
    }
  }

  public void run() {
    if (keys['A'] && velocity[0] > -MAX_MOVE_SPEED) {
      velocity[0]  -= ACCERATION;
      facingRight = false;
    } else if (keys['D'] && velocity[0] < MAX_MOVE_SPEED) {
      velocity[0] += ACCERATION;
      facingRight = true;
    } else if (velocity[0] != 0 && grounded) {
      velocity[0] /= 1.5;
      if (abs((float)velocity[0])/3.0 < 0.1) {
        velocity[0] = 0;
      }
    }

    if ((keys[' '] || keys['W']) && grounded && !grappled) {
      velocity[1] -= jumpHeight;
      keys[32] = false;
      keys['W'] = false;
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
    if (facingRight) {
      image(spriteRight, position[0], position[1]);
    } else {
      image(spriteLeft, position[0], position[1]);
    }

    fill(255, 0, 0);
    rect(position[0], position[1] - 10, sizeX, 5);
    fill(0, 255, 0);
    rect(position[0], position[1] - 10, sizeX *(health/100), 5);
  }//run the player
}
