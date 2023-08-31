import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/model/student_dashboard_model.dart';
import 'package:m_skool_flutter/student/coe/screen/coe_home.dart';

class CoeSliderItem extends StatelessWidget {
  final CalListValues coeValue;
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final Map<String, dynamic> bannerAsset;
  const CoeSliderItem(
      {super.key,
      required this.coeValue,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.bannerAsset});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return CoeHome(
              loginSuccessModel: loginSuccessModel,
              mskoolController: mskoolController);
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.black26,
        child: Container(
          //height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(coeValue.cOEEIImages == null
                  ? "assets/images/new_coe_without.png"
                  : "assets/images/new_coe_banner.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: coeValue.cOEEIImages == null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        coeValue.cOEMEEventName!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/calendar.svg',
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            getFormatedDate(
                                DateTime.parse(coeValue.cOEEEStartDate!)),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/clock_coe.png',
                            color: Colors.white,
                            height: 20.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            coeValue.cOEEEStartTime!,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coeValue.cOEMEEventName!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: const Color(0xffFAC5C5),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/calendar.svg',
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  getFormatedDate(
                                      DateTime.parse(coeValue.cOEEEStartDate!)),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    //fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/clock_coe.png',
                                  color: Colors.white,
                                  height: 20.0,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                    "${coeValue.cOEEEStartTime}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      //fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Get.width * 0.04, left: Get.width * 0.07),
                        child: CircleAvatar(
                          radius: Get.width * 0.164,
                          backgroundImage: coeValue.cOEEIImages == null
                              ? const NetworkImage(
                                  "https://images.unsplash.com/photo-1672169272063-52586a619bc6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")
                              : NetworkImage(coeValue.cOEEIImages),
                        ),
                      ),
                    ))
                  ],
                ),

          // child: Row(
          //   children: [
          //     Expanded(
          //       flex: 4,
          //       child: Padding(
          //         padding: const EdgeInsets.all(12.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const SizedBox(
          //               height: 6.0,
          //             ),
          //             Text(
          //               coeValue.cOEMEEventName!,
          //               maxLines: 2,
          //               overflow: TextOverflow.ellipsis,
          //               style: GoogleFonts.bubblegumSans(
          //                 color: const Color(0xFFff6f67),
          //                 fontSize: 20.0,
          //               ),
          //               // style: GoogleFonts.moonDance(
          //               //     color: const Color(0xFFff6f67), fontSize: 20.0),
          //               // style: Theme.of(context).textTheme.titleMedium!.merge(
          //               //     const TextStyle(
          //               //         color: Color(0xFFff6f67),
          //               //         fontSize: 2.0,
          //               //         height: 1.2)),
          //             ),
          //             const SizedBox(
          //               height: 8.0,
          //             ),
          //             Row(
          //               children: [
          //                 SvgPicture.asset(
          //                   'assets/svg/calendar.svg',
          //                   color: Colors.black,
          //                 ),
          //                 const SizedBox(
          //                   width: 8.0,
          //                 ),
          //                 Text(
          //                   getFormatedDate(
          //                       DateTime.parse(coeValue.cOEEEStartDate!)),
          //                   style: Theme.of(context).textTheme.titleSmall,
          //                 )
          //               ],
          //             ),
          //             const SizedBox(
          //               height: 6.0,
          //             ),
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Image.asset(
          //                   'assets/images/clock_coe.png',
          //                   color: Colors.black,
          //                   height: 20.0,
          //                 ),
          //                 const SizedBox(
          //                   width: 8.0,
          //                 ),
          //                 Expanded(
          //                   child: Text(
          //                     "${coeValue.cOEEEStartTime} - ${coeValue.cOEEEEndTime}",
          //                     style: Theme.of(context).textTheme.titleSmall,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     // Expanded(
          //     //   flex: 6,
          //     //   child: SizedBox(
          //     //     height: 250,
          //     //     child: ClipPath(
          //     //       clipper: CoeShape(),
          //     //       child: coeValue.cOEEIImages == null
          //     //           ? Image.asset(
          //     //               "assets/images/coe_img.png",
          //     //               height: 250,
          //     //               fit: BoxFit.cover,
          //     //             )
          //     //           : Image.network(
          //     //               coeValue.cOEEIImages == null
          //     //                   ? "https://images.unsplash.com/photo-1498931299472-f7a63a5a1cfa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80"
          //     //                   : coeValue.cOEEIImages.toString(),
          //     //               fit: BoxFit.cover,
          //     //             ),
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
