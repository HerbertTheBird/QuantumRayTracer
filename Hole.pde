class Hole extends Surface{
  float[] pos;
  Hole(float[] pos){
    this.pos = pos;
  }
  float[][] modifyRay(float[] ray){
    float d = atan2(pos[3]-pos[1], pos[2]-pos[0]);
    float[][] out = new float[500][8];
    for(int i = 0; i < out.length; i++){
      float r = random(PI);
      float dir = d-r;
      //pos
      out[i][0] = ray[0];
      out[i][1] = ray[1];
      //dx dy
      out[i][2] = cos(dir);
      out[i][3] = sin(dir);
      //medium speed
      out[i][4] = ray[4];
      //time
      out[i][5] = ray[5];
      //amplitude
      out[i][6] = ray[6]/sqrt(out.length);
      //frequency
      out[i][7] = ray[7];
      
    }
    return out;
  }
  float distance(float[] ray){
    return rayToLine(ray, pos);
  }
  void mouseDown(float x, float y){
  }
  void display(PGraphics g){
  }
  void mouse(float x, float y){
    
  }
  void mouseRelease(){
    
  }
}
