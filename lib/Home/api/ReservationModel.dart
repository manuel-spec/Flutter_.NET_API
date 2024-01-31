import 'dart:convert';

class Reservation {
  final String id;
  final String fullName;
  final String roomType;
  final String hotelName;
  final int roomNumber;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String paymentType;

  Reservation({
    required this.id,
    required this.fullName,
    required this.roomType,
    required this.hotelName,
    required this.roomNumber,
    required this.checkInDate,
    required this.checkOutDate,
    required this.paymentType,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      fullName: json['fullName'],
      roomType: json['roomType'],
      hotelName: json['hotelName'],
      roomNumber: json['roomNumber'],
      checkInDate: DateTime.parse(json['checkInDate']),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      paymentType: json['paymentType'],
    );
  }
}

List<Reservation> parseReservations(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Reservation>((json) => Reservation.fromJson(json)).toList();
}
