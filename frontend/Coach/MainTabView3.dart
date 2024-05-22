import 'package:gofit/common/colo_extension.dart';
import 'package:gofit/common_widget/tab_button1.dart';
import 'package:flutter/material.dart';

import 'package:gofit/Profile/ProfileScreen.dart';

import '../screens/User/search.dart';
import 'MenuCoach.dart';

class maintabCoach extends StatefulWidget {
  const maintabCoach({super.key});

  @override
  State<maintabCoach> createState() => _maintabCoachState();
}

class _maintabCoachState extends State<maintabCoach> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();

  Widget currentTab =   const MenuCoach();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const SearchPage()), // Replace 'MyPage' with the page you want to open.
            );
          },

          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: TColor.primaryG,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,)
                ]),
            child: Icon(Icons.search,color: TColor.white, size: 35, ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(color: TColor.white, boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
            ]),
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabButton(
                    icon: "assets/img/home_tab.png",
                    selectIcon: "assets/img/home_tab.png",
                    isActive: selectTab == 0,
                    onTap: () {
                      selectTab = 0;
                      currentTab =
                      // SelectView();
                      const MenuCoach();
                      if (mounted) {
                        setState(() {});
                      }
                    }
                ),



                const  SizedBox(width: 40,),



                TabButton(
                    icon: "assets/img/profile_tab.png",
                    selectIcon: "assets/img/profile_tab_select.png",
                    isActive: selectTab == 3,

                    onTap: () {
                      selectTab = 0;
                      currentTab =
                      // SelectView();
                      const ProfileScreen();
                      if (mounted) {
                        setState(() {});
                      }
                    }
                ),
              ],
            ),

          )),
    );
  }
}