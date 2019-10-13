abstract class Mob {
	boolean finished = false;

	
	abstract void update();

	abstract void render();
}

class Triangle extends Mob {
	Point p;
	SpringValue scale = new SpringValue(1);
	float w;
	float h;
	Point ang = new Point();
	AColor fillStyle = new AColor(100,100,100,255);
	AColor strokeStyle = new AColor(100,100,100,255);

	Triangle(PVector p, PVector ang, float w) {
		this.p = new Point(p);
		this.ang = new Point(ang);
		this.w = w;
		this.h = w/10;
	}

	void update() {
		p.update();
		scale.update();
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
		pop();
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