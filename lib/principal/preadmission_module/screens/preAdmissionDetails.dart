import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/principal/preadmission_module/apis/show_year_list_api.dart';
import 'package:m_skool_flutter/principal/preadmission_module/controller/pre_admission_controller.dart';
import 'package:m_skool_flutter/principal/preadmission_module/controller/show_year_list_controller.dart';
import 'package:m_skool_flutter/principal/preadmission_module/model/get_year_data.dart';
import 'package:m_skool_flutter/principal/preadmission_module/principal_widgets/pre_admission_scroll_widget.dart';
import 'package:m_skool_flutter/principal/preadmission_module/screens/student_list_table.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class PreAdmissionHomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  const PreAdmissionHomeScreen(
      {super.key,
      required this.loginSuccessModel,
      required this.mskoolController});

  @override
  State<PreAdmissionHomeScreen> createState() => _PreAdmissionHomeScreenState();
}

class _PreAdmissionHomeScreenState extends State<PreAdmissionHomeScreen> {
  List<Widget> sliderWidgets = [];
  var selectedValue;
  bool isTableOpen = false;

  List searchRadioData = ['Year Wise', 'Between Dates'];

  List<String> selectRadioData = [
    'Registered List',
    //'Registered and filled application form',
    // 'Registration payment not done list',
    // 'Sibling students list(paid student)',
    'Registered but not fill application form',
    // 'Registration payment done list ',
    // 'Partial/Admission payment done List',
    // 'Transferred student(Admission confirm)'
  ];

//(Application datewise)
  List dropDownValue = [
    'select',
  ];
  String dropDownSelectedValue = 'select';
  var searchRadioGroupValue = 'Year Wise';
  String newValue = '';
  var selectRadioGroupValue = 'Registered List';
  var newSelectValue = 0;

  final _fromDate = TextEditingController();
  final _toDate = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  String fromUtcTime = '';
  String toUtcTime = '';
  RxList showData = [].obs;
  var totalRegdCount = 0;
  var applicationNotFilled = 0;
  var filledApplicationForm = 0;
  var paymentDone = 0;
  var paymentNotDone = 0;
  var confirm = 0;

  bool isScrolled = false;
  bool isCancelScrolled = false;

