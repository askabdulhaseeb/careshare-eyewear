import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'providers/category_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/product_screeen/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAG0wux4ptFQQq0pmWbhUWpQzREO4ACtlU',
      authDomain: 'careshare-eyewear.firebaseapp.com',
      projectId: 'careshare-eyewear',
      storageBucket: 'careshare-eyewear.appspot.com',
      messagingSenderId: '254801060212',
      appId: '1:254801060212:web:4c8a9a5b63a63a7a780c21',
      measurementId: 'G-TF9PB6LF4X',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<AppProvider>.value(value: AppProvider()),
        ChangeNotifierProvider<ProductProvider>.value(value: ProductProvider()),
        ChangeNotifierProvider<OrderProvider>.value(value: OrderProvider()),
        ChangeNotifierProvider<CategoryProvider>.value(
            value: CategoryProvider()),
      ],
      child: MaterialApp(
        title: 'Care Share Eye Wear',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductScreen(),
        routes: <String, WidgetBuilder>{
          LoginScreen.routeName: (_) => const LoginScreen(),
        },
      ),
    );
  }
}

// flutter build web
// firebase deploy --only hosting
// https://careshare-eyewear.web.app/#/