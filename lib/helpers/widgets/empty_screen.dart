import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color_manger.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(text,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700,
            color: AppColors.descriptionColor,
            fontSize: 24,
          ),
        ));
  }
}