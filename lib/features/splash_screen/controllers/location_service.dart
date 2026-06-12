class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  // Store latitude, longitude, and address
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _address = '......';

  // Getters for other classes to access
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get address => _address;

  // Setters to update values
  void setLocation(double lat, double lon, String address) {
    _latitude = lat;
    _longitude = lon;
    _address = address;
  }
}