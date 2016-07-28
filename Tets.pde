class Tets extends ArrayList<Tet> {
  int COUNT = 50;

  Tets() {
    for (int i = 0 ; i < COUNT ; i++) {
      add(new Tet());
    }
  }
  
  void draw() {
    for (int i = 0 ; i < COUNT ; i++) {
      get(i).draw();
    }
  }
}

class Tet {
  float gx, gy, gz;  // global rotation, ie position
  float gdx, gdy, gdz;  // global delta
  float rx, ry, rz;  // local rotation
  float dx, dy, dz;
  color c;
  float r;
  float sz;
  float MAX_ROT = .05;
  float A = 0.70710678118654752440084436210485f;

  PVector[] points = new PVector[] {
    new PVector(1 + r(), 0 + r(), -A + r()),
    new PVector(-1 + r(), 0 + r(), -A + r()),
    new PVector(0 + r(), 1 + r(), A + r()),
    new PVector(0 + r(), -1 + r(), A + r()),
  };
  float r() {
    return random(.02, .02);
  }

  Tet() {
    gx = random(TWO_PI);
    gy = random(TWO_PI);
    gz = random(TWO_PI);
    gdx = random(-MAX_ROT, MAX_ROT);
    gdy = random(-MAX_ROT, MAX_ROT);
    gdz = random(-MAX_ROT, MAX_ROT);
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    dx = random(-MAX_ROT, MAX_ROT);
    dy = random(-MAX_ROT, MAX_ROT);
    dz = random(-MAX_ROT, MAX_ROT);
    r = random(200, 500);  // distance from centre
    sz = random(20, 30);   // size
    c = color((int)random(64, 128), (int)random(64, 128), (int)random(64, 128));
  }
  
  void draw() {
    colorMode(RGB);
    gx += gdx;
    gy += gdy;
    gz += gdz;
    rx += dx;
    ry += dy;
    rz += dz;
    pushMatrix();
    rotateX(gx);
    rotateY(gy);
    rotateZ(gz);
    translate(r, 0, 0);
    scale(sz);
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    fill(c);
    drawTet();
    popMatrix();
  }
  
  void drawTet() {
    beginShape(TRIANGLE_STRIP);
    vertex(points[0].x, points[0].y, points[0].z);
    vertex(points[1].x, points[1].y, points[1].z);
    vertex(points[2].x, points[2].y, points[2].z);
    vertex(points[3].x, points[3].y, points[3].z);
    vertex(points[0].x, points[0].y, points[0].z);
    vertex(points[1].x, points[1].y, points[1].z);
    endShape();
  }
}