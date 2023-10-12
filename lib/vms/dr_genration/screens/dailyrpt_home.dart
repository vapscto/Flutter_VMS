import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/student/interaction/widget/custom_radio_button.dart';
import 'package:m_skool_flutter/vms/dr_genration/api/get_planner_details_api.dart';
import 'package:m_skool_flutter/vms/dr_genration/contoller/planner_details_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class DailyReportGenration extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final String pageName;
  const DailyReportGenration(
      {required this.loginSuccessModel,
      required this.mskoolController,
      required this.pageName,
      super.key});

  @override
  State<DailyReportGenration> createState() => _DailyReportGenrationState();
}

class _DailyReportGenrationState extends State<DailyReportGenration> {
  final PlannerDetails _plannerDetailsController = Get.put(PlannerDetails());
  RxBool halfDay = RxBool(false);
  @override
  void initState() {
    init();
    // _plannerDetailsController.plannernameDateController.value.text;
    super.initState();
  }

  init() async {
    await getPlanerdetails(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        controller: _plannerDetailsController,
        ivrmrtId: widget.loginSuccessModel.roleId!,
        miId: widget.loginSuccessModel.mIID!,
        userId: widget.loginSuccessModel.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageName),
        titleSpacing: 0,
        leading: const CustomGoBackButton(),
      ),
      body: Obx(
        () => _plannerDetailsController.loadPlanerDeatails.isTrue
            ? Container(
                child: const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/default.json',
                    title: 'Loading data',
                    desc: "Please wait we are loading data",
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 30),
                      child: CustomContainer(
                        child: Obx(
                          () => TextField(
                            controller: _plannerDetailsController
                                .plannernameEditingController.value,
                            readOnly: true,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3)),
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: Color.fromARGB(255, 234, 239, 255)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      " Planner Name ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 103, 118, 255)),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
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
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: CustomContainer(
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: RadioListTile(
                                    value: "today",
                                    groupValue:
                                        _plannerDetailsController.day.value,
                                    onChanged: (value) {
                                      _plannerDetailsController
                                          .updateDayRadio(value!);
                                    },
                                    dense: true,
                                    activeColor: Theme.of(context).primaryColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    visualDensity:
                                        const VisualDensity(horizontal: -4.0),
                                    title: Text(
                                      "Today's",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: RadioListTile(
                                    value: "Others",
                                    groupValue:
                                        _plannerDetailsController.day.value,
                                    dense: true,
                                    activeColor: Theme.of(context).primaryColor,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    visualDensity:
                                        const VisualDensity(horizontal: -4.0),
                                    title: Text(
                                      "Other's day",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.3)),
                                    ),
                                    onChanged: (value) {
                                      _plannerDetailsController
                                          .updateDayRadio(value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 10),
                      child: CustomContainer(
                        child: Obx(
                          () => TextField(
                            onTap: () async {
                              await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2035),
                                initialDate: DateTime.now(),
                              ).then((value) async {
                                _plannerDetailsController
                                    .plannernameDateController
                                    .value
                                    .text = await getDateNeed(value!);
                              });
                            },
                            controller: _plannerDetailsController
                                .plannernameDateController.value,
                            readOnly: true,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .merge(const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.3)),
                            decoration: InputDecoration(
                              hintText: "Select Date",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                size: 20,
                                color: Color.fromARGB(255, 47, 175, 51),
                              ),
                              border: const OutlineInputBorder(),
                              label: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0),
                                    color: Color.fromARGB(255, 212, 245, 206)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      " Date ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .merge(
                                            const TextStyle(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 20, 180, 15)),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
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
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: CustomContainer(
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "No.of Daily Report Generated In Other's Date : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .merge(const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 16, 103, 233)))),
                              TextSpan(
                                  text: _plannerDetailsController
                                      .otherDaysEditingController.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .merge(const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 16, 103, 233))))
                            ])),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: CustomContainer(
                          child: Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: halfDay.value,
                              onChanged: (value) {
                                halfDay.value = value!;
                              },
                              activeColor: Color.fromARGB(255, 33, 54, 243),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Text(
                              "Half Day Daily Report",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .merge(
                                    const TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            Color.fromARGB(255, 16, 103, 233)),
                                  ),
                            ),
                          ],
                        ),
                      )),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

Future<String> getDateNeed(DateTime dt) async {
  return "${dt.month.toString().padLeft(2, "0")}-${dt.day.toString().padLeft(2, "0")}-${dt.year}";
}
