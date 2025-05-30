abstract class Surface{
  abstract double[][] modifyRay(double[] ray);
  abstract double distance(double[] ray);
  abstract void display(PGraphics g);
  abstract void mouse(double x, double y);
  abstract void mouseRelease();
}
