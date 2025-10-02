// fuel_type.dart
class FuelType {
  String name;
  double price;
  bool isAvailable;

  FuelType({
    required this.name,
    required this.price,
    required this.isAvailable,
  });

  // --- Update availability ---
  void setAvailability(bool availability) {
    isAvailable = availability;
  }

  // --- From JSON ---
  factory FuelType.fromJson(Map<String, dynamic> json) {
    return FuelType(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      isAvailable: json['isAvailable'] ?? false,
    );
  }

  // --- To JSON ---
  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'isAvailable': isAvailable,};
  }
}
