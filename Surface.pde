abstract class Surface{
  abstract float[][] modifyRay(float[] ray);
  abstract float distance(float[] ray);
  abstract void display(PGraphics g);
  abstract void mouse(float x, float y);
  abstract void mouseDown(float x, float t);
  abstract void mouseRelease();
  float cross(float a0, float a1, float b0, float b1){
    return a0*b1-a1*b0;
  }
  float rayToLine(float[] ray, float[] pos){
    float[] s = new float[] {pos[2]-pos[0], pos[3]-pos[1]};
    float rxs = cross(ray[2], ray[3], s[0], s[1]);
    float[] qp = new float[] {pos[0]-ray[0], pos[1]-ray[1]};
    float qpxr = cross(qp[0], qp[1], ray[2], ray[3]);
    if(rxs == 0) return Float.NaN;
    float t = cross(qp[0], qp[1], s[0], s[1])/rxs;
    float u = qpxr / rxs;
    if(t >= 0 && u >= 0 && u < 1) return t;
    else return Float.NaN;
  }
}
