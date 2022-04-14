import 'package:firebasewithads/ad_provider.dart';
import 'package:firebasewithads/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdProvider>(create: (context) => AdProvider())
      ],
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // first check if snapshot has errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          // if there is no error
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Firebase Database',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: HomePage(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Firebase Database"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUP()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 21, 144, 206),
                    shadowColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                child: Text("Already a User"),
              )
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SignUP(),
        ));
  }
}
