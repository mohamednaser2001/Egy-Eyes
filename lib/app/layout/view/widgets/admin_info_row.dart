import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RowOfAdminInfo extends StatelessWidget {
  RowOfAdminInfo({Key? key, required this.title, required this.value, required this.icon}) : super(key: key);
  String title;
  String value;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16,),
          const SizedBox(width: 3,),
          Expanded(
            flex: 2,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color:Colors.black,
                fontSize:11.sp,
                fontWeight:FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 4,),
          Expanded(
            flex: 5,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: GoogleFonts.poppins(
                color:Colors.grey[500],
                fontSize:11.sp,
                fontWeight:FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
