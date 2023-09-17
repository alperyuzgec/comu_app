// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int id;
  String firstName;
  String lastName;
  int age;
  String gender;
  String email;
  String phone;
  DateTime birthDate;
  String image;
  String bloodGroup;
  Address address;
  String username;
  String university;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.address,
    required this.username,
    required this.university,
  });

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    DateTime? birthDate,
    String? image,
    String? bloodGroup,
    Address? address,
    String? username,
    String? university,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      image: image ?? this.image,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      address: address ?? this.address,
      username: username ?? this.username,
      university: university ?? this.university,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'email': email,
      'phone': phone,
      'birthDate': birthDate.toString(),
      'image': image,
      'bloodGroup': bloodGroup,
      'address': address.toMap(),
      'username': username,
      'university': university,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      image: map['image'] as String,
      bloodGroup: map['bloodGroup'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      username: map['username'] as String,
      university: map['university'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, age: $age, gender: $gender, email: $email, phone: $phone, birthDate: $birthDate, image: $image, bloodGroup: $bloodGroup, address: $address, username: $username, university: $university)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.age == age &&
        other.gender == gender &&
        other.email == email &&
        other.phone == phone &&
        other.birthDate == birthDate &&
        other.image == image &&
        other.bloodGroup == bloodGroup &&
        other.address == address &&
        other.username == username &&
        other.university == university;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        gender.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        birthDate.hashCode ^
        image.hashCode ^
        bloodGroup.hashCode ^
        address.hashCode ^
        username.hashCode ^
        university.hashCode;
  }
}

class Address {
  String address;
  String city;
  Coords coordinates;
  String postalCode;
  String state;
  Address({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });

  Address copyWith({
    String? address,
    String? city,
    Coords? coordinates,
    String? postalCode,
    String? state,
  }) {
    return Address(
      address: address ?? this.address,
      city: city ?? this.city,
      coordinates: coordinates ?? this.coordinates,
      postalCode: postalCode ?? this.postalCode,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'coordinates': coordinates.toMap(),
      'postalCode': postalCode,
      'state': state,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address: map['address'] as String,
      city: map['city'] as String,
      coordinates: Coords.fromMap(map['coordinates'] as Map<String, dynamic>),
      postalCode: map['postalCode'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(address: $address, city: $city, coordinates: $coordinates, postalCode: $postalCode, state: $state)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.city == city &&
        other.coordinates == coordinates &&
        other.postalCode == postalCode &&
        other.state == state;
  }

  @override
  int get hashCode {
    return address.hashCode ^ city.hashCode ^ coordinates.hashCode ^ postalCode.hashCode ^ state.hashCode;
  }
}

class Coords {
  double lat;
  double lng;
  Coords({
    required this.lat,
    required this.lng,
  });

  Coords copyWith({
    double? lat,
    double? lng,
  }) {
    return Coords(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    return Coords(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coords.fromJson(String source) => Coords.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Coords(lat: $lat, lng: $lng)';

  @override
  bool operator ==(covariant Coords other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
