class OfferData {
  final String imageUrl;
  final String offername;
  final String typeoffer;
  final int numberofpoints;
  final String deviceType;
  final bool AndroidDevice;
  final bool ComputerDevice;
  OfferData({
    required this.typeoffer,
    required this.imageUrl,
    required this.offername,
    this.numberofpoints = 0,
    required this.deviceType,
    required this.AndroidDevice,
    required this.ComputerDevice,
  });
}

class SpecialOfferData {
  final String offername;
  final String typeoffer;
  final String imageUrl;
  final bool AndroidDevice;
  final bool ComputerDevice;
  SpecialOfferData({
    required this.imageUrl,
    required this.offername,
    required this.typeoffer,
    required this.AndroidDevice,
    required this.ComputerDevice,
  });
}

class OfferWallData {
  final String imageUrl;
  const OfferWallData({required this.imageUrl});
}

class ActivityBarData {
  final String txt1;
  final String txt2;
  final int number;
  ActivityBarData({
    required this.txt1,
    required this.txt2,
    required this.number,
  });
}
