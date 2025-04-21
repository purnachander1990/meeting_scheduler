import 'package:flutter/material.dart';

class Responsive {
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }
  
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 1024 && 
           MediaQuery.of(context).size.width >= 768;
  }
  
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }
  
  static double getColumnWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= 1200) {
      return width / 3; // Three columns on large screens
    } else if (width >= 1024) {
      return width / 3; // Three columns on desktop
    } else if (width >= 768) {
      return width / 2; // Two columns on tablet
    } else {
      return width; // One column on mobile
    }
  }
}