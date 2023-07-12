import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget VideoList(String image,String title,String time){
  return SizedBox(
    height: 230.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Card(
            elevation: 2,
            child: SizedBox(
              height: 210.h,
              width: 280.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                    width: 300.w,
                    child: Stack(
                      children: [
                        Image.network(
                          image,
                          height: 150.h,
                          width: 300.w,
                          fit: BoxFit.fill,
                        ),
                        Center(
                            child: Icon(
                              Icons.play_circle,
                              size: 55.sp,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, bottom: 8),
                    child: Text(
                      time,
                      style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
