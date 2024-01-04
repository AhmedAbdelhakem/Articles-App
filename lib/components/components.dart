import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Input Field
import './input_field.dart';

//used button widget for app

Widget myButtonWidget(
    {required VoidCallback onPressed,
      required String texts,
      Color backgroundColor = Colors.amber,
      double height = 50,
      double width = 400}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      texts,
      maxLines: 1,
      style: GoogleFonts.redHatDisplay(),
    ),
    style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        minimumSize: Size(width, height)),
  );
}