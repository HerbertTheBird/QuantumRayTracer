class Wall extends Surface{
  double[] pos; //x1, y1, x2, y2 - horizontal
  int lock = -1;
  Wall(double[] pos){
    this.pos = pos;
  }
  double[][] modifyRay(double[] ray){
    return new double[0][0];
  }
  double distance(double[] ray){
    return rayToLine(ray, pos);
  }
  void display(PGraphics g){
    g.stroke(128, 128, 128);
    g.line((float)pos[0], (float)pos[1], (float)pos[2], (float)pos[3]);
  }
  void mouseDown(double x, double y){
    if(dist((float)x, (float)y, (float)pos[0], (float)pos[1]) < mouseR){
      lock = 0;
      pos[0] = x;
      pos[1] = y;
    }
    if(dist((float)x, (float)y, (float)pos[2], (float)pos[3]) < mouseR){
      lock = 1;
      pos[2] = x;
      pos[3] = y;
    }
  }
  void mouse(double x, double y){
    if(lock == 0){
      pos[0] = x;
      pos[1] = y;
    }
    if(lock == 1){
      pos[2] = x;
      pos[3] = y;
    }
      
  }
  void mouseRelease(){
    lock = -1;
  }
}
