import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/api/candidate_api.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/api/candidate_edit_api.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/controller/candidate_controller.dart';
import 'package:m_skool_flutter/vms/candidate_interview_list/model/edit_candidate_model.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import '../../../main.dart';
import '../../../widget/animated_progress_widget.dart';
import '../../../widget/drop_down_level.dart';

class EditFormCandidate extends StatefulWidget {
   final LoginSuccessModel loginSuccessModel;
   final MskoolController mskoolController;
    //  final DataChangeCandidateModelValues values;
  const EditFormCandidate(
  {super.key, 
  required this.loginSuccessModel,
  required this.mskoolController, 
 });

  @override
  State<EditFormCandidate> createState() => _EditFormCandidateState();
}

class _EditFormCandidateState extends State<EditFormCandidate> {
CandidateController controller = Get.put(CandidateController());
  final dateController = TextEditingController();
    List<String> radioList = ['E-mail', 'SMS'];
      String selectedRadio = '';
        List<String> dropDownList = ['Face to Face', 'Written', 'Techincal', 'HR Round', 'Department Head', 'Managerial', 'MD Round', 'Third Party', 'Others'];
         String selectedData = 'Face to Face';

  @override
  void initState() {
    CandidateListApi.instance.getCandidateListApi(
        base: baseUrlFromInsCode('recruitement', widget.mskoolController),
        userId: widget.loginSuccessModel.userId!,
        controller: controller, miId: widget.loginSuccessModel.mIID!, );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 return  Scaffold(
  appBar: const CustomAppBar(title: 'Edit Form Candidate').getAppBar(),

   body: Obx(() {
        return controller.isUpdateLoading.value
            ? const AnimatedProgressWidget(
                animationPath: "assets/json/default.json",
                title: "Loading",
                desc: "We are under process to get your details from server.")
            : controller.updateeditData.isNotEmpty
                ? const SizedBox()
                : ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: CustomContainer(
                            child:
                                DropdownButtonFormField<DataChangeCandidateModelValues>(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: const EdgeInsets.all(16.0),
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
                                hintText: 'Select Candidates',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFDFFBFE),
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/cap.png",
                                        height: 28.0,
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Text(
                                        "Candidate List",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF28B6C8))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                ),
                              ),
                              iconSize: 30,
                              items: List.generate(
                                controller.getcandiateeditList.length,
                                (index) =>
                                    DropdownMenuItem<DataChangeCandidateModelValues>(
                                  value: controller.getcandiateeditList.elementAt(index),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 8, right: 8),
                                    child: Text(
                                      controller.getcandiateeditList
                                              .elementAt(index)
                                              .hrcDFullName!,
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
                              onChanged: (s) async {
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
            margin: const EdgeInsets.only(top: 14, bottom: 10),
            child: CustomContainer(
              child: TextField(
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate:
                        DateTime.now(),
                    initialDate:
                        DateTime.now().subtract(const Duration(days: 1)),
                  ).then((newValue) async {
                    dateController.text = await getDateNeed(newValue!);
                  });
                },
                controller: dateController,
                readOnly: true,
                style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3)),
                decoration: InputDecoration(
                  hintText: "Select Date",
                  hintStyle: Theme.of(context).textTheme.titleSmall!.merge(
                      const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w300)),
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
                        color: const Color.fromARGB(255, 212, 245, 206)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Interview Date",
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                                const TextStyle(
                                    fontSize: 20.0,
                                    color: Color.fromARGB(255, 20, 180, 15)),
                              ),
                        ),
                      ],
                    ),
                  ),
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
                ),
              ),
            ),
          ),
                                const SizedBox(
                                      height: 10,
                                     ),
                                         Text(
                                        "Notify Candidate By",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(const TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(255, 216, 64, 4))),
                                      ),
                      Wrap(
                        children: List.generate(radioList.length, (index) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                listTileTheme: const ListTileThemeData(
                                    minVerticalPadding: 2),
                                unselectedWidgetColor:
                                    Theme.of(context).primaryColor),
                            child: RadioListTile(
                                activeColor: Theme.of(context).primaryColor,
                                title: Text(
                                  radioList[index],
                                  style: Get.textTheme.titleSmall,
                                ),
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    vertical: VisualDensity.minimumDensity,
                                    horizontal: VisualDensity.minimumDensity),
                                value: radioList[index],
                                groupValue: selectedRadio,
                                onChanged: (value) {
                                  selectedRadio = value!;
                                  logger.i(selectedRadio);
                                  setState(() {});
                                }),
                          );
                        }),
                      ),
                    const SizedBox(height: 05),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: dropDownList[1],
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
                            hintText: dropDownList.isNotEmpty
                                ? 'Select Status'
                                : 'No data available',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true,
                            label: const CustomDropDownLabel(
                              icon: 'assets/images/hat.png',
                              containerColor: Color.fromRGBO(223, 251, 254, 1),
                              text: 'Interview Rounds ',
                              textColor: Color.fromRGBO(40, 182, 200, 1),
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
                          items: List.generate(dropDownList.length, (index) {
                            return DropdownMenuItem(
                              value: dropDownList[index],
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 13, left: 5),
                                child: Text(
                                  overflow: TextOverflow.clip,
                                  dropDownList[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                          letterSpacing: 0.3)),
                                ),
                              ),
                            );
                          }),
                          onChanged: (s) async {
                            selectedData = s!;
                            logger.v(selectedData);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                       Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: CustomContainer(
                            child:
                                DropdownButtonFormField<DataChangeCandidateModelValues>(
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: const EdgeInsets.all(16.0),
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
                                hintText: 'Select Candidates',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                label: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFDFFBFE),
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/cap.png",
                                        height: 28.0,
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Text(
                                        "Interviewer Name",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .merge(const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF28B6C8))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                ),
                              ),
                              iconSize: 30,
                              items: List.generate(
                                controller.getcandiateeditList.length,
                                (index) =>
                                    DropdownMenuItem<DataChangeCandidateModelValues>(
                                  value: controller.getcandiateeditList.elementAt(index),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 8, right: 8),
                                    child: Text(
                                      controller.getcandiateeditList
                                              .elementAt(index)
                                              .hrcDFullName!,
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
                              onChanged: (s) async {
                              },
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                       Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 16),
                        child: CustomContainer(
                            child: TextFormField(
                          style: Get.textTheme.titleSmall,
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          controller: dateController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 12),
                            border: const OutlineInputBorder(),
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
                            hintText: "Interview Venue:",
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
                                    color:
                                        const Color.fromRGBO(40, 182, 200, 1),
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    "Interview Venue",
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
                          ),
                        )),
                      ),
                      const SizedBox(height: 30),
                      
                    ],
                  );
                  
        }),

    );
  }
}

Future<String> getDateNeed(DateTime dt) async {
  return "${dt.day.toString().padLeft(2, "0")}-${dt.month.toString().padLeft(2, "0")}-${dt.year}";
}
