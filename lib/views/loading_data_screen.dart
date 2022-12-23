import 'package:colab/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingDataScreen extends StatefulWidget {
  const LoadingDataScreen({Key? key}) : super(key: key);

  @override
  State<LoadingDataScreen> createState() => _LoadingDataScreenState();
}


class _LoadingDataScreenState extends State<LoadingDataScreen> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    return const Scaffold(
      backgroundColor:  AppColors.primary,
    );
  }
}