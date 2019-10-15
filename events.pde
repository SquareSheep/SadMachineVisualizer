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

class Anyone000s003 extends Event {

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