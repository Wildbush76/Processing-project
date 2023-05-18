abstract class Block extends SquareHitBox {//just your very basic dumb block
  protected int[] blockColor;

  public Block(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }
  public abstract void dont(int xOffset);

  public void onHit() {
    //do nothing
  }
}

public class EmptyBlock extends Block {
  public EmptyBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
    hitBox = false;
  }
  public void dont(int xOffset) {
    //nothing its just like nothing, its empty (i need or code will shit itself)
  }
}


class BasicBlock extends Block {
  protected int[] blockColor = {200, 200, 200};

  public BasicBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }

  public void dont(int xOffset) {
    if (xOffset > position[0] + sizeX && position[0] < xOffset + width) {
      return;
    }
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(position[0], position[1], sizeX, sizeY, 5, 5, 5, 5);//temp round corners
  }
}

class SpawnPoint extends Block {
  protected int[] blockColor = {62, 196, 247};
  public SpawnPoint(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
    hitBox = false;
  }

  public void dont(int xOffset) {
    if (xOffset > position[0] + sizeX && position[0] < xOffset + width) {
      return;
    }
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(position[0], position[1], sizeX, sizeY, 5, 5, 5, 5);//temp round corners
  }
}

class DamageBlock extends Block {
  protected int[] blockColor = {162, 240, 19};
  public DamageBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
    hitBox = true;
  }

  public void dont(int xOffset) {
    if (xOffset > position[0] + sizeX && position[0] < xOffset + width) {
      return;
    }
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(position[0], position[1], sizeX, sizeY, 5, 5, 5, 5);//temp round corners
  }
  public void onHit() {
    mainP.takeDamageNerd(5);
  }
}

class GrappleNode extends Block {
  protected int[] blockColor = {126, 126, 126};
  public GrappleNode(int x, int y, int xSize, int ySize) {
    super(x, y, xSize, ySize);
    hitBox = false;
  }
  public void dont(int xOffset) {
    if (xOffset > position[0] + sizeX && position[0] < xOffset + width) {
      return;
    }
    fill(blockColor[0], blockColor[1], blockColor[2]);
    ellipse(position[0] + World.blockSize/2, position[1] + World.blockSize/2, sizeX/2, sizeY/2);
  }
}

class Coin extends Block {
  protected int[] blockColor = {255,255,0};
  public Coin(int x, int y, int xSize, int ySize) {
    super(x,y,xSize,ySize);
  }
  
  public void dont(int xOffset) {
    if (xOffset > position[0] + sizeX && position[0] < xOffset + width) {
      return;
    }
    
    fill(blockColor[0], blockColor[1], blockColor[2]);
   
  }
}
