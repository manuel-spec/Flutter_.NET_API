import 'package:flutter/material.dart';
import 'package:hotelreservation/Home/BookReservation.dart';
import 'package:hotelreservation/Home/CancelReservation.dart';
import 'package:hotelreservation/Home/Reservations.dart';
import 'package:hotelreservation/login_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({@required this.token, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  late String email, fullname;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
    fullname = jwtDecodedToken['unique_name'];
  }

  void _handleLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()), // Replace LoginScreen() with your actual login screen widget
    );
    // Implement your logout logic here, such as clearing user data, navigating to the login screen, etc.
    // For now, let's just print a message.
    print("User logged out!");
  }

  @override
  Widget build(BuildContext context) {
    Reservations reservations = Reservations(fullName: fullname, email: email);
    BookReservation bookReservation = BookReservation();
    CancelReservation cancelReservation = CancelReservation();

    return Scaffold(
      appBar: AppBar(title: Text(email)),
      body: [reservations, bookReservation, cancelReservation][selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.hotel), label: "Reservations"),
          NavigationDestination(icon: Icon(Icons.add), label: "Book"),
          NavigationDestination(
              icon: Icon(Icons.settings), label: "ChangePassword"),
          NavigationDestination(icon: Icon(Icons.logout), label: "Logout"),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            if (index == 3) {
              _handleLogout();
            } else {
              selectedIndex = index;
            }
          });
        },
      ),
    );
  }
}
