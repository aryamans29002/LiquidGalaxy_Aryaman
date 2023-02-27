
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:giff_dialog/giff_dialog.dart';
import '../config/app_theme.dart';
import 'loginView.dart';


class ErrorView extends StatefulWidget {
  String error;
  ErrorView({Key? key, this.error=''}) : super(key: key);


  @override
  _ErrorViewState createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return  NetworkGiffDialog(
      image: Image.asset('assets/error.gif'),
      title: Text(
          'ERROR !!',
          style: AppTheme().headText1.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold
          )
      ),
      description: Text(
        "You vented outside the horizon. Let's get back in !!",
        style: AppTheme().headText2.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ),
      ),
      onlyOkButton: true,
      buttonOkColor: Colors.black,
      buttonOkText: Text(
        "GET IN",
        style: AppTheme().headText2.copyWith(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      onOkButtonPressed: () {
        Get.to(()=>LoginView());
      },
      cornerRadius: 10.0,
      buttonRadius: 5.0,
      entryAnimation: EntryAnimation.bottomRight,
    );
  }
}
