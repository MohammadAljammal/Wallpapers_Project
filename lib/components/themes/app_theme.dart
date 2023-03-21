import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

String fontFamily = 'Mulish';
String primaryColor = '#b30000';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      indent: 0.0,
      endIndent: 0.0,
      thickness: 1.0,
      space: 0.5),
  hintColor: const Color.fromRGBO(170, 170, 170, 1.0),
  textTheme: GoogleFonts.getTextTheme(fontFamily).copyWith(
    headline1: GoogleFonts.getFont(fontFamily,
        color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.w800),
  ),
  primaryTextTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
  ),
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Colors.transparent),
  canvasColor: Colors.white,
  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
  highlightColor: Colors.grey[100]!.withOpacity(0.4),
  splashColor: Colors.transparent,
  primaryColor: HexColor(primaryColor),
  scaffoldBackgroundColor: const Color(0xffFAFAFA),
  dividerColor: HexColor("#e6e6e6"),
  fontFamily: GoogleFonts.poppins().fontFamily,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(size: 24),
    unselectedIconTheme: IconThemeData(size: 24),
    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    type: BottomNavigationBarType.fixed,
    enableFeedback: true,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  iconTheme: IconThemeData(
    color: HexColor(primaryColor),
    size: 24,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: const Color(0xffFAFAFA),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    shadowColor: Colors.grey[200]!.withOpacity(.5),
    elevation: 1,
    iconTheme: const IconThemeData(
      color: Color.fromRGBO(51, 51, 51, 1),
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: Color.fromRGBO(51, 51, 51, 1),
      size: 24,
    ),
  ),
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: HexColor(primaryColor),
    secondary: const Color.fromRGBO(51, 51, 51, 1),
  ),
);
