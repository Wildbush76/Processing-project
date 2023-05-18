class SquareHitBox {//basic stuff for square hitboxes and other useful stuff ill use
  protected int[] position;
  protected int sizeX, sizeY;
  protected boolean hitBox;

  SquareHitBox(int x, int y, int sizeX, int sizeY) {
    position = new int[2];
    position[0] = x;
    position[1] = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    hitBox = true;
  }
  public boolean checkHit(SquareHitBox box) {
    return hitBox && (position[0] + sizeX > box.position[0] && position[0] < box.position[0] + box.sizeX) && (position[1] + sizeY > box.position[1] && position[1] < box.position[1] + box.sizeY);
  }
  public boolean getHitBoxStatus() {
    return hitBox;
  }
  
}
