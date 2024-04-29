import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solosavour/Screens/DisplayingDataScreen/StuffListScreen.dart';
import 'package:solosavour/Screens/DisplayingDataScreen/foodListScreen.dart';
import 'package:solosavour/Screens/DisplayingDataScreen/rideListScreen.dart';
import 'package:solosavour/Screens/DisplayingDataScreen/roomListScreen.dart';
import 'package:solosavour/Screens/Profile/profileScreen.dart';

class HomeScreen extends StatefulWidget {
  final String userUid;
  final String profileImageUrl;
  const HomeScreen({
    super.key,
    required this.userUid,
    required this.profileImageUrl,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  late String _firstName = '';
  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: _selectedIndex);
  }

  Future<void> _fetchUserData() async {
    try {
      // Fetch user data from Firestore
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('SolortripUserData')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDataSnapshot.exists) {
        // If user data exists, extract the first name
        Map<String, dynamic>? userData =
            userDataSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          setState(() {
            _firstName = userData['firstName'] ?? ''; // Assign first name
          });
        }
      } else {
        // Handle case where user data doesn't exist
        print('User data does not exist');
      }
    } catch (e) {
      // Handle errors while fetching user data
      print('Error fetching user data: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Add your back button logic here
          },
        ),
        title: Center(
          child: Text(
            'Home Screen',
            style: TextStyle(fontSize: 22.sp, color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // Add your notification logic here
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 30, top: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10), // Adjust the value as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(
                            0, 3), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Container(
                    height: 50.h,
                    width: 350.w,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                NetworkImage(widget.profileImageUrl),
                          ),
                          const SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              text: 'Hey ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: _firstName,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                  text: ', How are you doing?',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              width: 380,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/images/banners.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(0xFFF8F8F8),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTabContainer('Book Your Ride', 0),
                            SizedBox(width: 5.w),
                            _buildTabContainer('Book Your Meals', 1),
                            SizedBox(width: 5.w),
                            _buildTabContainer(' Stuff Sharing', 2),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 5.w),
                              _buildTabContainer('Book Your Residence', 3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      RideData(),
                      FoodListScreen(),
                      StuffListScreen(),
                      RoomListScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() => _selectedIndex = index);
          if (_selectedIndex == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfileManagement()),
            );
          }
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.teal,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text('Likes'),
            activeColor: Colors.teal,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
            activeColor: Colors.teal,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContainer(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.index = index; // Update the tab index
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: _tabController.index == index
              ? Colors.teal
              : const Color.fromARGB(255, 201, 198, 198),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            color: _tabController.index == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
