class Solid extends Surface{
  double[] pos;
  Solid(double[] pos){
    this.pos = pos;
  }
  double[][] modifyRay(double[] ray){
    return new double[0][0];
  }
  double distance(double[] ray){
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
  void display(PGraphics g){
    g.stroke(128, 128, 128);
    g.line((float)pos[0], (float)pos[1], (float)pos[2], (float)pos[3]);
  }
  double cross(double a0, double a1, double b0, double b1){
    return a0*b1-a1*b0;
  }
  void mouse(double x, double y){
    
  }
  void mouseRelease(){
    
  }
}
