import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/profile/controller/profile_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';

class CoeHomeScreen extends StatelessWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final ProfileController profileController;
  const CoeHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController,
      required this.profileController});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "COE",
            style: Get.textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/vaps-about.jpg",
                fit: BoxFit.fill,
              ),
            ),
            profileController.holidayList.isEmpty
                ? const AnimatedProgressWidget(
                    animationPath: "assets/json/nodata.json",
                    title: "Eventes not Found",
                    desc: "")
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      var v = profileController.holidayList.elementAt(index);
                      DateTime dt = DateTime.parse(v.fomhwdDFromDate!);
                      var date =
                          '${getFormatedDate(dt)}, ${getDayName(dt.weekday)}';
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: (v.fohtwDHolidayWDType == "PH")
                            ? const Color.fromARGB(255, 206, 245, 207)
                            : const Color.fromARGB(255, 227, 205, 248),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      v.fomhwdDName ?? '',
                                      style: Get.textTheme.titleSmall!.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  (v.fohtwDHolidayWDType == "PH")
                                      ? Text(
                                          "(Public Holiday)",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(color: Colors.red),
                                        )
                                      : Text(
                                          "(Optional)",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(),
                                        )
                                ],
                              ),
                              Text(date),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: profileController.holidayList.length),
          ],
        ),
        // ListView(
        //   padding: const EdgeInsetsDirectional.symmetric(
        //       vertical: 16, horizontal: 10),
        //   children: [
        //     SingleChildScrollView(
        //       scrollDirection: Axis.horizontal,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.circular(10),
        //         child: DataTable(
        //             dataRowHeight: 35,
        //             headingRowHeight: 40,
        //             columnSpacing: 20,
        //             headingTextStyle:
        //                 const TextStyle(color: Colors.white),
        //             border: TableBorder.all(
        //               color: Colors.black,
        //               width: 0.6,
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             headingRowColor: MaterialStateColor.resolveWith(
        //                 (states) => Theme.of(context).primaryColor),
        //             columns: const [
        //               DataColumn(label: Text("SL.NO.")),
        //               DataColumn(label: Text("Holiday")),
        //               DataColumn(label: Text("Date")),
        //             ],
        //             rows: List.generate(
        //                 profileController.holidayList.length, (index) {
        //               var v = index + 1;
        //               var val =
        //                   profileController.holidayList.elementAt(index);
        //               DateTime dt = DateTime.parse(val.fomhwdDFromDate!);
        //               var date =
        //                   '${getFormatedDate(dt)}, ${getDayName(dt.weekday)}';
        //               return DataRow(cells: [
        //                 DataCell(Text(v.toString())),
        //                 DataCell(Row(
        //                   mainAxisAlignment:
        //                       MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text('${val.fomhwdDName}  '),
        //                     (val.fohtwDHolidayWDType == "PH")
        //                         ? Text(
        //                             "(Public Holiday)",
        //                             style: Get.textTheme.titleSmall!
        //                                 .copyWith(color: Colors.red),
        //                           )
        //                         : Text(
        //                             "(Optional)",
        //                             style: Get.textTheme.titleSmall!
        //                                 .copyWith(),
        //                           )
        //                   ],
        //                 )),
        //                 DataCell(Text(date))
        //               ]);
        //             })),
        //       ),
        //     )
        //   ],
        // ),
      );
    });
  }
}
