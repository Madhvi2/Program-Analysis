import java.util.Random;

public class Test8
{
  public Object foo()
  {
    final boolean x = new Random().nextBoolean();
    final boolean y = new Random().nextBoolean();
    Object equal = new Object() {
      public boolean equals(Object a)
      {
        return x;
      }
    };
    return equal;
  }

  public Object bar()
  {
    final boolean[] x = {new Random().nextBoolean()};
    final boolean[] y = {new Random().nextBoolean()};
    Object equal = new Object() {
      public boolean equals(Object a)
      {
        return x[0];
      }
    };
    return equal;
  }
}
