import 'package:fashion_guru/components/toast_message.dart';
import 'package:fashion_guru/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/session.dart';

class Custom_Navigator extends StatefulWidget {
  final selectedIndex;
  const Custom_Navigator({super.key, this.selectedIndex});

  @override
  State<Custom_Navigator> createState() => _Custom_NavigatorState();
}

class _Custom_NavigatorState extends State<Custom_Navigator> {
  Map<String, dynamic> loggedInUser = {};
  @override
  void initState() {
    getUserFromSession().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        setState(() {
          loggedInUser = response['data'];
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }


  void _onItemTapped(int index) {
    setState(() {
    if(index==0){
      Navigator.pushNamed(context, 'DashboardScreen');
    }
    if(index==1){
      Navigator.pushNamed(context, 'MyCart');
    }
    if(index==2){
      Navigator.pushNamed(context, 'OrderHistory');
    }
    if(index==3){
      if(loggedInUser['type']=="admin"){
        Navigator.pushNamed(context, 'AdminPortal');
      } else {
        Navigator.pushNamed(context, 'VendorProfile');
      }
    }
    // else{
    //   Navigator.pushNamed(context, 'LoginScreen');
    // }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomNavigationBar(


      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house_fill),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cart_fill),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.square_list_fill),
          label: 'Order History',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person_fill),
          label: 'Account',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor:Color(0xFFF5A811),
      onTap: _onItemTapped,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      elevation: 20,
      unselectedItemColor: Colors.black.withOpacity(0.3),
      iconSize: size.width*0.06,
      selectedFontSize: size.width*0.03,
      unselectedFontSize: size.width*0.03,

    );


  }
}
