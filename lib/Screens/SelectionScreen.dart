import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/ride.jpeg',
    'assets/images/fastfood.jpeg',
    'assets/images/gadets.jpg',
    'assets/images/Islamabad_Marriott.jpg',
  ];

  final List<String> texts = [
    'Ride',
    'Food',
    'Stuff',
    'Room',
  ];

  OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/bck.jpg',
            fit: BoxFit.cover,
          ),
         GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image with filter
                    Positioned.fill(
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.5), // Apply filter
                        colorBlendMode:
                            BlendMode.darken, // Blend mode for the filter
                      ),
                    ),
                    // Centered Text
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            texts[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10), // Spacer between texts
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Additional Text',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      // ElevatedButton under the GridView
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ElevatedButton(
          onPressed: () {
            // Button action
          },
          child: const Text('Button'),
        ),
      ),
    );
  }
}
