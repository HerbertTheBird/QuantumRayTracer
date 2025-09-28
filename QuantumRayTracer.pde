final float C = 299792458;
final int mouseRadius = 20;
float zoom = 2E3;
float centerX = 0;
float centerY = 0;
float eps = 0.0001/zoom;
ArrayList<Surface> surfaces = new ArrayList();
float[] tempRay = new float[8]; //x, y, dx, dy, medium speed, phase, amplitude, frequency
PGraphics g;


float[] lightPos = {-8E-6, 0};
int totalRays = 1;
int raysPerSecond = 50;

boolean[] keys = new boolean[256];
void setup() {
  g = createGraphics(1700, 1100);
  float w = 1E-6;
  float d = 1E-4;
  float x = 2.5E-1;
  surfaces.add(new Display(new float[] {x, x/4, x, -x/4})); 
  surfaces.add(new Wall(new float[] {-x, -1,   -x, -(w+d)/2})); 
  surfaces.add(new Hole(new float[] {-x, -(w+d)/2, -x, -(d-w)/2})); 
  surfaces.add(new Wall(new float[] {-x, -(d-w)/2, -x,  (d-w)/2})); 
  surfaces.add(new Hole(new float[] {-x,  (d-w)/2, -x,  (w+d)/2})); 
  surfaces.add(new Wall(new float[] {-x,  1,   -x,  (w+d)/2})); 
  
  //for(int i = 1; i <= 10; i++){
  //  surfaces.add(new Wall(new float[] {x+i*1e-3,  3e-3*i,   x+i*1e-3,  -3e-3*i})); 
  //}
  


  size(1700, 1100, P2D);}
void draw() {
  println(frameRate);
  if(keys['d']){
    centerX -= 20.0/zoom;
  }
  if(keys['a']){
    centerX += 20.0/zoom;
  }
  if(keys['s']){
    centerY -= 20.0/zoom;
  }
  if(keys['w']){
    centerY += 20.0/zoom;
  }
  if(keys['e']){
    zoom *= 1.05;
  }
  if(keys['q']){
    zoom /= 1.05;
  }
  g.beginDraw();
  g.background(0, 0, 0);
  g.translate(width/2, height/2);
  g.scale(zoom);
  g.translate(centerX, centerY);
  g.strokeWeight(1/zoom);
  g.stroke(64, 64, 64);
  for(int i = 0; i < raysPerSecond; i++){
    //float theta = random(PI*2);
    float y = 0;
    if(random(2) < 1){
      y = random(((Hole)surfaces.get(2)).pos[3]-((Hole)surfaces.get(2)).pos[1])+((Hole)surfaces.get(2)).pos[1];
    }
    else{
      y = random(((Hole)surfaces.get(4)).pos[3]-((Hole)surfaces.get(4)).pos[1])+((Hole)surfaces.get(4)).pos[1];
    }
    rayTrace(new float[] {-1, y, 1, 0, C, 0, 1, 5E14}, 0);
    //rayTrace(new float[] {lightPos[0], lightPos[1], cos(theta), sin(theta), C, 0, 1, 500E12}, 0);
    totalRays++;
  }
  for(Surface s:surfaces){
    //if(mousePressed)
      //s.mouse(mouseX, mouseY);
    s.display(g);
  }
  g.endDraw();
  image(g, 0, 0);
  //g.save("vid/img"+String.format("%03d", t) + ".png");
}
void rayTrace(float[] ray, int depth){
  if(depth > 1){
    return;
  }
  int mi = -1;
  float mn = Float.POSITIVE_INFINITY;
  for(int i = 0; i < surfaces.size(); i++){
    float d = surfaces.get(i).distance(ray);
    if(!Float.isNaN(d) && d < mn){
      mn = d;
      mi = i;
    }
  }
  if(mi == -1){
    g.line((float)ray[0], (float)ray[1], (float)(ray[0]+2000*ray[2]), (float)(ray[1]+2000*ray[3]));
  }
  else{
    g.line((float)ray[0], (float)ray[1], (float)(ray[0]+ray[2]*mn), (float)(ray[1]+ray[3]*mn));
    ray[0] += ray[2]*(mn+eps);
    ray[1] += ray[3]*(mn+eps);
    double temp = (ray[5]+(mn+eps)/ray[4]*ray[7]*2*PI)%(2*PI); //hopefully removes precision errors
    ray[5] = (float)temp;
    float[][] rays = surfaces.get(mi).modifyRay(ray);
    for(int i = 0; i < rays.length; i++){
      if(i == 0){
        g.stroke(64, 64, 64);
      }
      else{
        g.noStroke();
      }
      rayTrace(rays[i], depth+1);
    }
    g.stroke(64, 64, 64);
  }
}
void copyTo(float[] original, float[] target){
  for(int i = 0; i < min(original.length, target.length); i++) target[i]=original[i];
}
float[] copy(float[] in){
  float[] out = new float[in.length];
  for(int i = 0; i < in.length; i++) out[i]=in[i];
  return out;
}
void mousePressed(){
  for(Surface s:surfaces){
    //s.mouseDown(mouseX, mouseY);
  }
}
void mouseReleased(){
  for(Surface s:surfaces){
    //s.mouseRelease();
  }
}
void keyPressed(){
  if(key < 256) keys[key] = true;
}
void keyReleased(){
  if(key < 256) keys[key] = false;
}
