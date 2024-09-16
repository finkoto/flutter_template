/// Consolidates raster image paths used across the app
class ImagePaths {
  static const root = 'assets';
  static const images = '$root/images';
  static const icons = '$root/icons';

  static const appLogo = '$images/app-logo.png';
  static const appLogoPlain = '$images/app-logo-plain.png';
  static const pageNotFound = '$images/page-not-found.png';
}

/// Consolidates SCG image paths in their own class, hints to the UI to use an
/// SvgPicture to render
class SvgPaths {}

/// Intro specific assets
class IntroImagePaths {
  static const root = 'intro';
  static const moonCrescent = '${ImagePaths.images}/$root/moon-crescent.png';
  static const sunRed = '${ImagePaths.images}/$root/sun-red.png';
  static const sunYellow = '${ImagePaths.images}/$root/sun-yellow.png';

  static String bgImage(String color) {
    return '${ImagePaths.images}/$root/bg-$color.png';
  }

  static String illustrationImage(String color) {
    return '${ImagePaths.images}/$root/illustration-$color.png';
  }

  static String sliderImage(String color) {
    return '${ImagePaths.images}/$root/slider-$color.png';
  }
}
