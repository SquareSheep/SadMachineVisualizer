class Event {
	boolean finished = false;
	boolean spawned = false;
	int time;
	int timeEnd;

	void update() {

	}

	void render() {
		
	}

	void spawn() {

	}
}
// 3700, 14600, 25500, 47200

class Play37s146 extends Event {
	Play37s146() {
		time = 3700;
		timeEnd = 146000;
	}

	void spawn() {

	}

	void update() {
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
}

// Is anyone there?
class Anyone0s37 extends Event {
	Anyone0s37() {
		time = 0;
		timeEnd = 3700;
	}

	void spawn() {
		for (Triangle tri : tris) {
			tri.fillStyle.setX(0,0,0,255);
			tri.strokeStyle.setX(0,0,0,255);
		}
		for (Grass gr : grass) {
			gr.fillStyle.setX(0,0,0,255);
			gr.strokeStyle.setX(0,0,0,255);
		}
	}

	void update() {
		int k;
		for (int i = 0 ; i < tris.size() ; i ++) {
			Triangle tri = tris.get(i);
			k = (int)((float)i/tris.size()*binCount);
			tri.ang.v.x += pow(av[k],1.2)*0.003;
			tri.fillStyle.g.X = pow(av[k],1.6)*10;
			tri.fillStyle.b.X = pow(av[k],1.6)*10;
			tri.fillStyle.r.X = pow(av[k],1.6)*10;
		}
		for (int i = 0 ; i < grass.size() ; i ++) {
			Grass gr = grass.get(i);
			k = (int)((float)i/grass.size()*binCount);
			gr.fillStyle.g.X = pow(av[k],1.5)*10;
			gr.fillStyle.b.X = pow(av[k],1.5)*10;
			gr.fillStyle.r.X = pow(av[k],1.5)*10;
			gr.w.v.y += av[k]*0.5;
	  	}
	}
}

class RestartSong extends Event {
	RestartSong(int time) {
		this.time = time;
		this.timeEnd = time + 200;
	}

	void spawn() {
		println("RESTART");
		seekTo(0);
		mobs.clear();
		flowers.clear();
		rings.clear();
		tris.clear();
		grass.clear();
		for (Event event : events) {
			event.spawned = false;
			event.finished = false;
		}
	}
}