import 'package:flutter/material.dart';
import 'package:hotelreservation/Home/api/ReservationModel.dart';
import 'package:hotelreservation/Home/api/ReservationsApi.dart';
import 'package:url_launcher/url_launcher.dart';

class Reservations extends StatefulWidget {
  final String email;
  final String fullName;

  const Reservations({
    required this.email,
    required this.fullName,
    Key? key,
  }) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  late Future<List<Reservation>> futureReservations;

  @override
  void initState() {
    super.initState();
    futureReservations = getReserv();
  }

  Future<List<Reservation>> getReserv() async {
    ReservationsApi reservationsApi = ReservationsApi();
    var response = await reservationsApi.getReservations();

    // Parse JSON data after receiving the response
    List<Reservation> allReservations = parseReservations(response.body);

    // Filter reservations based on the user's email
    List<Reservation> userReservations = allReservations
        .where((reservation) => reservation.fullName == widget.fullName)
        .toList();

    return userReservations;
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "http", host: url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "err";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to handle the asynchronous loading of data
    return Scaffold(
      body: FutureBuilder<List<Reservation>>(
        future: futureReservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that occurred during the data fetching
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Display the data when it is available
            List<Reservation> reservations = snapshot.data!;
            return ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('ID: ${reservations[index].id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Guest: ${reservations[index].fullName}'),
                      Text('Room Type: ${reservations[index].roomType}'),
                      Text('Hotel Name: ${reservations[index].hotelName}'),
                      Text(
                          'Room Number: ${reservations[index].roomNumber.toString()}'),
                      Text('Payment Type: ${reservations[index].paymentType}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    child: Text("Pay WithChapa"),
                    onPressed: () => {_launchURL('developer.chapa.co')},
                  ),

                  // Add more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
