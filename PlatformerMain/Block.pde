abstract class Block extends SquareHitBox {//just your very basic dumb block
  protected int[] blockColor;

  public Block(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }
  public abstract void dont(int xOffset);
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
    if (xOffset > x + sizeX && x < xOffset + width) {
      return;
    }
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(x, y, sizeX, sizeY, 5, 5, 5, 5);//temp round corners
  }
}

class SpawnPoint extends Block {
  protected int[] blockColor = {62,196,247};
  public SpawnPoint(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
    hitBox = false;
  }
  
   public void dont(int xOffset) {
    if (xOffset > x + sizeX && x < xOffset + width) {
      return;
    }
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(x, y, sizeX, sizeY, 5, 5, 5, 5);//temp round corners
  }
  
}
