import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/gps/api/get_load_data_api.dart';
import 'package:m_skool_flutter/vms/gps/api/gps_api.dart';
import 'package:m_skool_flutter/vms/gps/api/sava_punch.dart';

import 'package:m_skool_flutter/vms/gps/controller/get_gps_controller.dart';
import 'package:m_skool_flutter/vms/gps/model/clients_model.dart';
import 'package:m_skool_flutter/vms/gps/model/sales_list_model.dart';
import 'package:m_skool_flutter/vms/maker%20and%20checker/controller/dr_details_ctrlr.dart';
import 'package:m_skool_flutter/vms/utils/saveBtn.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/drop_down_level.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../main.dart';

class GpasHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const GpasHomeScreen(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});
  @override
  State<GpasHomeScreen> createState() => _GpasHomeScreenState();
}

class _GpasHomeScreenState extends State<GpasHomeScreen> {
  TextEditingController remarksEtingController = TextEditingController();
  GetEmpDetailsController getEmpDetailsController =
      Get.put(GetEmpDetailsController());
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  DrDetailsCtrlr controller = Get.put(DrDetailsCtrlr());
  RxBool punchFlag = RxBool(false);
  int clientId = 0;
  int salesId = 0;
  @override
  void initState() {
    intial();
    super.initState();
  }

  intial() async {
    getEmpDetailsController.getLocation().then(
      (value) {
        feacthGps(
          latitude: getEmpDetailsController.latitude.value,
          logitude: getEmpDetailsController.longitude.value,
          controller: getEmpDetailsController,
        ).then(
          (value) {
            if (value) {
              feacthGpsClient(
                  base: baseUrlFromInsCode(
                      'frontoffice', widget.mskoolController),
                  miId: widget.loginSuccessModel.mIID!,
                  userId: widget.loginSuccessModel.userId!,
                  controller: getEmpDetailsController);
            }
          },
        );
        if (!value) {
          Fluttertoast.showToast(msg: "Please provide a location permission");
        }
      },
    );
  }

