import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solosavour/Screens/practice.dart';

class CarUploadingData extends StatefulWidget {
  const CarUploadingData({
    super.key,
  });

  @override
  _CarUploadingDataState createState() => _CarUploadingDataState();
}

class _CarUploadingDataState extends State<CarUploadingData> {
  File? _image;
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();
  final TextEditingController pickupPointController = TextEditingController();
  final TextEditingController dropPointController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadData() async {
    setState(() {
      _isUploading = true;
    });

    final carName = carNameController.text;
    final carNumber = carNumberController.text;
    final pickupPoint = pickupPointController.text;
    final dropPoint = dropPointController.text;
    final phoneNumber = phoneNumberController.text;
    final seatsAvailable = seatsController.text;
    final price = priceController.text;

    // Upload image to Firebase Storage
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');
    final UploadTask uploadTask = storageReference.putFile(_image!);
    await uploadTask.whenComplete(() => null);
    final String imageUrl = await storageReference.getDownloadURL();

    // Upload data to Firestore
    await FirebaseFirestore.instance.collection('RidesData').add({
      'carName': carName,
      'carNumber': carNumber,
      'pickupPoint': pickupPoint,
      'dropPoint': dropPoint,
      'phoneNumber': phoneNumber,
      'seatsAvailable': seatsAvailable,
      'price': price,
      'imageUrl': imageUrl, // Add the image URL to Firestore
    });

    setState(() {
      _isUploading = false;
    });

    // Navigate to home screen after upload
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MyScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text(
            'Image Selection',
            style: TextStyle(fontSize: 22.sp, color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    width: 300.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                      image: _image != null
                          ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage('assets/images/upimages.jpeg'),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: carNameController,
                        labelText: 'Car Name',
                        icon: Icons.directions_car,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: carNumberController,
                        labelText: 'Car Number',
                        icon: Icons.confirmation_number,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: pickupPointController,
                        labelText: 'Pickup Point',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: dropPointController,
                        labelText: 'Drop Point',
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: phoneNumberController,
                        labelText: 'Phone Number',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: seatsController,
                        labelText: 'Seats Available',
                        icon: Icons.event_seat,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: priceController,
                        labelText: 'Price',
                        icon: Icons.attach_money,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                _buildUploadButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: 300.w,
      height: 50.h,
      child: ElevatedButton(
        onPressed: _isUploading ? null : _uploadData,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Round button border
          ),
        ),
        child: _isUploading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                'Upload Data',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
