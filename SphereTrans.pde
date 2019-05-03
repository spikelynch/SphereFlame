
// what happens if we add rotateX?
// also to do - can we make the rotations smaller or larger with
// each iteration?

class SphereTrans {
    
    float dip;
    float twist;
    float scale;
    float thscale;

    SphereTrans(float d, float t, float s, float ts) {
	   dip = d;
	   twist = t;
	   scale = s;
       thscale = ts;
    }

    void apply(float radius, float thscale) {
	   rotateX(thscale * PI * twist / 180);
	   rotateY(thscale * PI * dip / 180);
	   scale(scale, scale, scale);
    }	

}
