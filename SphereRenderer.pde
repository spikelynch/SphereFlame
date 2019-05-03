

class SphereRenderer {

    int w;
    Colours col; 
    int radius;
    int style;

    SphereRenderer(int w0, int r0, Colours c0) {
		w = w0;
		col = c0;
		radius = r0;
    }

    void draw(int depth, float size) {
	 	cubes(depth, size);
    }

    void dot(int depth, float size) {
		pushMatrix();
		translate(0, 0, radius);
		strokeWeight(w * depth * 0.2);
		//stroke(col.nextlerp());
		stroke(col.lerp(depth));
		point(0, 0, 0);
		popMatrix();
    }

    void cubes(int depth, float size) {
		pushMatrix();
		translate(0, 0, radius);
		noStroke();
		//stroke(col.nextlerp());
		fill(col.lerp(depth));
		box(w * depth * 0.2);
		popMatrix();
    }


    void ball(int depth, float size) {
		pushMatrix();
		translate(0, 0, radius);
		strokeWeight(3);
		fill(col.nextlerp());
		sphere(w);
		popMatrix();
    }
    


}
