import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/views/screens/add_video_body.dart';
import 'package:tiktok_clone/views/screens/videos_screen.dart';
import 'package:tiktok_clone/views/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;

  final _layouts = const [
    VideosScreen(),
    Center(child: Text('Search')),
    AddVideoScreen(),
    Center(child: Text('Messages')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layouts[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBackgroundColor,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: kWhiteColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: "Search",
            tooltip: "Search",
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
            ),
            label: "Message",
            tooltip: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "Profile",
            tooltip: "Profile",
          ),
        ],
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 35,
      child: const Icon(Icons.add, color: kBackgroundColor),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(offset: Offset(3, 0), color: Color(0xfffa2d6c)),
          BoxShadow(offset: Offset(-3, 0), color: Color(0xff20d3ea)),
        ],
      ),
    );
  }
}
