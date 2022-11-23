import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum PaymentMethod {
  paypal('assets/images/payment/paypal.png'),
  visa('assets/images/payment/visa.png'),
  payoneer('assets/images/payment/payoneer.png');

  final String path;

  const PaymentMethod(this.path);
}

class FUser extends Equatable {
  const FUser({
    required this.id,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.isVerified,
    this.method,
    this.photo,
    this.location,
  });

  final String id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final bool? isVerified;
  final PaymentMethod? method;
  final String? photo;
  final String? location;

  static const empty = FUser(id: '');

  bool get isEmpty => this == FUser.empty;
  bool get isNotEmpty => this != FUser.empty;
  bool get isSetupComplete {
    if (phone == null ||
        firstName == null ||
        lastName == null ||
        isVerified == null ||
        method == null ||
        photo == null ||
        location == null) {
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
      method,
      photo,
      location,
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
    PaymentMethod? method,
    String? photo,
    String? location,
  }) {
    return FUser(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isVerified: isVerified ?? this.isVerified,
      method: method ?? this.method,
      photo: photo ?? this.photo,
      location: location ?? this.location,
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
      'method': method?.name,
      'photo': photo,
      'location': location,
    };
  }

  factory FUser.fromMap(Map<String, dynamic> map) {
    return FUser(
      id: map['id'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
      method: map['method'] != null
          ? PaymentMethod.values.byName(map['method'])
          : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FUser.fromJson(String source) =>
      FUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
