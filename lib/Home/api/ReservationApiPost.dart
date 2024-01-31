import 'dart:convert';
import 'package:http/http.dart' as http;

class ReservationApiPost {
  static const String baseUrl = 'http://10.240.69.222:2020/hotel';

  Future<http.Response> BookReservation(String fullName, String roomType,
      String hotelName, int roomNumber, String paymentType) async {
    final String apiUrl = '$baseUrl';

    try {
      // Set check-in date as today
      DateTime now = DateTime.now();
      String checkInDate = now.toIso8601String();

      // Set check-out date as three days later
      DateTime checkOutDateTime = now.add(Duration(days: 3));
      String checkOutDate = checkOutDateTime.toIso8601String();

      // Prepare data to send in the request body
      Map<String, dynamic> requestData = {
        'fullName': fullName,
        'roomType': roomType,
        'hotelName': hotelName,
        'roomNumber': roomNumber,
        'checkInDate': checkInDate,
        'checkOutDate': checkOutDate,
        'paymentType': paymentType,
      };

      // Send POST request
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      return response;
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return http.Response('Error occurred', 500);
    }
  }
}
