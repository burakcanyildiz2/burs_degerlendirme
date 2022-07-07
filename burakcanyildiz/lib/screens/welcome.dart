import 'package:burakcanyildiz/Widgets/input.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          child: Column(
            children: [
              Expanded(flex: 1, child: Container()),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/userlogin');
                    },
                    child: AkButton(
                      size: font.Medium(context),
                      text: 'Burs Al',
                    ),
                  )),
              SizedBox(height: 30),
              SizedBox(
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/companylogin');
                    },
                    child: AkButton(
                      size: font.Medium(context),
                      text: 'Burs Ver',
                    ),
                  )),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
