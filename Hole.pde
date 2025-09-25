class Hole extends Surface{
  double[] pos;
  Hole(double[] pos){
    this.pos = pos;
  }
  double[][] modifyRay(double[] ray){
    double d = Math.atan2(pos[3]-pos[1], pos[2]-pos[0]);
    double[][] out = new double[200][8];
    for(int i = 0; i < out.length; i++){
      double dir = d-i*Math.PI/out.length;
      for(int j = 0; j < 8; j++) out[i][j] = ray[j];
      out[i][2] = Math.cos(dir);
      out[i][3] = Math.sin(dir);
    }
    return out;
  }
  double distance(double[] ray){
    return rayToLine(ray, pos);
  }
  void mouseDown(double x, double y){
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
