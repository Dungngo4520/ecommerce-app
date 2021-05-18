import 'dart:convert';

class UserData {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final String username;
  final String photoURL;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.address,
    required this.username,
    required this.photoURL,
  });

  UserData copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? address,
    String? username,
    String? photoURL,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      username: username ?? this.username,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'photoURL': photoURL,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      username: map['username'],
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, phone: $phone, address: $address, username: $username, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.username == username &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        username.hashCode ^
        photoURL.hashCode;
  }
}
