
class SphereFractal {

    SphereTrans[] trans;
    int n;
    int i0 = 0;

    SphereFractal(int n0) {
		n = n0;
		trans = new SphereTrans[n];
    }

    void trans(float d, float t, float s, float ts) {
		trans[i0] = new SphereTrans(d, t, s, ts);
		i0++;
    }

    void render(SphereRenderer renderer, float radius, float scale, int depth) {
		renderer.draw(depth, radius);
		if( depth > 0 ) {
	    	for( int i = 0; i < n; i++ ) {
				pushMatrix();
				trans[i].apply(radius, scale);
				this.render(renderer, radius * trans[i].scale, scale * trans[i].thscale, depth - 1);
				popMatrix();
	    	}
		}
    }

}
