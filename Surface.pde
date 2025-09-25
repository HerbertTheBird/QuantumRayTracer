abstract class Surface{
  abstract double[][] modifyRay(double[] ray);
  abstract double distance(double[] ray);
  abstract void display(PGraphics g);
  abstract void mouse(double x, double y);
  abstract void mouseDown(double x, double t);
  abstract void mouseRelease();
  double cross(double a0, double a1, double b0, double b1){
    return a0*b1-a1*b0;
  }
  double rayToLine(double[] ray, double[] pos){
    double[] s = new double[] {pos[2]-pos[0], pos[3]-pos[1]};
    double rxs = cross(ray[2], ray[3], s[0], s[1]);
    double[] qp = new double[] {pos[0]-ray[0], pos[1]-ray[1]};
    double qpxr = cross(qp[0], qp[1], ray[2], ray[3]);
    if(rxs == 0) return Double.NaN;
    double t = cross(qp[0], qp[1], s[0], s[1])/rxs;
    double u = qpxr / rxs;
    if(t >= 0 && u >= 0 && u < 1) return t;
    else return Double.NaN;
  }
}
