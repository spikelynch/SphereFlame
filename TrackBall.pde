// This TrackBall class allows rotating 3D objects by dragging.

// based on https://discourse.processing.org/t/trackball-rotating-3d-objects-by-dragging-mouse/3834
// Inspired by
// https://stackoverflow.com/questions/11314384/virtual-trackball-implementation
// Using Toxiclibs for the Quaternion.


import toxi.geom.*;


class TrackBall {
  public PMatrix3D rotationMat;
  public Vec2D pos = new Vec2D();

  private int frameCountDragging;
  private Quaternion rotationQuat, tempQuat;

  TrackBall() {
    rotationQuat = new Quaternion();
    tempQuat = new Quaternion();
    rotationMat = new PMatrix3D();
  }

  // Specify the 2D coordinates of the object in the screen
  // This could be upgraded to 3D eventually.
  public void setPos(float x, float y) {
    pos.set(x, y);
  }

  // Call this method when dragging the mouse
  // with previous and current mouse position
  public void drag(int x0, int y0, int x1, int y1) {
    Vec3D v2 = project(x0 - pos.x, y0 - pos.y);
    Vec3D v1 = project(x1 - pos.x, y1 - pos.y);
  
    float dt = constrain(v1.distanceTo(v2) / width, -1, 1);

    Vec3D n = v2.cross(v1).normalizeTo(dt); 

    if (frameCountDragging++ == 50) { 
      frameCountDragging = 0;
      rotationQuat.normalize();
    }

    rotationQuat = tempQuat
      .set(cos(asin(dt)), n)
      .multiply(rotationQuat);
    rotationMat.set(rotationQuat.toMatrix4x4().toFloatArray(null));
  }

  private Vec3D project (float x, float y) {
    float radius = width / 2;

    Vec3D v = new Vec3D(x, y, 0);

    float len = v.magnitude();
    float tr = radius / sqrt(2);

    v.z = len < tr ? sqrt(radius * radius - len * len) : tr * tr / len;

    return v;
  }
}