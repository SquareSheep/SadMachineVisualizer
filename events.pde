class Event {
	boolean finished = false;
	boolean spawned = false;
	int time;
	int timeEnd;

	void update() {

	}

	void spawn() {

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
		for (Event event : events) {
			event.spawned = false;
			event.finished = false;
		}
	}
}