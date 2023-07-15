import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3),() => Get.offAllNamed("home"),);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade200,
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/logo.png",width: 50.w,height: 50.w,fit: BoxFit.fill),
            SizedBox(height: 8),
            Text("Money Handler",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp,color: Colors.white),)
          ],
        ),),
      ),
    );
  }
}
