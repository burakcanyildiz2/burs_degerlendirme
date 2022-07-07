import 'package:burakcanyildiz/Helpers/Toastr.dart';
import 'package:flutter/material.dart';

class AkInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController control;
  final bool isPhone;
  final bool hideHint;
  final bool isPassword;
  final bool enabled;
  final int maxLength;

  AkInput({
    @required this.hint,
    this.control,
    @required this.icon,
    this.isPhone = false,
    this.hideHint = false,
    this.isPassword = false,
    this.enabled = true,
    this.maxLength = 300,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hideHint
              ? SizedBox()
              : Text(
                  hint,
                  style: theme.textTheme.subtitle1,
                ),
          SizedBox(height: hideHint ? 0 : 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.orange,
              ),
            ),
            width: mSize.width,
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 18.0,
                    color: theme.primaryColor,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      enabled: enabled,
                      controller: control,
                      maxLength: maxLength,
                      obscureText: this.isPassword,
                      keyboardType:
                          isPhone ? TextInputType.phone : TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: hint,
                        border: InputBorder.none,
                        hintStyle: theme.textTheme.subtitle1,
                      ),
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

FontSize font = new FontSize();

class AkLabel extends StatelessWidget {
  final String text;
  final double size;
  final Alignment align;
  final Color color;
  final FontWeight fweight;
  final TextAlign tAlign;

  AkLabel({
    @required this.text,
    @required this.size,
    this.align = Alignment.centerLeft,
    this.color = Colors.black,
    this.fweight = FontWeight.normal,
    this.tAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mSize = MediaQuery.of(context).size;
    return Container(
      alignment: align,
      child: Text(this.text,
          textAlign: tAlign,
          style: TextStyle(fontSize: size, color: color, fontWeight: fweight)),
    );
  }
}

class AkButton extends StatelessWidget {
  final String text;
  final double size;
  final bool isReverse;

  AkButton({@required this.text, @required this.size, this.isReverse});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mSize = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(
            color: this.isReverse == true ? Colors.orange : Colors.white),
        borderRadius: BorderRadius.circular(10.0),
        color: this.isReverse == true ? Colors.white : Colors.orange,
      ),
      alignment: Alignment.center,
      child: Text(text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: this.isReverse == true ? Colors.orange : Colors.white,
            fontSize: size,
          ),
          textAlign: TextAlign.center),
    );
  }
}

class AkFile extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fweight;
  AkFile({@required this.text, this.size, this.fweight});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mSize = MediaQuery.of(context).size;
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(flex: 1, child: Icon(Icons.file_upload)),
                Expanded(
                    flex: 3,
                    child: Text(text,
                        style: TextStyle(fontSize: size, fontWeight: fweight))),
              ],
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
