static float bpm = 89.5;
static float mspb = 1;
static float framesPerBeat = 1;
static float cos60 = cos(PI/3);
static float sin60 = sin(PI/3);

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim mim;
AudioPlayer song;
ddf.minim.analysis.FFT fft;
static int binCount = 144;
float[] av = new float[binCount];
float max;
float avg;

ArrayList<Event> events = new ArrayList<Event>();
ArrayList<Mob> mobs = new ArrayList<Mob>();
Camera cam;

ArrayList<Flower> flowers = new ArrayList<Flower>();
ArrayList<Ring> rings = new ArrayList<Ring>();
ArrayList<Triangle> tris = new ArrayList<Triangle>();
ArrayList<Grass> grass = new ArrayList<Grass>();

// GLOBAL ANIMATION VARIABLES -------------------
AColor mobStroke = new AColor(255,255,255,255,0.5,10);
AColor mobFill = new AColor(255,255,255,255,0.5,10);

static int de; //width of screen de*2
static int aw; //Animation depth
static int gridW;
static int gridX;
static int gridY;
static int gridZ;
static float defaultMass = 10;
static float defaultVMult = 0.4;


BeatTimer timer;
int currTime;
int offset;

// ---------------------------------------------


void setup() {
  frameRate(60);
  //fullScreen(P3D);
  size(1000,1000,P3D);

  de = (int)(min(width,height)*1);
  aw = (int)(2*de);
  gridW = 2*de/10;
  gridX = 2*de/gridW;
  gridY = 2*de/gridW;
  gridZ = 2*aw/gridW;

  cam = new Camera(de/2, de/2, -de);

  textSize(de/10);

  rectMode(CENTER);
  textAlign(CENTER);

  mim = new Minim(this);
  song = mim.loadFile("sadmachine.mp3", 1024);
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  addEvents();

  song.loop();

  offset = millis();
  timer = new BeatTimer(50,-offset,bpm);

  mobs.add(new Flower(new PVector(0,-de*0.7,-aw), new PVector(0,0,0), de*0.65,6));
  mobs.add(new Flower(new PVector(-de*0.6,0,0), new PVector(0,1,0), de*0.3,5));
  mobs.add(new Flower(new PVector(de*0.6,0,0), new PVector(0,-1,0), de*0.3,5));

  for (int i = 0 ; i < mobs.size() ; i ++) {
    Flower flower = (Flower) mobs.get(i);
    flowers.add(flower);
    for (Ring ring : flower.rings) {
      rings.add(ring);
      for (Triangle tri : ring.tris) {
        tris.add(tri);
      }
    }
  }

  float wX = de*3;
  float wZ = de*3;
  float X = 0;
  float Z = -aw*1.8;
  int row = (int) sqrt(binCount);
  for (int i = 0 ; i < row ; i ++) {
    for (int k = 0 ; k < row*2 ; k++) {
      mobs.add(new Grass(new PVector(X + wX * ((float)i/row - 0.5),de,Z + wZ * ((float)k/row - 0.5)), de*0.2,de*0.1));
      grass.add((Grass) mobs.get(mobs.size() -1));
    }
  }
}

void draw() {
  update();

  cam.render();

  background(0);

  // drawBorders();
  // drawWidthBox(de);
  // drawPitches();

  for (Mob mob : mobs) {
    mob.render();
  }

  for (Event event : events) {
  	event.render();
  }
}

void update() {
  calcFFT();

  currTime = song.position();

  cam.update();
  cam.ang.P.y = -(float)mouseX/width*2*PI;
  cam.ang.P.x = -(float)mouseY/height*2*PI;
  mobFill.update();
  mobStroke.update();
  timer.update();

  updateEvents();
  updateMobs();

  int k;
  for (int i = 0 ; i < tris.size() ; i ++) {
  	Triangle tri = tris.get(i);
    k = (int)((float)i/tris.size()*binCount);
  	tri.ang.v.x += av[k]*0.003;
  	tri.fillStyle.g.X = av[k]*5 + k;
  	tri.fillStyle.b.X = av[k]*5 + 255 - k;
  	tri.fillStyle.r.X = av[k]*9;
  }
  for (int i = 0 ; i < grass.size() ; i ++) {
    Grass gr = grass.get(i);
    k = (int)((float)i/grass.size()*binCount);
    gr.fillStyle.g.X = av[k]*5 + k;
    gr.fillStyle.b.X = av[k]*5 + 255 - k;
    gr.fillStyle.r.X = av[k]*9;
    gr.w.v.y += av[k]*0.5;
  }

}

void updateEvents() {
  for (int i = 0 ; i < events.size() ; i ++) {
    Event event = events.get(i);
    if (currTime > event.time && currTime < event.timeEnd) {
      if (!event.spawned) {
        event.spawned = true;
        event.spawn();
      }
      event.update();
    }
  }
}

void updateMobs() {
  for (Mob mob : mobs) {
    mob.update();
  }

  for (int i = 0 ; i < mobs.size() ; i ++) {
    if (mobs.get(i).finished) mobs.remove(i);
  }
}