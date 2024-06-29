import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/api/deviation_api.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/controller/deviation_controller.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/deviation_details.dart';
import 'package:m_skool_flutter/vms/issue_manager/planner_deviation/model/dev_emp_list_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

class PlannerDeviationScreen extends StatefulWidget {
  final String title;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  const PlannerDeviationScreen(
      {super.key,
      required this.title,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<PlannerDeviationScreen> createState() => _PlannerDeviationScreenState();
}

class _PlannerDeviationScreenState extends State<PlannerDeviationScreen> {
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  DateTime? fdt;
  DateTime? toDt;
  DeviationController controller = Get.put(DeviationController());
  _onLoad() async {
    controller.loading(true);
    await DeviationAPI.i.empList(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!,
        controller: controller);
    controller.filterEmpList.assignAll(controller.empList);
    controller.selectCheckBox =
        RxList<bool>.filled(controller.filterEmpList.length, false);
    controller.loading(false);
  }

  final searchController = TextEditingController();
  _filterData(String data) {
    if (data.isEmpty) {
      controller.filterEmpList.assignAll(controller.empList);
    } else {
      controller.filterEmpList.value = controller.empList.where((p0) {
        return p0.userEmpName!.toLowerCase().contains(data.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    _onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading',
                desc: "Please wait we are loading data",
              ))
            : (controller.empList.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                      animationPath: 'assets/json/nodata.json',
                      title: 'No data',
                      desc: "",
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomContainer(
                                child: TextField(
                                  style: Theme.of(context).textTheme.titleSmall,
                                  readOnly: true,
                                  controller: fromDate,
                                  onTap: () async {
                                    fdt = await showDatePicker(
                                      context: context,
                                      helpText: "Select From Data",
                                      firstDate: DateTime(2000),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime(3050),
                                    );
                                    if (fdt != null) {
                                      setState(() {
                                        fromDate.text =
                                            "${numberList[fdt!.day]}:${numberList[fdt!.month]}:${fdt!.year}";
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.calendar_month,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 40.0, left: 12),
                                    border: const OutlineInputBorder(),
                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          color: const Color(0xFFE5F3FF)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/calendar_icon.svg",
                                            color: const Color(0xFF3E78AA),
                                            height: 18,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " Start Date ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFF3E78AA),
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: 'Select Date',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
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
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: CustomContainer(
                                child: TextField(
                                  readOnly: true,
                                  style: Theme.of(context).textTheme.titleSmall,
                                  controller: toDate,
                                  onTap: () async {
                                    if (fdt != null) {
                                      toDt = await showDatePicker(
                                        context: context,
                                        helpText: "Select To Date",
                                        firstDate: fdt!,
                                        initialDate: fdt!,
                                        lastDate: DateTime(3050),
                                      );
                                      if (toDt != null) {
                                        toDate.text =
                                            "${numberList[toDt!.day]}:${numberList[toDt!.month]}:${toDt!.year}";
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Start Date");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        top: 40.0, left: 12),
                                    suffixIcon: Icon(
                                      Icons.calendar_month,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    border: const OutlineInputBorder(),
                                    label: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          color: const Color(0xFFE5F3FF)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/calendar_icon.svg",
                                            color: const Color(0xFF3E78AA),
                                            height: 18,
                                          ),
                                          const SizedBox(
                                            width: 6.0,
                                          ),
                                          Text(
                                            " End Date ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .merge(
                                                  const TextStyle(
                                                      fontSize: 18.0,
                                                      color: Color(0xFF3E78AA)),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: 'Select Date',
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall,
                                  controller: searchController,
                                  onChanged: (value) {
                                    _filterData(value);
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Employee Name...",
                                      contentPadding: const EdgeInsets.all(3),
                                      hintStyle: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.grey))),
                                ),
                              ),
                              (controller.filterEmpList.isEmpty)
                                  ? const SizedBox()
                                  : CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          side: const BorderSide(
                                              color: Colors.grey)),
                                      activeColor:
                                          const Color.fromARGB(255, 1, 16, 29),
                                      visualDensity: const VisualDensity(
                                          vertical: -4, horizontal: -4),
                                      title: Text(
                                        "Select All",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                      ),
                                      value: selectAll,
                                      onChanged: (value) {
                                        setState(() {
                                          selectAll = value!;
                                          if (selectAll) {
                                            controller.selectCheckBox =
                                                RxList<bool>.filled(
                                                    controller
                                                        .filterEmpList.length,
                                                    true);
                                            controller.addedEmpList = RxList<
                                                    DeviationEmpModelValues>.from(
                                                controller.filterEmpList);
                                          } else {
                                            controller.selectCheckBox =
                                                RxList<bool>.filled(
                                                    controller
                                                        .filterEmpList.length,
                                                    false);
                                            controller.addedEmpList.clear();
                                          }
                                        });
                                      },
                                    ),
                              (controller.filterEmpList.isEmpty)
                                  ? const SizedBox()
                                  : Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              controller.filterEmpList.length,
                                          itemBuilder: (context, index) {
                                            return CheckboxListTile(
                                              contentPadding: EdgeInsets.zero,
                                              checkboxShape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      side: const BorderSide(
                                                          color: Colors.grey)),
                                              activeColor: const Color.fromARGB(
                                                  255, 3, 57, 105),
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: -4,
                                                      horizontal: -4),
                                              title: Text(
                                                "${controller.filterEmpList[index].userEmpName}",
                                                style: Get.textTheme.titleSmall,
                                              ),
                                              value: controller
                                                  .selectCheckBox[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  controller.selectCheckBox[
                                                      index] = value!;
                                                  if (value) {
                                                    controller.addedEmpList.add(
                                                        controller
                                                                .filterEmpList[
                                                            index]);
                                                  } else {
                                                    controller.addedEmpList
                                                        .removeWhere((emp) =>
                                                            emp.hRMEId ==
                                                            controller
                                                                .filterEmpList[
                                                                    index]
                                                                .hRMEId);
                                                  }
                                                  // Update selectAll based on the state of individual checkboxes
                                                  selectAll = controller
                                                      .selectCheckBox
                                                      .every(
                                                          (element) => element);
                                                });
                                              },
                                            );
                                          }))
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MSkollBtn(
                              title: "Search",
                              onPress: () {
                                if (toDate.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "Select Date");
                                  return;
                                } else if (controller.addedEmpList.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Select Employee");
                                  return;
                                } else {
                                  Get.to(() => DeviationDetails(
                                        controller: controller,
                                        fDt: fdt!,
                                        toDt: toDt!,
                                        mskoolController:
                                            widget.mskoolController,
                                      ));
                                }
                              }),
                        ),
                      )
                    ],
                  );
      }),
    );
  }

  bool selectAll = false;
  @override
  void dispose() {
    // controller.addedEmpList.clear();
    controller.selectCheckBox.clear();
    controller.filterEmpList.clear();
    fromDate.clear();
    toDate.clear();
    selectAll = false;
    super.dispose();
  }
}
