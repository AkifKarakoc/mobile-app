import 'package:permission_handler/permission_handler.dart' as ph;

Future<bool> requestCameraPermission() async {
  final status = await ph.Permission.camera.request();
  return status.isGranted;
}

Future<bool> requestLocationPermission() async {
  final status = await ph.Permission.location.request();
  return status.isGranted;
}

Future<bool> checkCameraPermission() async {
  final status = await ph.Permission.camera.status;
  return status.isGranted;
}

Future<bool> checkLocationPermission() async {
  final status = await ph.Permission.location.status;
  return status.isGranted;
}

Future<bool> openAppSettings() async {
  return await ph.openAppSettings();
}
