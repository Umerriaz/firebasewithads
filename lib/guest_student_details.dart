import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:firebasewithads/ad_provider.dart';



class GuestStudentDetails extends StatefulWidget {
  const GuestStudentDetails({Key? key}) : super(key: key);

  @override
  State<GuestStudentDetails> createState() => _GuestStudentDetailsState();
}

class _GuestStudentDetailsState extends State<GuestStudentDetails> {
  @override
    Widget build(BuildContext context) {
      return WillPopScope(
          onWillPop: () async {
            if (Provider.of<AdProvider>(context, listen: false).isfullscreenad) {
              Provider.of<AdProvider>(context, listen: false).fullscreenad.show();
            }
            return true;
          },
          child: Scaffold(
          appBar: AppBar(
          title: Text("Add New Student"),
      ),
    ));

  }
  @override
  void initState() {
    // initialize homepge banner ad that we defined in ad provider
    Provider.of<AdProvider>(context, listen: false)
        .initializeFullpageInterstaticial();
    super.initState();
  }
}
