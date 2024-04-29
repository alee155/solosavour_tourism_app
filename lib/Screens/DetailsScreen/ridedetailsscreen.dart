import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RideDetailsScreen extends StatelessWidget {
  final DocumentSnapshot ride;

  const RideDetailsScreen({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // Shadow position
              ),
            ],
          ),
          height: 600,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 300,
                color: Colors.blue,
                child: Image.network(
                  ride['imageUrl'], // Use ride data to display image
                  fit: BoxFit.cover, // Adjust the image fit as needed
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailItem(
                        'Car Name', ride['carName'], Icons.directions_car),
                    _buildDetailItem('Car Number', ride['carNumber'],
                        Icons.confirmation_number),
                    _buildDetailItem(
                        'Drop Point', ride['dropPoint'], Icons.pin_drop),
                    _buildDetailItem(
                        'Pickup Point', ride['pickupPoint'], Icons.location_on),
                    _buildDetailItem(
                        'Price', ride['price'], Icons.attach_money),
                    _buildDetailItem('Seats Available', ride['seatsAvailable'],
                        Icons.event_seat),
                    _buildDetailItem(
                        'Phone Number', ride['phoneNumber'], Icons.phone),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String heading, String data, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: Colors.black,
          size: 24,
        ),
        const SizedBox(width: 10),
        Text(
          heading,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          data,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
