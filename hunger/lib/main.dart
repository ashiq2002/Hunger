import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hunger/provider/cart_provider.dart';
import 'package:hunger/provider/checkout_provider.dart';
import 'package:hunger/provider/text_field_provider.dart';
import 'package:hunger/provider/otp_validation.dart';
import 'package:hunger/res/values/keys.dart';
import 'package:hunger/services/firebase_services/firebase_options.dart';
import 'package:hunger/util/route/route.dart';
import 'package:hunger/util/route/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'provider/login_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = stripePublishableKey;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
        ChangeNotifierProvider(create: (_) => OtpValidation()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.laila().fontFamily,
      ),
      initialRoute: RoutesName.authScreen,
      onGenerateRoute: (settings) => MyRoute.generateRoutes(settings),
    );
  }
}
