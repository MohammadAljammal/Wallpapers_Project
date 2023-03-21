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
  disabledColor: const Color(0xffdbdbdb),
  errorColor: const Color.fromRGBO(235, 80, 60, 1.0),
  textTheme: GoogleFonts.getTextTheme(fontFamily).copyWith(
    headline1: GoogleFonts.getFont(fontFamily,
        color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.w800),
    headline2: GoogleFonts.getFont(fontFamily,
        color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.w600),
    headline3: GoogleFonts.getFont(fontFamily,
        color: Colors.grey[900],
        fontSize: 26.0,
        fontWeight: FontWeight.w700,
        height: 1.1),
    headline4: GoogleFonts.getFont(
      fontFamily,
      color: const Color(0xff181725),
      fontSize: 27.0,
      fontWeight: FontWeight.bold,
    ),
    headline5: GoogleFonts.getFont(fontFamily,
        color: Colors.grey[800], fontSize: 16.0, fontWeight: FontWeight.w700),
    headline6: GoogleFonts.getFont(fontFamily,
        color: Colors.grey[800], fontSize: 14.0, fontWeight: FontWeight.w500),
    button: GoogleFonts.getFont(fontFamily,
        color: const Color(0xffffffff),
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        height: 1.2),
    caption: GoogleFonts.getFont(fontFamily,
        color: Colors.grey[800], fontSize: 12.0, fontWeight: FontWeight.w600),
    overline: GoogleFonts.getFont(
      fontFamily,
      color: HexColor("#7d7d7d"),
      fontSize: 10.0,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w700,
      height: 1.2,
    ),
    bodyText2: GoogleFonts.getFont(fontFamily,
        color: const Color(0xff9E9E9E),
        fontSize: 14.0,
        fontWeight: FontWeight.w500),
    bodyText1: GoogleFonts.getFont(fontFamily,
        color: HexColor("#8c8c8c"),
        fontSize: 10.0,
        fontWeight: FontWeight.w500),
    subtitle2: GoogleFonts.getFont(fontFamily,
        color: Colors.black.withOpacity(.6),
        fontSize: 9.0,
        fontWeight: FontWeight.w400),
    subtitle1: GoogleFonts.getFont(fontFamily,
        color: Colors.grey[600], fontSize: 11.0, fontWeight: FontWeight.w600),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: const Color.fromRGBO(247, 248, 251, 1),
    backgroundColor: HexColor(primaryColor),
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
    selectedItemColor: Color(0xff0b8458),
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
