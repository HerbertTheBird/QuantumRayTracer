class Hole extends Surface{
  double[] pos;
  Hole(double[] pos){
    this.pos = pos;
  }
  double[][] modifyRay(double[] ray){
    double d = Math.atan2(pos[3]-pos[1], pos[2]-pos[0]);
    double[][] out = new double[5000][8];
    for(int i = 0; i < out.length; i++){
      double dir = d-i*Math.PI/out.length;
      for(int j = 0; j < 8; j++) out[i][j] = ray[j];
      out[i][2] = Math.cos(dir);
      out[i][3] = Math.sin(dir);
    }
    return out;
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
    
  }
  void mouse(double x, double y){
    
  }
  void mouseRelease(){
    
  }
  double cross(double a0, double a1, double b0, double b1){
    return a0*b1-a1*b0;
  }
}