  ShowYearListController controller = Get.put(ShowYearListController());
  PreAdmissionController preAdmissionController =
      Get.put(PreAdmissionController());
  DateTime currentDate = DateTime.now();
  String todayDate = '';
  _getData() async {
    controller.updateIsLoading(true);
    ShowYearAPI.instance.showYearList(
        url: baseUrlFromInsCode("login", widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        controller: controller);
    Future.delayed(const Duration(seconds: 3)).then((value) {

      controller.updateIsLoading(false);
    });
  }

  var assmId;
  @override
  void initState() {
    _getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        controller.classSectionData;
        controller.yearSectionData;
        controller.regdCountData;
      });
    });
    setState(() {
      todayDate = currentDate.toIso8601String();
    });
    super.initState();
  }

  final _scrollController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pre Admission').getAppBar(),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading",
                    desc:
                        "Please wait while we load marks entry and create a view for you.",
                    animationPath: "assets/json/default.json"),
              )
            : ListView(
                shrinkWrap: true,
                // primary: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CarouselSlider(
                      carouselController: _scrollController,
                      items: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: PreAdmissionScrollWidget(
                              color: Colors.blue,
                              count: (controller.regdCountData.isNotEmpty)
                                  ? controller.regdCountData.first.reg!
                                  : 0,
                              title: 'Total Registered',
                              image: '',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: (PreAdmissionScrollWidget(
                              color: const Color.fromARGB(255, 7, 204, 82),
                              count: (controller.regdCountData.isNotEmpty)
                                  ? controller
                                      .regdCountData.first.notapplicationform!
                                  : 0,
                              title: 'Not Filled Application Form',
                              image: '',
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: (PreAdmissionScrollWidget(
                              color: Colors.orange,
                              count: (controller.regdCountData.isNotEmpty)
                                  ? controller
                                      .regdCountData.first.applicationform!
                                  : 0,
                              title: 'Filled Application Form',
                              image: '',
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: (PreAdmissionScrollWidget(
                              color: const Color.fromRGBO(240, 98, 88, 1),
                              count: (controller.regdCountData.isNotEmpty)
                                  ? controller.regdCountData.first.payment!
                                  : 0,
                              title: 'Total Registration Payment Done',
                              image: '',
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: (PreAdmissionScrollWidget(
                              color: const Color.fromRGBO(9, 74, 128, 1),
                              count: (controller.regdCountData.isNotEmpty)
                                  ? controller.regdCountData.first.notpayment!
                                  : 0,
                              title: 'Total Registration Payment Not Done',
                              image: '',
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: InkWell(
                            onTap: () {},
                            child: (PreAdmissionScrollWidget(
                              color: const Color(0xFF00a65a),
                              count: (controller.regdCountData.isNotEmpty)
                                  ? controller.regdCountData.first.transferstu!
                                  : 0,
                              title:
                                  'Total Transfer Student(Admission Confirm)',
                              image: '',
                            )),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                          disableCenter: true,
                          aspectRatio: 1.0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          viewportFraction: 1,
                          height: MediaQuery.of(context).size.height * 0.2,
                          autoPlay: true,
                          autoPlayAnimationDuration: const Duration(seconds: 3),
                          enlargeCenterPage: false,
                          padEnds: true,
                          initialPage: 0,
                          onPageChanged: (value, _) {
                            setState(() {
                              selectedValue = value;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Student Count Report",
                    style: Get.textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Row(
                        children:
                            List.generate(searchRadioData.length, (index) {
                          return Expanded(
                            child: RadioListTile(
                                activeColor: Theme.of(context).primaryColor,
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    vertical: 0, horizontal: -4),
                                title: Row(
                                  children: [
                                    Text(
                                      searchRadioData[index],
                                      style: Get.textTheme.titleSmall,
                                    ),
                                    Text("*",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.red))
                                  ],
                                ),
                                value: searchRadioData[index],
                                groupValue: searchRadioGroupValue,
                                onChanged: (value) {
                                  setState(() {
                                    searchRadioGroupValue = value;

                                    isTableOpen = false;
                                  });
                                }),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  CustomContainer(
                    child: DropdownButtonFormField<String>(
                        isDense: true,
                        value: selectRadioGroupValue,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                  fontSize: 16.0, overflow: TextOverflow.fade),
                            ),
                        decoration: InputDecoration(
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
                          label: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFFBFE),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/noteicon.svg',
                                  color: const Color.fromRGBO(40, 182, 200, 1),
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  "Type ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(
                                        const TextStyle(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromRGBO(40, 182, 200, 1),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 30,
                        ),
                        // isDense: true,
                        items: List.generate(
                          selectRadioData.length,
                          (index) => DropdownMenuItem(
                            value: selectRadioData[index],
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                selectRadioData[index],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .merge(const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        letterSpacing: 0.3)),
                              ),
                            ),
                          ),
                        ),
                        isExpanded: true,
                        onChanged: (e) {
                          selectRadioGroupValue = e!;
                          newSelectValue = selectRadioData.indexOf(e);
                        }),
                  ),
                  const SizedBox(height: 25),
                  (searchRadioGroupValue == 'Year Wise')
                      ? CustomContainer(
                          child: DropdownButtonFormField<YearGetDataValues>(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                            iconSize: 0,
                            items: controller.yearSectionData.map((value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value.asmaYYear.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .merge(const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            letterSpacing: 0.3)),
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() =>
                                  dropDownSelectedValue = newValue.toString());
                              assmId = (newValue!.asmaYId);
                              logger.i(assmId);
                            },
                            value: controller.yearSectionData.last,
                            decoration: InputDecoration(
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
                              label:  Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 5),
                        decoration: BoxDecoration(
                            color: const Color(0xFFDFFBFE),
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/cap.png",
                              height: 16.0,
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "Academic Year",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(const TextStyle(
                                      fontSize: 20, color: Color(0xFF28B6C8))),
                            ),
                          ],
                        ),
                      ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomContainer(
                              child: TextFormField(
                                style: Get.textTheme.titleSmall,
                                controller: _fromDate,
                                readOnly: true,
                                autofocus: true,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                  hintText: "From Date",
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
                                  border: const OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  isTableOpen = false;
                                  fromDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(199),
                                      lastDate: DateTime(3101));

                                  if (fromDate != null) {
                                    String date =
                                        '${fromDate!.day}-${fromDate!.month}-${fromDate!.year}';
                                    setState(() {
                                      _fromDate.text = date;
                                      fromUtcTime = fromDate!.toIso8601String();
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            CustomContainer(
                              child: TextFormField(
                                style: Get.textTheme.titleSmall,
                                controller: _toDate,
                                readOnly: true,
                                autofocus: true,
                                decoration: InputDecoration(
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
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: "To Date",
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
                                "To Date",
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
                                  border: const OutlineInputBorder(),
                                ),
                                onTap: () async {
                                  isTableOpen = false;
                                  toDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1999),
                                      lastDate: DateTime(3101));

                                  if (toDate != null) {
                                    String date =
                                        '${toDate!.day}-${toDate!.month}-${toDate!.year}';
                                    setState(() {
                                      _toDate.text = date;
                                      toUtcTime = toDate!.toIso8601String();
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 5.0,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                setState(() {
                                  if (searchRadioGroupValue == 'Year Wise') {
                                    preAdmissionController
                                        .getStudentDataTable(
                                      base: baseUrlFromInsCode(
                                          "login", widget.mskoolController),
                                      type:
                                          (searchRadioGroupValue == 'Year Wise')
                                              ? 'yearwise'
                                              : "btwdates",
                                      miId: widget.loginSuccessModel.mIID!,
                                      asmyId:
                                          (searchRadioGroupValue == 'Year Wise')
                                              ? assmId
                                              : 0,
                                      fromDate:
                                          (searchRadioGroupValue == 'Year Wise')
                                              ? todayDate
                                              : fromUtcTime,
                                      toDate:
                                          (searchRadioGroupValue == 'Year Wise')
                                              ? todayDate
                                              : toUtcTime,
                                      report: newSelectValue,
                                    )
                                        .then((value) {
                                      setState(() {
                                        // if (preAdmissionController
                                        //     .countData.isNotEmpty) {
                                        Get.to(() => StudentListTable(
                                              preAdmissionController:
                                                  preAdmissionController,
                                            ));
                                        // } else {
                                        //   Fluttertoast.showToast(
                                        //       msg: "No Record Found");
                                        // }
                                      });
                                    });
                                  } else if (searchRadioGroupValue ==
                                      'Between Dates') {
                                    if (_fromDate.text.isEmpty ||
                                        _toDate.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Please select From and to date');
                                    } else if (fromDate!.day > toDate!.day) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "From date should be less then to date");
                                    } else if (_fromDate.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Date is empty");
                                    } else if (_toDate.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Date is empty");
                                    } else {
                                      preAdmissionController
                                          .getStudentDataTable(
                                        base: baseUrlFromInsCode(
                                            "login", widget.mskoolController),
                                        type: (searchRadioGroupValue ==
                                                'Year Wise')
                                            ? 'yearwise'
                                            : "btwdates",
                                        miId: widget.loginSuccessModel.mIID!,
                                        asmyId: (searchRadioGroupValue ==
                                                'Year Wise')
                                            ? assmId
                                            : 0,
                                        fromDate: (searchRadioGroupValue ==
                                                'Year Wise')
                                            ? todayDate
                                            : fromUtcTime,
                                        toDate: (searchRadioGroupValue ==
                                                'Year Wise')
                                            ? todayDate
                                            : toUtcTime,
                                        report: newSelectValue,
                                      )
                                          .then((value) {
                                        setState(() {
                                          preAdmissionController
                                              .updateIsLoading(true);
                                          // if (preAdmissionController
                                          //     .countData.isNotEmpty) {
                                          Get.to(() => StudentListTable(
                                                preAdmissionController:
                                                    preAdmissionController,
                                              ));
                                          // } else {
                                          //   Fluttertoast.showToast(
                                          //       msg: "No Record Found");
                                          // }
                                        });
                                      });
                                    }
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Search",
                                  style: Get.textTheme.titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 3.0,
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                setState(() {
                                  isCancelScrolled = false;
                                  isTableOpen = false;
                                  searchRadioGroupValue = 'Year Wise';
                                  selectRadioGroupValue = 'Registered List';
                                  _fromDate.clear();
                                  _toDate.clear();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Cancel",
                                  style: Get.textTheme.titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                        ]),
                  ),
                ],
              );
      }),
    );
  }
}
