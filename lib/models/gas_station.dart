// gas_station.dart
import 'fuel_type.dart';

class GasStation {
  int stationId;
  String name;
  String phoneNumber;
  String location;
  List<FuelType> fuelTypes;

  GasStation({
    required this.stationId,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.fuelTypes,
  });

  // --- Update fuel availability ---
  void updateFuelAvailability(String fuelName, bool availability) {
    for (var fuel in fuelTypes) {
      if (fuel.name == fuelName) {
        fuel.setAvailability(availability);
        break;
      }
    }
  }

  // --- From JSON ---
  factory GasStation.fromJson(Map<String, dynamic> json) {
    return GasStation(
      stationId: json['stationId'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      location: json['location'],
      fuelTypes: (json['fuelTypes'] as List<dynamic>)
          .map((item) => FuelType.fromJson(item))
          .toList(),
    );
  }

  // --- To JSON ---
  Map<String, dynamic> toJson() {
    return {
      'stationId': stationId,
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
      'fuelTypes': fuelTypes.map((f) => f.toJson()).toList(),
    };
  }
}
