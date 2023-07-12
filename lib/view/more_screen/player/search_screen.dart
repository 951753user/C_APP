import 'package:cricbuzzapp/view/player_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../more_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  MoreController controller = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),//<-- SEE HERE
              ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )

          ),
          controller: controller.txtSearchPlayer,
          style: GoogleFonts.poppins(color: Colors.white),
          onChanged: (value) {
            controller.getSearchedPlayerData(value);
          },
        ),
      ),
      body: Obx(
        ()=> ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.searchedData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Get.to(()=> PlayerDetailsScreen(playerId: "${controller.searchedData[index].id}", playerName: "${controller.searchedData[index].name}"));
              },
              child: Container(
                padding: EdgeInsets.all(10.sp),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        controller.getImage(
                            "${controller.searchedData[index].faceImageId}"),
                      ),
                      radius: 25.sp,
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: [
                        Text("${controller.searchedData[index].name}",
                          style: GoogleFonts.poppins(fontSize: 16.sp),),
                        Text("${controller.searchedData[index].teamName}",
                          style: GoogleFonts.poppins(fontSize: 16.sp,
                              color: Colors.grey.shade600),),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
