import 'package:cricbuzzapp/view/more_screen/player/search_screen.dart';
import 'package:cricbuzzapp/view/player_details_screen.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/browse_player_model.dart';
import '../../home_screen/home_controller.dart';
import '../more_controller.dart';

class SearchPlayerScreen extends StatefulWidget {
  const SearchPlayerScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlayerScreen> createState() => _SearchPlayerScreenState();
}

class _SearchPlayerScreenState extends State<SearchPlayerScreen> {
  MoreController controller = Get.put(MoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Search Player",style: GoogleFonts.poppins()),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [


            // FutureBuilder(
            //   future: controller.getSearchedPlayerData(controller.txtSearchPlayer.text),
            //
            //   builder: (context, snapshot) {
            //   if (snapshot.hasData) {
            //     SearchPlayerModel data = snapshot.data;
            //     controller.searchedData.clear();
            //     for(var newData in data.player!)
            //       {
            //         controller.searchedData.add("${newData.name}");
            //       }
            //     return DropdownSearch<String>(
            //       mode: Mode.MENU,
            //       showSelectedItems: true,
            //       items: controller.searchedData.,
            //       dropdownSearchDecoration: InputDecoration(
            //         labelText: "Menu mode",
            //         hintText: "country in menu mode",
            //       ),
            //       popupItemDisabled: isItemDisabled,
            //       onChanged: (value){
            //         controller.getSearchedPlayerData(value!);
            //       },
            //       //selectedItem: "",
            //       showSearchBox: true,
            //
            //       searchFieldProps: TextFieldProps(
            //         controller: controller.txtSearchPlayer,
            //         cursorColor: Colors.blue,
            //       ),
            //     );
            //   }
            //   return Container();
            // },),

            Padding(
              padding: EdgeInsets.all(18.sp),
              child: InkWell(
                onTap: (){
                  Get.to(()=> SearchScreen());
                },
                child: Container(
                  height: 55.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.find<HomeController>()
                        .themeChanger
                        .value == true
                        ? Colors.black12
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15.sp)
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      children: [
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(15.sp),
            //   child: Card(
            //     child: TextField(
            //       controller: controller.txtSearchPlayer,
            //       cursorColor: Get
            //           .find<HomeController>()
            //           .themeChanger
            //           .value == false
            //           ? Colors.black12
            //           : Colors.white,
            //
            //       decoration: InputDecoration(
            //         filled: true,
            //         fillColor:
            //         Get.find<HomeController>()
            //             .themeChanger
            //             .value == true
            //             ? Colors.black12
            //             : Colors.white,
            //         border: InputBorder.none,
            //         prefixIcon: Icon(
            //           Icons.search,
            //           color:
            //           Get
            //               .find<HomeController>()
            //               .themeChanger
            //               .value == false
            //               ? Colors.black12
            //               : Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            FutureBuilder(
              future: controller.getSearchPlayerData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("No Data"),
                  );
                } else if (snapshot.hasData) {
                  SearchPlayerModel data = snapshot.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 38.h,
                        color:
                        Get
                            .find<HomeController>()
                            .themeChanger
                            .value == true
                            ? Colors.black12
                            : Colors.white,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          "${data.category}",
                          style: GoogleFonts.poppins(fontSize: 16.sp),
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.player?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Get.to(()=> PlayerDetailsScreen(playerId: "${data.player![index].id}", playerName: "${data.player![index].name}"));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.sp),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        controller.getImage(
                                            "${data.player![index].faceImageId}"),
                                      ),
                                      radius: 25.sp,
                                    ),
                                    SizedBox(width: 10.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text("${data.player![index].name}",
                                          style: GoogleFonts.poppins(fontSize: 16.sp),),
                                        Text("${data.player![index].teamName}",
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
                    ],
                  );
                }
                return const Center(
                  child: ios.CupertinoActivityIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    controller.getSearchedPlayerData(controller.txtSearchPlayer.text);
    setState(() {

    });
  }
}
