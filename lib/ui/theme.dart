import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr=Color(0xFF4e5ae8);
const Color yellowClr=Color(0xFFFFB746);
const Color pinkClr=Color(0xFFff4667);
const Color white=Colors.white;
const Color darkGreyClr=Color(0xFF121212);
const Color darkHeaderClr=Color(0xFF424242);



class ThemesApp
{
static final light=  ThemeData(
  primaryColor: bluishClr,
  backgroundColor: Colors.white,

  textTheme: TextTheme(
    bodyText1: GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        color:  Colors.black,
      ),
    ),
    bodyText2: GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color:  Colors.black,
      ),
    ),

  ),
  iconTheme:const IconThemeData(
    color:darkGreyClr,
  ),
  appBarTheme:const AppBarTheme(
  color: Colors.white,
    elevation: 0,

  ),
  brightness: Brightness.light,

  );
static final dark= ThemeData(
  primaryColor: bluishClr,
  backgroundColor: darkGreyClr,

  iconTheme:const IconThemeData(
    color:Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        color:  Colors.white,
      ),
    ),
    bodyText2: GoogleFonts.lato(
      textStyle:const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color:  Colors.white,
      ),
    ),

  ),
  appBarTheme:const AppBarTheme(
  color: darkGreyClr,
    elevation: 0,

  ),
  brightness: Brightness.dark,
  );

}