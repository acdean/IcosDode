class Dode {

  final float MAX_SPEED = .02;

  float rx, ry, rz;
  float dx, dy, dz;

  PVector[] centres;
  PImage tex;
  
  Dode() {
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    dx = random(-MAX_SPEED, MAX_SPEED);
    dy = random(-MAX_SPEED, MAX_SPEED);
    dz = random(-MAX_SPEED, MAX_SPEED);
    centres = new PVector[faces.length];
    for (int i = 0 ; i < faces.length ; i++) {
      // centres is the average of the points
      centres[i] = points[(int)faces[i].a].copy();
      centres[i].add(points[(int)faces[i].b]);
      centres[i].add(points[(int)faces[i].c]);
      centres[i].add(points[(int)faces[i].d]);
      centres[i].add(points[(int)faces[i].e]);
      centres[i].div(5);
    }
    tex = loadImage("texture.png");
  }

  /*
    h = (1 + √5) / 2
    (±1, ±1, ±1) 0 - 7
    (0, ±1/A, ±A) 8 - 11
    (±1/A, ±A, 0) 12 - 15
    (±A, 0, ±1/A) 
  */
  float DODE_SZ = 750.0;
  float A = (1.0 + sqrt(5.0)) / 2.0;
  PVector[] points = {
    new PVector(DODE_SZ, DODE_SZ, DODE_SZ),  // 0
    new PVector(DODE_SZ, DODE_SZ, -DODE_SZ),  // 1
    new PVector(DODE_SZ, -DODE_SZ, DODE_SZ),  // 2
    new PVector(DODE_SZ, -DODE_SZ, -DODE_SZ),  // 3
    new PVector(-DODE_SZ, DODE_SZ, DODE_SZ),    // 4
    new PVector(-DODE_SZ, DODE_SZ, -DODE_SZ),  // 5
    new PVector(-DODE_SZ, -DODE_SZ, DODE_SZ),  // 6
    new PVector(-DODE_SZ, -DODE_SZ, -DODE_SZ),  // 7
    new PVector(0, DODE_SZ / A, DODE_SZ * A),  // 8
    new PVector(0, DODE_SZ / A, -DODE_SZ * A),  // 9
    new PVector(0, -DODE_SZ / A, DODE_SZ * A),  // 10
    new PVector(0, -DODE_SZ / A, -DODE_SZ * A),  // 11
    new PVector(DODE_SZ/A, DODE_SZ * A, 0),  // 12
    new PVector(DODE_SZ/A, -DODE_SZ * A, 0),  // 13
    new PVector(-DODE_SZ/A, DODE_SZ * A, 0),  // 14
    new PVector(-DODE_SZ/A, -DODE_SZ * A, 0),  // 15
    new PVector(DODE_SZ * A, 0, DODE_SZ/A),  // 16
    new PVector(DODE_SZ * A, 0, -DODE_SZ/A),  // 17
    new PVector(-DODE_SZ * A, 0, DODE_SZ/A),  // 18
    new PVector(-DODE_SZ * A, 0, -DODE_SZ/A),  // 19
  };

  // todo windings
  Quint[] faces = {
    new Quint(0, 8, 4, 14, 12),
    new Quint(0, 8, 10, 2, 16),
    new Quint(0, 16, 17, 1, 12),
    new Quint(2, 13, 3, 17, 16),
    new Quint(10, 6, 15, 13, 2),
    new Quint(8, 4, 18, 6, 10),
    new Quint(4, 18, 19, 5, 14),
    new Quint(12, 14, 5, 9, 1),
    new Quint(1, 9, 11, 3, 17),
    new Quint(3, 11, 7, 15, 13),
    new Quint(7, 11, 9, 5, 19),
    new Quint(7, 15, 6, 18, 19),
  };

  void draw() {
    rx += dx;
    ry += dy;
    rz += dz;
    pushMatrix();
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    stroke(255);
    strokeWeight(2);
    noStroke();
    textureMode(NORMAL);
    for (int i = 0 ; i < faces.length ; i++) {
      drawPent(i);
    }
    //for (int i = 0 ; i < faces.length ; i++) {
    //  line(points[(int)faces[i].a], points[(int)faces[i].b]);
    //  line(points[(int)faces[i].b], points[(int)faces[i].c]);
    //  line(points[(int)faces[i].c], points[(int)faces[i].d]);
    //  line(points[(int)faces[i].d], points[(int)faces[i].e]);
    //  line(points[(int)faces[i].e], points[(int)faces[i].a]);
    //}
    for (int i = 0 ; i < 0 ; i++) {  // disabled
      strokeWeight(10);
      point(points[i]);
      textSize(40);
      fill(255);
      text(i, points[i].x, points[i].y, points[i].z);
    }
    popMatrix();
  }

  void drawPent(int i) {
    beginShape(TRIANGLE_FAN);
    texture(tex);
    vertex(centres[i].x, centres[i].y, centres[i].z, 0, 0);
    drawTri(i, points[(int)faces[i].a], points[(int)faces[i].b]);
    drawTri(i, points[(int)faces[i].b], points[(int)faces[i].c]);
    drawTri(i, points[(int)faces[i].c], points[(int)faces[i].d]);
    drawTri(i, points[(int)faces[i].d], points[(int)faces[i].e]);
    drawTri(i, points[(int)faces[i].e], points[(int)faces[i].a]);
    endShape();
  }

  void drawTri(int i, PVector p1, PVector p2) {
    vertex(p1.x, p1.y, p1.z, 1, 1);
    vertex((p1.x + p2.x) / 2, (p1.y + p2.y) / 2, (p1.z + p2.z) / 2, 1, 0);
    vertex(p2.x, p2.y, p2.z, 1, 1);
  }
}