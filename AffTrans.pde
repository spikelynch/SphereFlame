class AffTrans {
    
    float dip;
    float twist;
    float scale;

    AffTrans(float d, float t, float s) {
	   dip = d;
	   twist = t;
	   scale = s;
    }

    void apply(float radius) {
	   rotateZ(PI * twist / 180);
	   rotateY(PI * dip / 180);
	   //scale(scale, scale, scale);
    }	

}
