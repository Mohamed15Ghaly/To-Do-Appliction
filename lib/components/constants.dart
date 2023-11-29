import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

Widget Text_App({
  required String? string,
  Color color = Colors.black,
  double size = 20,
  bool bold = false,
  bool Shadow_Text = true,
}) =>
    Text(
      "${string}",
      style: TextStyle(
          shadows: Shadow_Text ? [Shadow(blurRadius: 1, color: color)] : null,
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : null,
          fontFamily: "Manrope"),
    );

Widget defaultTextFormfield({
  required TextEditingController? Control,
  required TextInputType? Type,
  required String? LabelHint,
  String? Hint,
  Color? LabelHintColor = Colors.grey,
  IconData? prefix,
  Color? prefix_color = Colors.grey,
  String? Label_Text,
  IconData? suffix,
  Function()? suffixOnpressed,
  bool Switch = false,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${LabelHint}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: LabelHintColor),
        ),
        Gap(5),
        TextFormField(

          keyboardType: Type,
          controller: Control,
          obscureText: Switch,
          cursorColor: Color.fromARGB(255, 1, 137, 121),
          decoration: InputDecoration(
            hintText: Hint,
            labelText: Label_Text,
            labelStyle: TextStyle(color: Colors.grey),
            suffixIcon: suffix != null
                ? IconButton(
                onPressed: suffixOnpressed,
                icon: Icon(
                  suffix,
                  color: Colors.grey,
                ))
                : null,
            prefixIcon: Icon(prefix),
            prefixIconColor: prefix_color,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );

Widget defaultMaterialButtom(
        {required double Width,
        required String string,
        required Function()? What_Fundction_do,
        bool loading = false,
        Widget? Loading}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 0, 84, 67),
            Color.fromARGB(255, 0, 146, 117),
          ])),
      width: Width ,
      child: MaterialButton(
        onPressed: What_Fundction_do,
        child: loading
            ? Loading
            : Text_App(
                string: "${string}",
                Shadow_Text: false,
                color: Colors.white,
                bold: true),
      ),
    );

Widget defaultTabBarItem() => Column(
      children: [
        Text(
          "friday",
          style: TextStyle(
              fontSize: 15,
              shadows: [
                Shadow(blurRadius: 1, color: Color.fromARGB(255, 1, 137, 121))
              ],
              fontWeight: FontWeight.bold,
              fontFamily: "Manrope"),
        ),
        Gap(10),
        CircularPercentIndicator(
          animation: true,
          animationDuration: 100,
          circularStrokeCap: CircularStrokeCap.round,
          radius: 20.0,
          lineWidth: 3.5,
          percent: .5,
          backgroundWidth: 2,
          center:
              Text_App(string: "40%", size: 13, color: Colors.grey, bold: true),
          progressColor: Color.fromARGB(255, 1, 137, 121),
          backgroundColor: Color.fromARGB(255, 192, 192, 192),
        ),
      ],
    );

Flushbar defaultFlusbar({
  required String? message,
  required int? Second,
  String? Title,
  IconData? icon,
  Function()? icon_do,
  bool buttom = false,
}) =>
    Flushbar(
      duration: Duration(seconds: Second!),
      backgroundColor: Color.fromARGB(255, 1, 137, 121),
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: buttom
          ? TextButton(
              onPressed: icon_do,
              child: Text(
                "Send",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          : null,
      titleText: Text(
        Title!,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      messageText: Text(
        message!,
        style: TextStyle(color: Colors.white),
      ),
    );


Widget defaultQuestion({
  required Function()? onpressed,
  required String? Question,
  required String? Answer,
}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text_App(
        string: "${Question}",
        Shadow_Text: false,
        color: Colors.grey,
        bold: true,
        size: 15),
    TextButton(
      onPressed: onpressed,
      child: Text_App(
          string: "${Answer}",
          size: 13,
          bold: true,
          color:
          Color.fromARGB(255, 1, 137, 121)),
    )
  ],
);


Widget defaultIconButton({
  required Function()? Onpressed,
  required IconData? icon
}) => IconButton(
    onPressed: Onpressed,
    icon: Shimmer.fromColors(
      highlightColor: Color.fromARGB(255, 1, 137, 121),
      baseColor: Colors.black,
      child: Icon(icon,
          color: Color.fromARGB(255, 1, 137, 121)),
    ));