import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
          appBar: AppBar(
          title: const Text("User Profile"),
          toolbarHeight: 80,
          backgroundColor: AppColors.primary,
        ),
          body: Center(child: Column(children: <Widget>[  
            Container(  
              margin: const EdgeInsets.all(25),  
              child: MaterialButton( 
                textColor: AppColors.white, 
                color: Colors.red,elevation: 5,
                child: const Text('Log Out', style: TextStyle(fontSize: 20.0),),  
               onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                  // ignore: use_build_context_synchronously
                  context.pushNamed('LOGINPAGE');
                }, 
              ),  
            ),  
          ]  
         ))  
      );
  }
}