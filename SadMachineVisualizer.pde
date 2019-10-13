static float bpm = 89.5;
static float mspb = 1;
static float framesPerBeat = 1;

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
static float defaultVMult = 0.5;


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
}

void draw() {
  update();

  cam.render();

  background(0);

  drawBorders();
  drawWidthBox(de);
  drawPitches();

  for (Mob mob : mobs) {
    mob.render();
  }
}

void update() {
  calcFFT();

  currTime = song.position();

  cam.update();
  mobFill.update();
  mobStroke.update();
  timer.update();

  updateEvents();
  updateMobs();
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