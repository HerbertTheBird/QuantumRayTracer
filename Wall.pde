class Wall extends Surface{
  float[] pos; //x1, y1, x2, y2 - horizontal
  int lock = -1;
  Wall(float[] pos){
    this.pos = pos;
  }
  float[][] modifyRay(float[] ray){
    return new float[0][0];
  }
  float distance(float[] ray){
    return rayToLine(ray, pos);
  }
  void display(PGraphics g){
    g.stroke(255, 255, 255);
    g.line(pos[0], pos[1], pos[2], pos[3]);
  }
  void mouseDown(float x, float y){
    if(dist(x, y, pos[0], pos[1]) < mouseRadius){
      lock = 0;
      pos[0] = x;
      pos[1] = y;
    }
    if(dist(x, y, pos[2], pos[3]) < mouseRadius){
      lock = 1;
      pos[2] = x;
      pos[3] = y;
    }
  }
  void mouse(float x, float y){
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
