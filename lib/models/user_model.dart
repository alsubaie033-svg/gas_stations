enum UserRole { USER, ADMIN, DELIVERY }

class UserModel {
  String? id;
  String? name;
  String? password; // In real app, hash this
  String? address;
  String? phoneNumber;
  String? email;
  double? latitude;
  double? longitude;
  UserRole role;

  UserModel({
    this.id,
    this.name,
    this.password,
    this.address,
    this.phoneNumber,
    this.email,
    this.latitude,
    this.longitude,
    this.role = UserRole.USER, // Default role
  });

  /// --- fromJson ---
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      latitude: (json['latitude'] != null)
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude: (json['longitude'] != null)
          ? (json['longitude'] as num).toDouble()
          : null,
      role: _roleFromString(json['role']),
    );
  }

  /// --- toJson ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
      'role': role.toString().split('.').last, // Save enum as string
    };
  }

  /// --- Helper to parse role from string ---
  static UserRole _roleFromString(dynamic role) {
    if (role == null) return UserRole.USER;
    switch (role.toString().toUpperCase()) {
      case 'ADMIN':
        return UserRole.ADMIN;
      case 'DELIVERY':
        return UserRole.DELIVERY;
      default:
        return UserRole.USER;
    }
  }
}


// enum UserRole { user, chatbot }

// class UserModel {
//   String id;
//   String name;
//   String address;
//   String phoneNumber;
//   String email;
//   double latitude;
//   double longitude;
//   UserRole role;

//   UserModel({
//     required this.id,
//     required this.name,
//     this.address = '',
//     this.phoneNumber = '',
//     this.email = '',
//     this.latitude = 0.0,
//     this.longitude = 0.0,
//     this.role = UserRole.user,
//   });

//   // Factory constructor for creating a new UserModel from a map
//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id'] ?? '',
//       name: data['name'] ?? '',
//       address: data['address'] ?? '',
//       phoneNumber: data['phoneNumber'] ?? '',
//       email: data['email'] ?? '',
//       latitude: data['latitude']?.toDouble() ?? 0.0,
//       longitude: data['longitude']?.toDouble() ?? 0.0,
//       role: UserRole.values.firstWhere(
//         (e) => e.toString() == 'UserRole.${data['role']}',
//         orElse: () => UserRole.user,
//       ),
//     );
//   }

//   // Convert UserModel to a map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'address': address,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'latitude': latitude,
//       'longitude': longitude,
//       'role': role.toString().split('.').last,
//     };
//   }
// }
