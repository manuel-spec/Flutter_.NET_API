import 'package:hotelreservation/Home/api/ReservationModel.dart';
import 'package:http/http.dart' as http;

class ReservationsApi {
  static const String baseUrl = 'http://10.240.69.222:2020';

  Future<http.Response> getReservations() async {
    final String apiUrl = '$baseUrl/hotel';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
      );
      print(response.body);

      List<Reservation> reservations = parseReservations(response.body);

      return response;
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return http.Response('Error occurred', 500);
    }
  }
}