  GetGpsClientDetailsValues? selecteditem;
  final clientController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: const CustomGoBackButton(),
        title: const Text('GPS Attendance'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Obx(
              () => controller.drIsLoading.value
                  ? const SizedBox()
                  : BtnSave(
                      title: 'Submit',
                      onPress: () async {
                        // if (_fromKey.currentState!.validate()) {
                        if (clientId == 0) {
                          Fluttertoast.showToast(msg: "Select Client");
                        } else if (remarksEtingController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Enter Remarks");
                        } else {
                          await save(
                                  base: baseUrlFromInsCode(
                                      'frontoffice', widget.mskoolController),
                                  address: getEmpDetailsController
                                      .getGpsLocation.value,
                                  clientId: clientId,
                                  salesId: salesId,
                                  latlng:
                                      "${getEmpDetailsController.latitude}+${getEmpDetailsController.longitude}",
                                  controller: controller,
                                  miId: widget.loginSuccessModel.mIID!,
                                  userId: widget.loginSuccessModel.userId!,
                                  pFlag: punchFlag.value,
                                  remark: remarksEtingController.text)
                              .then(
                            (value) {
                              if (value) {
                                Fluttertoast.showToast(
                                    msg: "Punch successfull");
                                Get.back();
                              } else {
                                Fluttertoast.showToast(msg: "Punch not done");
                              }
                            },
                          );
                        }
                        // if (punchFlag.isTrue) {
                        //   await save(
                        //           base: baseUrlFromInsCode(
                        //               'frontoffice', widget.mskoolController),
                        //           address: getEmpDetailsController
                        //               .getGpsLocation.value,
                        //           clientId: clientId,
                        //           salesId: salesId,
                        //           latlng:
                        //               "${getEmpDetailsController.latitude}+${getEmpDetailsController.longitude}",
                        //           controller: controller,
                        //           miId: widget.loginSuccessModel.mIID!,
                        //           userId: widget.loginSuccessModel.userId!,
                        //           pFlag: punchFlag.value,
                        //           remark: remarksEtingController.text)
                        //       .then(
                        //     (value) {
                        //       if (value) {
                        //         Fluttertoast.showToast(
                        //             msg: "Punch successfull");
                        //         Get.back();
                        //       } else {
                        //         Fluttertoast.showToast(msg: "Punch not done");
                        //       }
                        //     },
                        //   );
                        // } else {
                        //   Fluttertoast.showToast(
                        //       msg: " Select Punch checkbox ");
                        // }
                        // } else {
                        //   Fluttertoast.showToast(msg: " Select mandatory ");
                        // }
                      },
                    ),
            ),
          )
        ],
      ),
      body: Obx(() => getEmpDetailsController.mapLoading.value
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const AnimatedProgressWidget(
                animationPath: 'assets/json/gpsJson.json',
                title: 'Finding location',
                desc: "Please wait we are finding location",
              ),
            )
          : Form(
              key: _fromKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_sharp,
                            size: 30,
                            color: Color.fromARGB(255, 6, 180, 12),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                                getEmpDetailsController.getGpsLocation.value,
                                maxLines: 6,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        color: Color.fromARGB(255, 21, 50, 214),
                                        letterSpacing: 0.3))),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => getEmpDetailsController.gpsErrorLoading.value
                        ? const Center(
                            child: ErrWidget(
                              err: {
                                "errorTitle": "Unexpected Error Occured",
                                "errorMsg":
                                    "While loading company we encountered an error"
                              },
                            ),
                          )
                        : getEmpDetailsController.gpsLoading.isTrue
                            ? const AnimatedProgressWidget(
                                animationPath: 'assets/json/default.json',
                                title: 'Loading data',
                                desc: "Please wait we are loading data",
                              )
                            : getEmpDetailsController.gpsClientList.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 8,
                                              color: Colors.black12,
                                            ),
                                          ],
                                        ),
                                        child: DropdownSearch<
                                            GetGpsClientDetailsValues>(
                                          dropdownButtonProps:
                                              const IconButtonProps(
                                                  icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 30,
                                            color: Colors.black,
                                          )),
                                          popupProps: PopupProps.menu(
                                            showSearchBox: true,
                                            textStyle: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                            menuProps: MenuProps(
                                                textStyle: Get
                                                    .textTheme.titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            loadingBuilder:
                                                (context, searchEntry) {
                                              return const CircularProgressIndicator();
                                            },
                                            searchFieldProps: TextFieldProps(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(6),
                                                  hintText:
                                                      'Search Client name',
                                                  hintStyle: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Colors.grey),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                                controller: clientController,
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400)),
                                            scrollbarProps:
                                                const ScrollbarProps(
                                              thickness: 1,
                                            ),
                                          ),
                                          dropdownSearchTextStyle: Get
                                              .textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400),
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  hintText: 'Select Client',
                                                  hintStyle: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                  label:
                                                      const CustomDropDownLabel(
                                                    icon:
                                                        'assets/images/prof4.png',
                                                    containerColor:
                                                        Color.fromRGBO(
                                                            231, 223, 254, 1),
                                                    text: 'Client',
                                                    textColor: Color.fromRGBO(
                                                        96, 40, 200, 1),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none)),
                                          dropdownSearchTextAlign:
                                              TextAlign.start,
                                          items: getEmpDetailsController
                                              .gpsClientList,
                                          itemAsString: (item) =>
                                              item.ismmclTClientName!,
                                          onChanged: (value) {
                                            setState(() {
                                              selecteditem = value;
                                              clientId = value!.ismmclTId!;
                                              logger.i(clientId);
                                            });
                                          },
                                          selectedItem: selecteditem,
                                        )),
                                  )

                                // Container(
                                //     margin: const EdgeInsets.only(
                                //         top: 40,
                                //         left: 16,
                                //         right: 16,
                                //         bottom: 16),
                                //     decoration: BoxDecoration(
                                //       color: Theme.of(context)
                                //           .scaffoldBackgroundColor,
                                //       borderRadius: BorderRadius.circular(16.0),
                                //       boxShadow: const [
                                //         BoxShadow(
                                //           offset: Offset(0, 1),
                                //           blurRadius: 8,
                                //           color: Colors.black12,
                                //         ),
                                //       ],
                                //     ),
                                //     child: DropdownButtonFormField<
                                //         GetGpsClientDetailsValues>(
                                //       validator: (value) {
                                //         if (value == null) {
                                //           return "";
                                //         }
                                //         return null;
                                //       },
                                //       decoration: InputDecoration(
                                //         border: InputBorder.none,
                                //         focusedBorder: const OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //             color: Colors.transparent,
                                //           ),
                                //         ),
                                //         enabledBorder: const OutlineInputBorder(
                                //           borderSide: BorderSide(
                                //             color: Colors.transparent,
                                //           ),
                                //         ),
                                //         hintStyle: Theme.of(context)
                                //             .textTheme
                                //             .labelSmall!
                                //             .merge(const TextStyle(
                                //                 fontWeight: FontWeight.w400,
                                //                 fontSize: 14.0,
                                //                 letterSpacing: 0.3)),
                                //         hintText: getEmpDetailsController
                                //                 .gpsClientList.isNotEmpty
                                //             ? 'Select Client'
                                //             : 'No data available',
                                //         floatingLabelBehavior:
                                //             FloatingLabelBehavior.always,
                                //         isDense: true,
                                //         label: const CustomDropDownLabel(
                                //           icon: 'assets/images/prof4.png',
                                //           containerColor:
                                //               Color.fromRGBO(231, 223, 254, 1),
                                //           text: 'Client',
                                //           textColor:
                                //               Color.fromRGBO(96, 40, 200, 1),
                                //         ),
                                //       ),
                                //       icon: const Padding(
                                //         padding: EdgeInsets.only(top: 3),
                                //         child: Icon(
                                //           Icons.keyboard_arrow_down_rounded,
                                //           size: 30,
                                //         ),
                                //       ),
                                //       iconSize: 30,
                                //       items: List.generate(
                                //           getEmpDetailsController
                                //               .gpsClientList.length, (index) {
                                //         return DropdownMenuItem(
                                //           value: getEmpDetailsController
                                //               .gpsClientList[index],
                                //           child: Padding(
                                //             padding: const EdgeInsets.only(
                                //                 top: 13, left: 5),
                                //             child: SizedBox(
                                //               width: MediaQuery.of(context)
                                //                       .size
                                //                       .width /
                                //                   1.5,
                                //               child: Text(
                                //                 getEmpDetailsController
                                //                     .gpsClientList[index]
                                //                     .ismmclTClientName!,
                                //                 maxLines: 3,
                                //                 style: Theme.of(context)
                                //                     .textTheme
                                //                     .titleSmall!
                                //                     .merge(const TextStyle(
                                //                         fontWeight:
                                //                             FontWeight.w300,
                                //                         fontSize: 14.0,
                                //                         letterSpacing: 0.3)),
                                //               ),
                                //             ),
                                //           ),
                                //         );
                                //       }),
                                //       onChanged: (s) async {
                                //         clientId = s!.ismmclTId!;
                                //       },
                                //     ),
                                //   )
                                : const AnimatedProgressWidget(
                                    animationPath: 'assets/json/nodata.json',
                                    title: 'No Data',
                                    desc: "No data is available",
                                  )),
                    Obx(() => Visibility(
                          visible:
                              getEmpDetailsController.gpsClientList.isNotEmpty,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<
                                GetGpsSalesDetailsValues>(
                              validator: (value) {
                                if (value == null) {
                                  return "";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                                hintText: getEmpDetailsController
                                        .gpsSalesList.isNotEmpty
                                    ? 'Select Lead'
                                    : 'No data available',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                isDense: true,
                                label: const CustomDropDownLabel(
                                  icon: 'assets/images/prof2.png',
                                  containerColor:
                                      Color.fromRGBO(223, 251, 254, 1),
                                  text: 'Lead',
                                  textColor: Color.fromRGBO(40, 195, 200, 1),
                                ),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                ),
                              ),
                              iconSize: 30,
                              items: List.generate(
                                  getEmpDetailsController.gpsSalesList.length,
                                  (index) {
                                return DropdownMenuItem(
                                  value: getEmpDetailsController
                                      .gpsSalesList[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 13, left: 5),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        maxLines: 3,
                                        getEmpDetailsController
                                            .gpsSalesList[index]
                                            .ismslELeadName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .merge(const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                                letterSpacing: 0.3)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              onChanged: (s) async {
                                salesId = s!.ismslEId!;
                              },
                            ),
                          ),
                        )),
                    Obx(() => Visibility(
                          visible:
                              getEmpDetailsController.gpsClientList.isNotEmpty,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Checkbox(
                                  value: punchFlag.value,
                                  activeColor:
                                      const Color.fromARGB(255, 33, 54, 243),
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onChanged: (value) {
                                    punchFlag.value = value!;
                                  },
                                ),
                              ),
                              const Text(
                                "Punch flag",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        )),
                    Obx(() => Visibility(
                        visible:
                            getEmpDetailsController.gpsClientList.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null) {
                                return "";
                              }
                              return null;
                            },
                            maxLines: 6,
                            controller: remarksEtingController,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    letterSpacing: 0.3)),
                            decoration: InputDecoration(
                                hintText: "Remark",
                                helperStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        letterSpacing: 0.3)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ))),
                  ],
                ),
              ),
            )),
    );
  }
}
