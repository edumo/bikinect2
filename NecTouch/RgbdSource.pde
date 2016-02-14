public interface RgbdSource {

  void alternativeViewPointDepthToImage();

  void setMirror(Boolean mirrorMode);

  int depthWidth();

  int depthHeight();

  void update();

  PImage rgbImage();

  int[] depthMap();

  PImage depthImage();

  void init(PApplet parent);

}


public class Kinect2 implements RgbdSource {

  KinectPV2 kinect;

  int[] depthZero;

  // BUFFER ARRAY TO CLEAN DE PIXLES
  PImage depthToColorImg;

  PImage depth = null;

  public void init(PApplet parent) {

    depthToColorImg = parent.createImage(512, 424, PImage.RGB);
    depthZero = new int[KinectPV2.WIDTHDepth * KinectPV2.HEIGHTDepth];

    // SET THE ARRAY TO 0s
    for (int i = 0; i < KinectPV2.WIDTHDepth; i++) {
      for (int j = 0; j < KinectPV2.HEIGHTDepth; j++) {
        depthZero[424 * i + j] = 0;
      }
    }

    kinect = new KinectPV2(parent);
    // kinect.enableDepthImg(true);
    kinect.enableInfraredImg(true);
    // kinect.enableColorImg(true);
    // kinect.activateRawDepth(true);
    // kinect.activateRawColor(true);
    kinect.enablePointCloud(true);
    kinect.init();

  }

  @Override
  public void alternativeViewPointDepthToImage() {

  }

  @Override
  public void setMirror(Boolean mirrorMode) {
    // kinect.
  }

  @Override
  public int depthWidth() {
    return KinectPV2.WIDTHDepth;
  }

  @Override
  public int depthHeight() {
    return KinectPV2.HEIGHTDepth;
  }

  @Override
  public void update() {

    depth = null;
   
  }

  @Override
  public PImage rgbImage() {
    return kinect.getInfraredImage();// kinect.getColorImage();
  }

  @Override
  public int[] depthMap() {
    if (depth == null) {
      depth = kinect.getPointCloudDepthImage();
      depth.loadPixels();
    }
    return depth.pixels;
  }

  @Override
  public PImage depthImage() {
    if (depth != null) {
      depth = kinect.getPointCloudDepthImage();
    }
    return depth;
  }

}