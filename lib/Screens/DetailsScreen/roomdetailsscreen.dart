import 'package:flutter/material.dart';

class RoomDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const RoomDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Room Details Screen',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
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
                  data['imageUrl'] ?? '', // Use the image URL from Firestore
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailItem('Room Name:', data['roomName'] ?? ''),
                    _buildDetailItem('Room Number:', data['roomNumber'] ?? ''),
                    _buildDetailItem(
                        'Room Address:', data['roomAddress'] ?? ''),
                    _buildDetailItem('Check In:', data['checkIn'] ?? ''),
                    _buildDetailItem('Check Out:', data['checkOut'] ?? ''),
                    _buildDetailItem(
                        'Number of rooms:', data['numOfRooms'] ?? ''),
                    _buildDetailItem('Seats:', data['seats'] ?? ''),
                    _buildDetailItem('Room Size:', data['roomSize'] ?? ''),
                    _buildDetailItem(
                        'Room Condition:', data['roomCondition'] ?? ''),
                    _buildDetailItem(
                        ' Owner Phone :', data['roomOwnerNumber'] ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String heading, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
