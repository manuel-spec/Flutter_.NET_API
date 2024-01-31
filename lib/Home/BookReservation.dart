import 'package:flutter/material.dart';
import 'package:hotelreservation/Home/api/ReservationApiPost.dart';
import 'package:hotelreservation/widgets/gradient_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotelreservation/widgets/login_field.dart';

class BookReservation extends StatefulWidget {
  const BookReservation({super.key});

  @override
  State<BookReservation> createState() => _BookReservationState();
}

class _BookReservationState extends State<BookReservation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController guestNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController checkInDateController = TextEditingController();
  TextEditingController checkOutDateController = TextEditingController();
  TextEditingController paymentTypeController = TextEditingController();
  bool isLoading = false;

  void reserveBook() async {
    setState(() {
      isLoading = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      ReservationApiPost reservationApi = ReservationApiPost();
      String fullName = fullNameController.text;
      String roomType = roomTypeController.text;
      String hotelName = hotelNameController.text;
      int roomNumber = int.tryParse(roomNumberController.text) ?? 0;
      String paymentType = paymentTypeController.text;

      var response = await reservationApi.BookReservation(
        fullName,
        roomType,
        hotelName,
        roomNumber,
        paymentType,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode < 300) {
        Fluttertoast.showToast(
          msg: "Reservation Added Successfully !!",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to add reservation. Please try again.",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18,
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'Reserve',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Full Name',
                  controller: fullNameController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Room Type',
                  controller: roomTypeController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Hotel Name',
                  controller: hotelNameController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Room Number',
                  controller: roomNumberController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Payment Type',
                  controller: paymentTypeController,
                ),
                const SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : GradientButton(
                        onPressed: reserveBook,
                        text: 'Book',
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
