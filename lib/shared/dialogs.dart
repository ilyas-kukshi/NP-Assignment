import 'package:flutter/material.dart';
import 'package:npassignment/shared/app_theme_shared.dart';

class DialogShared {
  static loadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    color: AppThemeShared.buttonColor,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 18),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static doubleButtonDialog(BuildContext context, String text,
      void Function()? yesClicked, void Function()? noClicked) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: [
              Image.asset(
                "assets/images/logo.jpg",
                height: 150,
                fit: BoxFit.fill,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppThemeShared.sharedRaisedButton(
                      context: context,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.green,
                      buttonText: "Yes",
                      onPressed: yesClicked),
                  AppThemeShared.sharedRaisedButton(
                      context: context,
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.2,
                      color: Colors.red,
                      buttonText: "No",
                      onPressed: noClicked)
                ],
              )
            ],
          ),
        );
      },
    );
  }

  static singleButtonDialog(
    BuildContext context,
    String text,
    String buttonText,
    void Function()? onClicked,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 30),
              AppThemeShared.sharedRaisedButton(
                  context: context,
                  height: 45,
                  borderRadius: 12,
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: AppThemeShared.buttonColor,
                  buttonText: "Ohk",
                  onPressed: onClicked),
            ],
          ),
        );
      },
    );
  }
}
