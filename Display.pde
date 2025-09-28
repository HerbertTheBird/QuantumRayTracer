class Display extends Surface{
  float[] pos;
  int precision = 3200;
  float[][] hit = new float[precision][2];
  float brightness = 1E9;
  Display(float[] pos){
    this.pos = pos;
  }
  float[][] modifyRay(float[] ray){
    float[] s = new float[] {pos[2]-pos[0], pos[3]-pos[1]};
    float rxs = cross(ray[2], ray[3], s[0], s[1]);
    float[] qp = new float[] {pos[0]-ray[0], pos[1]-ray[1]};
    float qpxr = cross(qp[0], qp[1], ray[2], ray[3]);
    float u = qpxr / rxs;
    
    hit[min(precision-1, (int)(u*precision))][0] += ray[6]*cos(ray[5]);
    hit[min(precision-1, (int)(u*precision))][1] += ray[6]*sin(ray[5]);
    return new float[0][0];
  }
  float distance(float[] ray){
    return rayToLine(ray, pos);
  }
  void display(PGraphics g){
    g.stroke(255, 255, 255);
    g.line(pos[0], pos[1], pos[2], pos[3]);
    g.stroke(255, 0, 0);
    float dx = (pos[2]-pos[0]);
    float dy = (pos[3]-pos[1]);
    
    for(int i = 0; i < precision; i++){
      float intensity = pow(dist(0, 0, hit[i][0], hit[i][1])/totalRays, 2)*precision*brightness;
      g.fill(constrain(intensity, 0, 255));
      g.stroke(constrain(intensity, 0, 255));
      g.line((pos[0]+i*dx/precision), (pos[1]+i*dy/precision), (pos[0]+(i+1)*dx/precision), (pos[1]+(i+1)*dy/precision));
      g.rect((pos[0]+i*dx/precision)+1E-7, (pos[1]+i*dy/precision), 2E-2, (dy/precision));
    }
  }
  void mouseDown(float x, float y){
  }
  void mouse(float x, float y){
  }
  void mouseRelease(){
  }
}
