import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/text_styles.dart';

class SuperAdminPage extends StatefulWidget {
  const SuperAdminPage({Key? key}) : super(key: key);

  @override
  State<SuperAdminPage> createState() => _SuperAdminPageState();
}

class _SuperAdminPageState extends State<SuperAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 220,
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      'Hi, Super Admin',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleHeadline4.copyWith(fontSize: 16),
                    )),
                    Flexible(
                        child: Text(
                      'Last Login: 03-12-2022, 09:48 pm',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleBodyText2.copyWith(
                          color: Colors.black, fontSize: 14),
                    )),
                  ],
                ),
              ),
              IconButton(
            iconSize: 50,
            icon: const Icon(
              Icons.person,
            ),
            // the method which is called
            // when button is pressed
            onPressed: () {
              setState(
                () {
                 context.pushNamed('LOGOUT');
                },
              );
            },
          ),
            ],
          ),
          toolbarHeight: 80,
          backgroundColor: const Color.fromRGBO(255, 192, 0, 1),
          leading: const Icon(
            Icons.notifications,
            size: 28,
          ),
        ),
      body:const Center()
    );
  }
}