import 'package:flutter/material.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> foodDetails;

  const FoodDetailsScreen({super.key, required this.foodDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(foodDetails['foodName']),
      ),
      body: Container(
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
                foodDetails['imageUrl'], // Use imageUrl from passed data
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Food Name', foodDetails['foodName'], Colors.black,
                Colors.green),
            _buildDetailRow('Food Timing', foodDetails['foodTiming'],
                Colors.black, Colors.green),
            _buildDetailRow('Food Delivery', foodDetails['delivery'],
                Colors.black, Colors.green),
            _buildDetailRow('Location', foodDetails['location'], Colors.black,
                Colors.green),
            _buildDetailRow(
                'Number of People',
                foodDetails['noOfPeople'].toString(),
                Colors.black,
                Colors.green),
            _buildDetailRow('Phone Number', foodDetails['phoneNumber'],
                Colors.black, Colors.green),
            _buildDetailRow('Price', foodDetails['price'].toString(),
                Colors.black, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String heading, String? data, Color headingColor, Color dataColor) {
    IconData iconData;
    switch (heading) {
      case 'Food Name':
        iconData = Icons.fastfood;
        break;
      case 'Food Timing':
        iconData = Icons.access_time;
        break;
      case 'Food Delivery':
        iconData = Icons.local_shipping;
        break;
      case 'Location':
        iconData = Icons.location_on;
        break;
      case 'Number of People':
        iconData = Icons.group;
        break;
      case 'Phone Number':
        iconData = Icons.phone;
        break;
      case 'Price':
        iconData = Icons.attach_money;
        break;
      default:
        iconData = Icons.error;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            iconData,
            color: headingColor,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          heading,
          style: TextStyle(
            fontSize: 18,
            color: headingColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              data ?? '',
              style: TextStyle(
                fontSize: 18,
                color: dataColor,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }
}
