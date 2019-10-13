abstract class Mob {
	boolean finished = false;

	
	abstract void update();

	abstract void render();
}

class Tunnel extends Mob {
	Point p;
	Point ang = new Point(0,0,0);
	ArrayList<Wave> waves = new ArrayList<Wave>();

	Tunnel(PVector p, PVector w, int num, int num2) {
		this.p = new Point(p);
		for (int i = 0 ; i < num ; i ++) {
			float angle = -(float)i/num*PI*0.8 + PI*0.35;
			waves.add(new Wave(new PVector(cos(angle)*w.x/2,sin(angle)*w.y/2,0), w.z, num2));
		}
		for (int i = 0 ; i < num ; i ++) {
			float angle = (float)i/num*PI*0.8 + PI*0.65;
			waves.add(new Wave(new PVector(cos(angle)*w.x/2,sin(angle)*w.y/2,0), w.z, num2));
		}
	}

	void update() {
		for (int i = 0 ; i < waves.size() ; i ++) {
			Wave wave = waves.get(i);
			wave.update();
		}
	}

	void render() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		for (int i = 0 ; i < waves.size() - 1 ; i ++) {
			Wave w1 = waves.get(i);
			w1.render();
			// Wave w2 = waves.get(i + 1);
			// fill(255);
			// for (int k = 0 ; k < w1.points.size() ; k ++) {
			// 	Spoint p1 = w1.points.get(k);
			// 	Spoint p2 = w2.points.get(k);
			// 	push();
			// 	translate(p1.p.p.x, p1.p.p.y, p1.p.p.z);
			// 	line(w1.p.p.x, w1.p.p.y, w1.p.p.z, p2.p.p.x + w2.p.p.x, p2.p.p.x + w2.p.p.x, p2.p.p.x + w2.p.p.x);
			// 	pop();
			// }
		}
		pop();
	}
}

class Wave extends Mob {
	Point p;
	Point ang = new Point(0,0,0);
	SpringValue w;
	ArrayList<Spoint> points = new ArrayList<Spoint>();

	Wave(PVector p, float w, int num) {
		this.p = new Point(p);
		this.w = new SpringValue(w);
		for (int i = 0 ; i < num ; i ++) {
			points.add(new Spoint(0,0,(float)i/num*w, (int)((float)i/num*binCount)));
		}

	}

	void update() {
		p.update();
		ang.update();
		w.update();
		for (int i = 0 ; i < points.size() ; i ++) {
			Spoint point = points.get(i);
			if (i % 2 == 0) {
				point.p.v.y -= av[point.index]/2;
			} else {
				point.p.v.y += av[point.index]/2;
			}
			point.update();
		}
	}
	
	void render() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		for (int i = 0 ; i < points.size() - 1 ; i ++) {
			Spoint p1 = points.get(i);
			Spoint p2 = points.get(i + 1);
			p1.strokeStyle.strokeStyle();
			line(p1.p.p.x, p1.p.p.y, p1.p.p.z, p2.p.p.x, p2.p.p.y, p2.p.p.z);
		}
		pop();
	}
}

class Spoint {
	Point p;
	AColor strokeStyle = new AColor(100,100,100,255);
	int index;

	Spoint(float x, float y, float z, int index) {
		this.p = new Point(x, y, z);
		this.index = index;
	}

	void update() {
		p.update();
		strokeStyle.update();
	}
}

class TextBox extends Mob {
	String string = "";
	Point p;
	SpringValue ang = new SpringValue(0);
	AColor fillStyle = new AColor(255,255,255,255);
	AColor strokeStyle = new AColor(255,255,255,255);
	int timeEnd;

	TextBox(String string, Point p, int timeEnd) {
		this.string = string;
		this.p = p.copy();
		this.timeEnd = timeEnd;
	}

	TextBox(String string, float x, float y, float z, int timeEnd) {
		this.string = string;
		this.p = new Point(x, y, z);
		this.timeEnd = timeEnd;
	}

	void update() {
		p.update();
		ang.update();
		if (currTime > timeEnd) finished = true;
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y);
		rotate(ang.x);
		text(string, 0,0);
		pop();
	}

	void addText(String string) {
		this.string += string;
	}
}

class Box3d extends Mob {
	Point p;
	Point w;
	Point ang;
	PVector dang;
	PVector dp;
	PVector dw;
	AColor fillStyle = new AColor(100,100,100,100);
	AColor strokeStyle = new AColor(100,100,100,100);
	int i;


	Box3d(Point p, Point w) {
		println(p.p.x + " " + p.p.y + " " + p.p.z);
		this.p = p.copy();
		this.w = w;
		this.ang = new Point();
		this.dp = p.p.copy();
		this.dang = new PVector();
		this.dw = w.p.copy();
	}

	Box3d(Point p, Point w, Point ang) {
		this.p = p.copy();
		this.w = w;
		this.ang = ang.copy();
		this.dang = ang.p.copy();
		this.dp = p.p.copy();
		this.dw = w.p.copy();
	}

	void update() {
		p.update();
		w.update();
		ang.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		box(w.p.x, w.p.y, w.p.z);
		pop();
	}
}