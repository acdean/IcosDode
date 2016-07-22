import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// sound reactive rotating icos inside a rotating dode 
//
// acd 2016-07-20

import peasy.*;
PeasyCam cam;

Dode dode;
Icos icos;
Minim minim;
AudioPlayer player;
FFT fft;
float[] fftData;
String filename = "sample_05.mp3";

void setup() {
  size(800, 600, OPENGL);
  cam = new PeasyCam(this, 700);
  dode = new Dode();
  icos = new Icos();
  minim = new Minim(this);
  player = minim.loadFile(filename, 1024);
  player.loop();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.logAverages(22, 3); // gives 30 values
  fftData = new float[fft.avgSize()];
}

void draw() {
  background(0);
  lights();
  directionalLight(128, 128, 128, 0, 0, -1);  // default
  directionalLight(128, 128, 128, 0, 0, 1);   // reverse default - no dark bits
  fft.forward(player.mix);
  for(int i = 0; i < fft.avgSize(); i++) {
    fftData[i] = fft.getAvg(i);
  }
  icos.draw(fftData);
  dode.draw();
}

void triangle(PShape s, PVector a, PVector b, PVector c) {
  s.vertex(a.x, a.y, a.z);
  s.vertex(b.x, b.y, b.z);
  s.vertex(c.x, c.y, c.z);
}

void point(PVector p) {
  point(p.x, p.y, p.z);
}

void line(PVector a, PVector b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}

class Quint {
  int a, b, c, d, e;
  Quint(int a, int b, int c, int d, int e) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
    this.e = e;
  }
}