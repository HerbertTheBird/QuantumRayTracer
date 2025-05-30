class Display extends Surface{
  double[] pos;
  ArrayList<double[]> hit = new ArrayList();
  double hitWidth = 20;
  boolean firstSelect = false;
  boolean secondSelect = false;
  double selectSize = 20;
  int precision = 1000;
  Display(double[] pos){
    this.pos = pos;
  }
  double[][] modifyRay(double[] ray){
    double[] s = new double[] {pos[2]-pos[0], pos[3]-pos[1]};
    double rxs = cross(ray[2], ray[3], s[0], s[1]);
    double[] qp = new double[] {pos[0]-ray[0], pos[1]-ray[1]};
    double qpxr = cross(qp[0], qp[1], ray[2], ray[3]);
    double u = qpxr / rxs;
    hit.add(new double[] {u, ray[6], (ray[7]*ray[5])%(PI*2)});
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
    g.stroke(255, 0, 0);
    double dx = (pos[2]-pos[0]);
    double dy = (pos[3]-pos[1]);
    //double hitFract = hitWidth/Math.sqrt(dx*dx+dy*dy);
    double[][] vec = new double[precision][2];
    
    for(int i = 0; i < hit.size(); i++){
      for(int j = (int)(precision*hit.get(i)[0])-1; j <= (int)(precision*hit.get(i)[0])+1; j++){
        if(j < 0 || j >= precision) continue;
        vec[j][0] += Math.cos(hit.get(i)[2])*hit.get(i)[1];
        vec[j][1] += Math.sin(hit.get(i)[2])*hit.get(i)[1];
      }
      //g.line((float)(pos[0]+Math.max(0, hit.get(i)[0]-hitFract/2)*dx), (float)(pos[1]+Math.max(0, hit.get(i)[0]-hitFract/2)*dy), (float)(pos[0]+Math.min(1, hit.get(i)[0]+hitFract/2)*dx), (float)(pos[1]+Math.min(1, hit.get(i)[0]+hitFract/2)*dy));
    }
    for(int i = 0; i < precision; i++){
      g.stroke(min(255, (float)((vec[i][0]*vec[i][0]+vec[i][1]*vec[i][1]))/16384/16));
      g.fill(min(255, (float)((vec[i][0]*vec[i][0]+vec[i][1]*vec[i][1]))/16384/16));
      g.line((float)(pos[0]+i*dx/precision), (float)(pos[1]+i*dy/precision), (float)(pos[0]+(i+1)*dx/precision), (float)(pos[1]+(i+1)*dy/precision));
      g.rect((float)(pos[0]+i*dx/precision), (float)(pos[1]+i*dy/precision)-80, (float)(dx/precision), 60);
    }
    g.fill(128);
    g.stroke(128);
    g.circle((float)pos[0], (float)pos[1], (float)selectSize);
    g.circle((float)pos[2], (float)pos[3], (float)selectSize);
    hit.clear();
  }
  double cross(double a0, double a1, double b0, double b1){
    return a0*b1-a1*b0;
  }
  void mouse(double x, double y){
    if(firstSelect){
      pos[0] = x;
      pos[1] = y;
      return;
    }
    if(secondSelect){
      pos[2] = x;
      pos[3] = y;
    }
    if((pos[0]-x)*(pos[0]-x)+(pos[1]-y)*(pos[1]-y) < selectSize*selectSize){
      firstSelect = true;
      return;
    }
    if((pos[2]-x)*(pos[2]-x)+(pos[3]-y)*(pos[3]-y) < selectSize*selectSize){
      secondSelect = true;
      return;
    }
  }
  void mouseRelease(){
    firstSelect = false;
    secondSelect = false;
  }
}
