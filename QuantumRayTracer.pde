ArrayList<Surface> surfaces = new ArrayList();
double[] tempRay = new double[8]; //x, y, vx, vy, medium speed, time, amplitude, frequency
PGraphics g;
int t = 0;
double[] pos1 = {850, 550};
double[] pos2 = {850, 550};
boolean firstSelect = false;
boolean secondSelect = false;
boolean draw = false;
int rayCount = 0;
void setup() {
  g = createGraphics(1700, 1100);
  surfaces.add(new Display(new double[] {-100, 100, 1800, 100}));
  size(1700, 1100);
}
void draw() {
  //println(frameRate);
  g.beginDraw();
  g.background(0, 0, 0);
  g.fill(255, 255, 255);
  g.stroke(255, 255, 255);
  if(t > 0){
    pos1[0] += 0.5;
    pos2[0] -= 0.5;
  }
  t++;
  if(mousePressed){
  if(firstSelect){
      pos1[0] = mouseX;
      pos1[1] = mouseY;
    }
    else if(secondSelect){
      pos2[0] = mouseX;
      pos2[1] = mouseY;
    }
    else if((pos1[0]-mouseX)*(pos1[0]-mouseX)+(pos1[1]-mouseY)*(pos1[1]-mouseY) < 400){
      firstSelect = true;
    }
    else if((pos2[0]-mouseX)*(pos2[0]-mouseX)+(pos2[1]-mouseY)*(pos2[1]-mouseY) < 400){
      secondSelect = true;
    }
  }
  int c = 0;
  rayCount = 0;
  surfaces.clear();
  surfaces.add(new Display(new double[] {-100, 100, 1800, 100}));
  surfaces.add(new Solid(new double[] {0, pos2[1], pos2[0]-5, pos2[1]}));
  surfaces.add(new Solid(new double[] {pos1[0]+5, pos2[1], 1700, pos2[1]}));
  if(pos1[0]-pos2[0]>10){
    surfaces.add(new Solid(new double[] {pos2[0]+5, pos2[1], pos1[0]-5, pos1[1]}));
    surfaces.add(new Hole(new double[] {pos2[0]-5, pos2[1], pos2[0]+5, pos2[1]}));
    surfaces.add(new Hole(new double[] {pos1[0]-5, pos1[1], pos1[0]+5, pos1[1]}));
  }
  else{
    surfaces.add(new Hole(new double[] {pos2[0]-5, pos2[1], pos1[0]+5, pos1[1]}));
  }
  for(double i = PI; i < PI*2; i+=PI/25000){
    if(c++%200==100){
      draw = true;
      g.stroke(64);
    }
    else{
      draw = false;
      g.noStroke();
    }
    //rayTrace(new double[] {pos1[0], pos1[1], cos((float)i), sin((float)i), 1, 0, 1, 2E-1}, 0);
    //rayTrace(new double[] {pos2[0], pos2[1], cos((float)i), sin((float)i), 1, 0, 1, 2E-1}, 0);
    rayTrace(new double[] {850, 1000, cos((float)i), sin((float)i), 1, 0, 1, 2E-1}, 0);
    g.fill(128);
    //g.rect((float)pos1[0]+5, (float)pos1[1]-5, 2000, 10);
    //g.rect(0, (float)pos2[1]-5, (float)pos2[0]-5, 10);
    //if(pos1[0]-pos2[0]>10)
    //g.rect((float)pos2[0]+5, (float)pos2[1]-5, (float)(pos1[0]-pos2[0])-10, (float)(pos1[1]-pos2[1])+10);
    g.fill(255);
    //g.circle((float)pos1[0], (float)pos1[1], 20);
    //g.circle((float)pos2[0], (float)pos2[1], 20);
    g.text("light", 840, 980);
    g.circle(850, 1000, 20);
  }
  for(Surface s:surfaces){
    if(mousePressed)
      s.mouse(mouseX, mouseY);
    s.display(g);
  }
  g.endDraw();
  image(g, 0, 0);
  g.save("vid/img"+String.format("%03d", t) + ".png");
}
void rayTrace(double[] ray, int depth){
  if(depth > 2){
    return;
  }
  int mi = -1;
  double mn = Double.POSITIVE_INFINITY;
  for(int i = 0; i < surfaces.size(); i++){
    double d = surfaces.get(i).distance(ray);
    if(!Double.isNaN(d) && d < mn){
      mn = d;
      mi = i;
    }
  }
  if(mi == -1){
    g.line((float)ray[0], (float)ray[1], (float)(ray[0]+2000*ray[2]), (float)(ray[1]+2000*ray[3]));
  }
  else{
    g.line((float)ray[0], (float)ray[1], (float)(ray[0]+ray[2]*mn), (float)(ray[1]+ray[3]*mn));
    ray[0] += ray[2]*(mn+1);
    ray[1] += ray[3]*(mn+1);
    ray[5] += (mn+1)/ray[4];
    double[][] rays = surfaces.get(mi).modifyRay(ray);
    for(int i = 0; i < rays.length; i++){
      if(i%100 == 50 && rayCount == 0 && depth == 0)
        g.stroke(64);
       else
        g.noStroke();
      rayTrace(rays[i], depth+1);
    }
    if(rays.length > 0 && depth == 0){
      rayCount++;
    }
    if(rays.length == 0 && depth == 0){
      rayCount = 0;
    }
  }
}
void copyTo(double[] original, double[] target){
  for(int i = 0; i < min(original.length, target.length); i++) target[i]=original[i];
}
double[] copy(double[] in){
  double[] out = new double[in.length];
  for(int i = 0; i < in.length; i++) out[i]=in[i];
  return out;
}
void mouseReleased(){
  for(Surface s:surfaces){
    s.mouseRelease();
  }
  firstSelect = false;
  secondSelect = false;
}
