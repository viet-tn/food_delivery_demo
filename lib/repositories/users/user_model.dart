import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'coordinate.dart';

class FUser extends Equatable {
  const FUser({
    required this.id,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.isVerified,
    this.photo,
    this.coordinates = const <Coordinate>[],
  });

  final String id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final bool? isVerified;
  final String? photo;
  final List<Coordinate> coordinates;

  static const empty = FUser(id: '');

  bool get isEmpty => this == FUser.empty;
  bool get isNotEmpty => this != FUser.empty;
  bool get isSetupComplete {
    if (phone == null ||
        firstName == null ||
        lastName == null ||
        isVerified == null ||
        photo == null ||
        coordinates.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  List<Object?> get props {
    return [
      id,
      email,
      phone,
      firstName,
      lastName,
      isVerified,
      photo,
      coordinates,
    ];
  }

  factory FUser.fromUserCredential(UserCredential credential) {
    return FUser(
      id: credential.user!.uid,
      email: credential.user?.email,
    );
  }

  static FUser? fromUser(User? user) {
    if (user != null) {
      return FUser(
        id: user.uid,
        email: user.email!,
      );
    }
    return null;
  }

  FUser copyWith({
    String? id,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    bool? isVerified,
    String? photo,
    List<Coordinate>? coordinates,
  }) {
    return FUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isVerified: isVerified ?? this.isVerified,
      photo: photo ?? this.photo,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'isVerified': isVerified,
      'photo': photo,
      'locations': coordinates.map((x) => x.toMap()).toList(),
    };
  }

  factory FUser.fromMap(Map<String, dynamic> map) {
    return FUser(
      id: map['id'] as String,
      email: map['email'],
      phone: map['phone'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      isVerified: map['isVerified'],
      photo: map['photo'] != null ? map['photo'] as String : null,
      coordinates: List<Coordinate>.from(
        map['locations'].map<Coordinate>(
          (x) => Coordinate.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
