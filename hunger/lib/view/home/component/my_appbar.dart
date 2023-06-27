import 'package:flutter/material.dart';
import 'package:hunger/provider/cart_provider.dart';
import 'package:hunger/util/route/routes_name.dart';
import 'package:provider/provider.dart';

import '../../../services/firebase_services/auth/auth_service.dart';


PreferredSizeWidget myAppBar(BuildContext context)=>AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  leading: Builder(
    builder: (context)=> GestureDetector(
      onTap: (){
        Scaffold.of(context).openDrawer();
      },
      child: Icon(
        Icons.menu_rounded,
        color: Colors.grey.shade800,
      ),
    ),
  ),
  actions: [
    //cart action
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Consumer<CartProvider>(builder: (context, value, child){
        return Badge(
          alignment: const AlignmentDirectional(25, 1),
          label: Text(value.cartItem.length < 10?value.cartItem.length.toString():'9+'),
          backgroundColor: Colors.blue,
          isLabelVisible: value.cartItem.isNotEmpty? true:false,
          child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.cartScreen);
              },
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: Colors.grey.shade800,
              )),
        );
      },),
    ),
    //popup menu
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: PopupMenuButton(
        icon: Icon(Icons.more_vert_outlined, color: Colors.grey.shade800,),
        itemBuilder: (context) => [
          PopupMenuItem(child: const Text('Profile'), onTap: (){},),
          PopupMenuItem(child: const Text('Settings'), onTap: (){},),
          PopupMenuItem(child: const Text('Signout'), onTap:() {
            MyAuthService().signOut();
          },)
        ],
      ),
    ),

  ],
);
