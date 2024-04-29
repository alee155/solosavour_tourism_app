import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StuffDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? stuffData;

  const StuffDetailsScreen({super.key, required this.stuffData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text(
            'Detail Screen',
            style: TextStyle(fontSize: 22.sp, color: Colors.white),
          ),
        ),
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
                color: Colors.teal,
                child: Image.network(
                  stuffData?['imageUrl'], // Use stuffData to get image URL
                  fit: BoxFit.scaleDown, // Adjust the image fit as needed
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Stuff Name', stuffData?['stuffName']),
              _buildDetailRow('Price', 'Rs ${stuffData?['stuffPrice']}'),
              _buildDetailRow('Booking Timing', stuffData?['bookingTiming']),
              _buildDetailRow(
                  'Returning Timing', stuffData?['returningTiming']),
              _buildDetailRow('Stuff Quality', stuffData?['stuffQuality']),
              _buildDetailRow(
                  'Stuff Quantities', stuffData?['stuffQuantities']),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String heading, String? data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.info,
              color: Colors.black,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              heading,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Text(
          data ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
