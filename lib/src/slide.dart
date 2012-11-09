part of presentation;

/// A slide of content for presentation.
class Slide extends ThreeDimensionalObj {
  Element element;
  bool inFocus;
  
  Slide(this.element, num scale, num x, num y, num z, num h, num p, num r) : super(scale, x, y, z, h, p, r)
  {
    this.element.classes.add("object");
    this.element.style
    ..position = "absolute"
    ..transformStyle = "preserve-3d";
    this.setTransform();
  }
  
  /// Reposition the virtual camera to a new place and rotation
  void move(num time, num x, num y, num z, num xr, num yr, num zr)
  {
    this.position
    ..x = x
    ..y = y
    ..z = z;
    this.rotation
    ..x = xr
    ..y = yr
    ..z = zr;
    this.element.style   
    ..transition = "${time}s";
    this.setTransform();
  }
  
  /// Reposition and reorient the slide within the scene to center it in front of the camera
  void moveToCamera(num time, Camera cam)
  {
    //move slide toward camera, compensating for height and width of the slide
    var x = cam.position.x - this.element.clientWidth / 2;
    var y = cam.position.y - this.element.clientHeight / 2;
    this.move(time, x, y, cam.position.z, cam.rotation.x, cam.rotation.y, cam.rotation.z);
  }

  setTransform()
  {
    //var xOffset = element.clientWidth ~/ 2;
    //var yOffset = element.clientHeight ~/ 2;
    //element.style.transform = "scale($scale) translateX(${(position.x-xOffset).toInt()}px) translateY(${(position.y-yOffset).toInt()}px) translateZ(${position.z.toInt()}px) rotateX(${rotation.x.toInt()}deg) rotateY(${rotation.y.toInt()}deg) rotateZ(${rotation.z.toInt()}deg)";
    // height and width report as 0 here for some reason
    element.style.transform = this.transformString;
  }

  /**
   * Performs actions when this slide gains focus
   * Returns the duration of the actions performed
   */
  num onGainFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
      if (inFocus)
        return 0;
      element.style
      ..transition ="opacity ${transitionDuration}s ease-in-out"
      ..opacity = "1.0";
      inFocus = true;
  }
  
  /**
   *  Performs actions when this slide loses focus
   *  Returns the duration of the actions performed
   */
  num onLoseFocus([num transitionDuration = 0.7, SlideShow slideShow])
  {
      if (!inFocus)
        return 0;
      element.style
      ..transition ="opacity ${transitionDuration}s ease-in-out"
      ..opacity = "0.4";
      inFocus = false;
  }
}