import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
 
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/principal/Fee_collection/api/fillgroupfee_api.dart';
import 'package:m_skool_flutter/principal/Fee_collection/api/sectionlist_api.dart';
import 'package:m_skool_flutter/principal/Fee_collection/controller/fee_controller.dart';
import 'package:m_skool_flutter/principal/Fee_collection/screen/detail_fee.dart';
 
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class FeeCollectionHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const FeeCollectionHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<FeeCollectionHomeScreen> createState() =>
      _FeeCollectionHomeScreenState();
}

class _FeeCollectionHomeScreenState extends State<FeeCollectionHomeScreen> {
  int color = 0;
  final FeeController controller = Get.put(FeeController());

  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  RxInt changes = RxInt(-1);

  @override
  initState() {
    super.initState();

   
  }

  @override
  void dispose() {
    Get.delete<FeeController>();
    super.dispose();
  }

  bool typefee = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Fee Details").getAppBar(),
      floatingActionButton: const HomeFab(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      readOnly: true,
                      controller: fromDate,
                      style: Theme.of(context).textTheme.titleSmall,
                      //controller: date,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 48.0, left: 12),
                        border: const OutlineInputBorder(),
                        label: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFDFFBFE),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/images/calendar.png",
                                height: 24.0,
                                color: const Color(0xFF28B6C8),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "From Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF28B6C8),
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Select Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () async {
                              DateTime? selectedDT = await showDatePicker(
                                context: context,
                                initialDate: controller.fromSelectedDate.value,
                                firstDate: DateTime(
                                    1000), //DateTime.now().year, 01, 01
                                lastDate: DateTime(DateTime.now().year, 12, 31),
                              );

                              if (selectedDT == null) {
                                Fluttertoast.showToast(
                                    msg: "You didn't selected the date");
                                return;
                              }
                              changes.value += 1;

                              controller.fromSelectedDate.value = selectedDT;
                              fromDate.text =
                                  getDate(controller.fromSelectedDate.value);

                              if (changes.value > 1) {
                            if( controller.FeeGroupList.isNotEmpty)   {
                               controller.FeeGroupList.clear();
                            }
                               GetFillGroupApi.instance.getfeecollectionApi(
                                  miId: widget.loginSuccessModel.mIID!,
                                  fromDate: getDateNeed(controller.fromSelectedDate.value)
                                     ,
                                  toDate: getDateNeed(controller.toSelectedDate.value)
                                     ,
                                  base: baseUrlFromInsCode(
                                      "portal", widget.mskoolController),
                                  controller: controller,
                                  asmay: widget.loginSuccessModel.asmaYId!,
                                  eventId: controller.fromSelectedDate.value
                                      .toLocal()
                                      .toString());
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                "assets/images/calendar.png",
                                height: 16.0,
                                width: 16.0,
                                color: const Color(0xFF28B6C8),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: CustomContainer(
                    child: TextField(
                      readOnly: true,
                      style: Theme.of(context).textTheme.titleSmall,
                      controller: toDate,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(top: 48.0, left: 12),
                        border: const OutlineInputBorder(),
                        label: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: const Color(0xFFDFFBFE),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset("assets/images/calendar.png",
                                  height: 24.0, color: const Color(0xFF28B6C8)),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "To Date",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .merge(
                                      const TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF28B6C8)),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        hintText: 'Select Date',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        suffixIcon: InkWell(
                            onTap: () async {
                              if (changes.value == -1) {
                                Fluttertoast.showToast(
                                    msg: "Please Select from Date First");
                                return;
                              }
                              DateTime? selectedDT = await showDatePicker(
                                context: context,
                                initialDate: controller.fromSelectedDate.value,
                                firstDate: controller.fromSelectedDate.value,
                                lastDate: DateTime(DateTime.now().year, 12, 31),
                              );

                              if (selectedDT == null) {
                                Fluttertoast.showToast(
                                    msg: "You didn't selected the date");
                                return;
                              }
                              changes.value += 1;
                              controller.toSelectedDate.value = selectedDT;
                              toDate.text =
                                  getDate(controller.toSelectedDate.value);

                              GetFillGroupApi.instance.getfeecollectionApi(
                                  miId: widget.loginSuccessModel.mIID!,
                                  fromDate: getDateNeed(controller.fromSelectedDate.value)
                                     ,
                                  toDate: getDateNeed(controller.toSelectedDate.value)
                                     ,
                                  base: baseUrlFromInsCode(
                                      "portal", widget.mskoolController),
                                  controller: controller,
                                  asmay: widget.loginSuccessModel.asmaYId!,
                                  eventId: controller.fromSelectedDate.value
                                      .toLocal()
                                      .toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                "assets/images/calendar.png",
                                height: 16.0,
                                width: 16.0,
                                color: const Color(0xFF28B6C8),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
           Obx(
        () => controller.isLoadingFee.isTrue
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Fee Details",
                    desc:
                        "",
                    animationPath: "assets/json/default.json"),
              )
            :
            // (controller.FeeGroupList.isEmpty)?
            // const Padding(
            //   padding: EdgeInsets.only(top:40.0),
            //   child: Center(
            //       child: AnimatedProgressWidget(
            //           title: "",
            //           desc:
            //               "",
            //           animationPath: "assets/json/nodata.json",animatorHeight: 300,),
            //     ),
            // ):
             SingleChildScrollView(
                child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: DataTable(
                            dataTextStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(0, 0, 0, 0.95),
                                fontWeight: FontWeight.w500),
                            dataRowHeight: 45,
                            headingRowHeight: 40,
                            horizontalMargin: 10,
                            columnSpacing: 40,
                            dividerThickness: 1,
                            headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(10),
                                width: 0.5),
                            headingRowColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                            columns: const [
                              DataColumn(
                                numeric: true,
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'S.No',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Section',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Receipt Count',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Collected',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                                DataColumn(
                                label: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'View',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                            rows: List.generate(
                                controller.FeeGroupList.length,
                                (index) {
                              var i = index + 1;
                              return DataRow(
                                cells: [
                                  DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text('$i'))),
                                DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text( controller.FeeGroupList.elementAt(index).className.toString()),
                                      )
                                      ),
                                       DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text( controller.FeeGroupList.elementAt(index).recptCount.toString()),
                                      )
                                      ),   
                                       DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text( controller.FeeGroupList.elementAt(index).paid.toString()),
                                      )
                                      ), 
                                       DataCell(Align(
                                      alignment: Alignment.center,
                                      child:  InkWell(
                                        onTap: () async{
                                    int status = await  GetSectionListApi.instance.getSectionListApi(
                                             miId:widget.loginSuccessModel.mIID! ,
                                             asmay: widget.loginSuccessModel.asmaYId!,
                                             fromDate: getDateNeed(controller.fromSelectedDate.value),
                                             toDate: getDateNeed(controller.toSelectedDate.value) ,
                                             base: baseUrlFromInsCode(
                                      "portal", widget.mskoolController),
                                             classId: controller.FeeGroupList.elementAt(index).classid.toString(),
                                             eventId:"C" ,
                                             controller:controller ,
                                           );
                                           if(status ==200){
                                             Get.to(()=>DetailsFeesCollect(
                                               loginSuccessModel: widget.loginSuccessModel,
                                               mskoolController: widget.mskoolController,
                                             ));
                                           }
                                        },
                                        child: Icon(Icons.visibility)
                                        ),
                                      )
                                      ),  
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 128.0,
                    ),
                  ],
                ),
              )),
      ),
          ],
        ),
      ),
    );
  }
  String getDateNeed(DateTime dt) {
    //.padLeft(2,"0")
     

  return "${dt.year}-${ dt.month.toString().padLeft(2,"0")}-${dt.day.toString().padLeft(2,"0")}";
}
}
// 
// widget datlist() {
//  return Obx(() {
    // return handler.isErrorOccuredWhileLoadingFillFeeDetails.value
        // ? const Center(
            // child: ErrWidget(err: {
              // "errorTitle": "An Error Occurred",
              // "errorMsg":
                  // "While Loading the Fee Details , we encountered an error, or server returned an error"
            // }),
          // )
        // : handler.isloadingFillFeeDetails.value
            // ? const AnimatedProgressWidget(
                // title: "Loading Academic Session's",
                // desc: "please wait we're loading academic year",
                // animationPath: "assets/json/COE.json")
            // : Container(
                // margin: EdgeInsets.only(top: 16.0),
                // height: Get.height * 0.7,
                // child: SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  // child: SingleChildScrollView(
                    // child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      // children: [
                        // DataTable(
                            // dataTextStyle: const TextStyle(
                                // fontSize: 15,
                                // color: Color.fromRGBO(0, 0, 0, 0.95),
                                // fontWeight: FontWeight.w500),
                            // dataRowHeight: 40,
                            // headingRowHeight: 40,
                            // horizontalMargin: 10,
                            // columnSpacing: 40,
                            // dividerThickness: 1,
                            // border: TableBorder.all(
                                // borderRadius: BorderRadius.circular(10),
                                // width: 0.5),
                            // headingRowColor: MaterialStateProperty.all(
                                // Theme.of(context).primaryColor),
                            // columns: [
                              // DataColumn(
                                  // label: Text(
                                // "Group Name",
                                // style: TextStyle(color: Colors.white),
                              // )),
                              // DataColumn(
                                  // label: Text("receviable",
                                      // style: TextStyle(color: Colors.white))),
                              // DataColumn(
                                  // label: Text("Collection",
                                      // style: TextStyle(color: Colors.white))),
                              // DataColumn(
                                  // label: Text("Concession",
                                      // style: TextStyle(color: Colors.white))),
                              // DataColumn(
                                  // label: Text("Balance",
                                      // style: TextStyle(color: Colors.white))),
                            // ],
                            // rows: List.generate(
                                // handler.feefilldetails.length,
                                // (index) => DataRow(cells: [
                                      // DataCell(Text(
                                          // "${handler.feefilldetails.elementAt(index).groupname}")),
                                      // DataCell(Text(
                                          // "${handler.feefilldetails.elementAt(index).recived}")),
                                      // DataCell(Text(
                                          // "${handler.feefilldetails.elementAt(index).paid}")),
                                      // DataCell(Text(
                                          // "${handler.feefilldetails.elementAt(index).concession}")),
                                      // DataCell(Text(
                                          // "${handler.feefilldetails.elementAt(index).ballance}")),
                                    // ]))),
                      // ],
                    // ),
                  // ),
                // ),
              // );
  // });
// }
// 