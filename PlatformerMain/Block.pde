abstract class Block extends SquareHitBox {//just your very basic dumb block
  protected int[] blockColor;

  public Block(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }
  public abstract void dont();
}

public class EmptyBlock extends Block {
  public EmptyBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }
  public void dont() {
    //nothing its just like nothing, its empty (i need or code will shit itself)
  }

  public boolean checkHit(SquareHitBox box) {
    return false;// you just dont hit it
  }
  
  public boolean checkHit(int x, int y, int sizeX, int sizeY) {
    return false;// again, no hitting
  }
}


class BasicBlock extends Block {
  protected int[] blockColor = {200, 200, 200};

  public BasicBlock(int x, int y, int sizeX, int sizeY) {
    super(x, y, sizeX, sizeY);
  }

  public void dont() {
    fill(blockColor[0], blockColor[1], blockColor[2]);
    rect(x, y, sizeX, sizeY, 5, 5, 5, 5);//temp round corners
  }
}
