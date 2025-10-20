import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Check if location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Check and request location permissions
  static Future<LocationPermission> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return permission;
  }

  // Get current position
  static Future<Position> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      // Check permissions
      LocationPermission permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }

      // Get current position
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // high, medium, low
        timeLimit: Duration(seconds: 10), // Timeout
      );
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }
}
