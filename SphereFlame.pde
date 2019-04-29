import processing.opengl.*;
import processing.video.*;
import controlP5.*;

// todo -
// make an afftrans generate and bind its own control panel
// allow user to add new trans
// drag to rotate the results 
// controls to set the colours
// why are the control colours cycling like that?

Afflower aff;
AffDrawer ad;


color fg;
color bg;

Colours cbar;

float xrot = 0;
float yrot = 0;
float l_rot = 0.001;
int tick = 0;
float astep = 2;

float MOUSE_FACTOR = PI;

float d1;
float t1;
float d2;
float t2;
float s1;
float s2;
float a1;
float a2;

int x_m;
int y_m;
int x_s;
int y_s;
boolean track_m;

int amb_r = 64;
int amb_g = 64;
int amb_b = 64;
int dir_r = 255;
int dir_g = 255;
int dir_b = 255;
int dir_x = 0;
int dir_y = 0;
int dir_z = -5;

int W = 720;
int H = 640;
float xoff;
float yoff;
float zoff;
float radius;

int depth = 15;
int colours = 15;
int settingsn = 0;
boolean fullscreen = false;
boolean mousing = true;

ControlP5 cp5;

int c1d = 0;
int c1t = 0;
int c2d = 0;
int c2t = 0;
int c3d = 0;
int c3t = 0;

float K = PI / 20;

void setup() {

  size(720, 640, OPENGL);

  fg = color(55, 55, 55, 128);
  bg = color(0,20,80);

  // cbar = new Colours(colours, color(255, 128, 128, 128), color(192, 255, 192, 128));
  // cbar = new Colours(colours, color(255, 255, 255, 80), color(0, 0, 0, 20));

  // cbar = new Colours(colours, color(40, 40, 120, 120), color(255, 255, 255, 120));

  // red - brown

  cbar = new Colours(colours, color(255,192,192,90), color(96,192,240,90));
  //recolour();

  ad = new AffDrawer(1, int(H * 0.8), cbar);
  
  aff = new Afflower(2, ad);

  aff.trans(0, 0, 1, 0.7);
  aff.trans(0, 0, 1, 1.2);

  x_s = 0;
  y_s = 0;
  
  track_m = false;

  xoff = W * 0.5;
  yoff = H * 0.5;
  zoff = W * 0.7;
  radius = H * 0.40;
  background(bg);
  randomise();
 
  cp5 = new ControlP5(this);
  cp5.addSlider("c1d")
    .setPosition(40, 40)
    .setSize(200, 20)
    .setRange(0, 360)
    .setValue(0);
  cp5.addSlider("c1t")
    .setPosition(40, 60)
    .setSize(200, 20)
    .setRange(0, 360)
    .setValue(0);
  cp5.addSlider("c2d")
    .setPosition(40, 80)
    .setSize(200, 20)
    .setRange(0, 360)
    .setValue(0);
  cp5.addSlider("c2t")
    .setPosition(40, 100)
    .setSize(200, 20)
    .setRange(0, 360)
    .setValue(0);
}



void draw() {
  lights();
  pushMatrix();
  translate(xoff, yoff, -zoff); 
  rotateX(PI * xrot);
  rotateY(PI * yrot);
  axes();
  aff.render(radius, 1.0, depth);
  popMatrix();
  tick++;

  if( mousePressed ) {
    mouseRotate();
  }

  aff.trans[0].dip = c1d * K;
  aff.trans[0].twist = c1t * K ;
  aff.trans[1].dip = c2d * K;
  aff.trans[1].twist = c2t * K;
}


void mousePressed() {
	track_m = true;
	x_m = mouseX;
	y_m = mouseY;
}


void mouseReleased() {
  track_m = false;
  x_s += mouseX - x_m;
  y_s += mouseY - y_m;
}


void mouseRotate() {
      
  int x = x_s + mouseX - x_m;
  int y = y_s + mouseY - y_m;

  xrot = (float)x / (float)W * MOUSE_FACTOR;
  yrot = (float)y / (float)H * MOUSE_FACTOR;

}


int mb_w() {
    int w;
    if( mouseButton == LEFT  ) {
        return 0;
    } else if ( mouseButton == RIGHT ) {
	return 1;
    } else {
	return -1;
    }
}
    

void lights() {
    ambientLight(amb_r, amb_g, amb_b);

    dir_x = int(100 * cos(tick * l_rot));
    dir_z = int(100 * sin(tick * l_rot));
    dir_y = 40;

    directionalLight(dir_r, dir_g, dir_b, dir_x, dir_y, dir_z);
    background(bg);
}

void keyPressed() {
    if( key == ' ' ) {
	saveFrame("frame-####.png");
    } else if( key == 's' ) {
	saveSettings();
    } else if( key >= '0' && key <= '9' ) {
	loadSettings(key);
    } else if( key == 'a' ) {
	if( depth > 1 ) {
	    depth--;
	}
    } else if( key == 'z' ) {
	depth++;
    } else if( key == 'd' ) {
	if( colours > 2 ) {
	    colours--;
	    recolour();
	}
    } else if( key == 'c' ) {
	colours++;
	recolour();
    }

}


void axes() {
    strokeWeight(1);
    stroke(255, 255, 255, 128);
    line(0, 0, radius, 0, 0, -radius);
    line(0, radius, 0, 0, -radius, 0);
    line(radius, 0, 0, -radius, 0, 0);


}

void randomise() {

    d1 = random(-.5, .5);
    t1 = random(-.5, .5);
    d2 = random(-.5, .5);
    t2 = random(-.5, .5);
    s1 = .1;
    s2 = .1;
    a1 = PI * random(0.001, 0.01);
    a2 = PI * random(0.001, 0.01);

}


void recolour() {
  cbar = new Colours(colours, color(255, 255, 255, 40), color(0, 0, 80, 20));
  println("recolour " + colours);
}

void saveSettings() {
    String[] lines = new String[4];
    lines[0] = str(d1);
    lines[1] = str(t1);
    lines[2] = str(d2);
    lines[3] = str(t2);
    
    saveStrings("settings" + str(settingsn) + ".txt", lines);
    println("saved to " + settingsn);
    settingsn++;
    if( settingsn > 9 ) {
	settingsn = 0;
    }
}


void loadSettings(char n) {
    println("Loading " + n);
    String file = "settings" + n + ".txt";
    String lines[] = loadStrings(file);

    if( lines.length == 4 ) {
	d1 = Float.valueOf(lines[0]).floatValue();
	t1 = Float.valueOf(lines[1]).floatValue();
	d2 = Float.valueOf(lines[2]).floatValue();
	t2 = Float.valueOf(lines[3]).floatValue();
   }
}
