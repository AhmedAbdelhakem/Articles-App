import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Input Field

//used button widget for app

Widget myButtonWidget(
    {required VoidCallback onPressed,
      required String texts,
      Color backgroundColor = Colors.amber,
      double height = 50,
      double width = 400}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        minimumSize: Size(width, height)),
    child: Text(
      texts,
      maxLines: 1,
      style: GoogleFonts.redHatDisplay(),
    ),
  );
}