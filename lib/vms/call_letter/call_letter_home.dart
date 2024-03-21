import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/call_letter/api/call_letter_api.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/mskoll_btn.dart';

// ignore: must_be_immutable
class CallLetterHome extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;
  final String title;
  const CallLetterHome(
      {super.key,
      required this.title,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<CallLetterHome> createState() => _CallLetterHomeState();
}

class _CallLetterHomeState extends State<CallLetterHome> {
  final _key = GlobalKey<FormState>();

  final callLetterController = TextEditingController();

  final candidateNameController = TextEditingController();

  final addressController = TextEditingController();

  final positionController = TextEditingController();

  final candidateEmail = TextEditingController();

  final companyController = TextEditingController();

  final jobPostingSiteController = TextEditingController();

  final jobLocationController = TextEditingController();

  final postDateController = TextEditingController();

  final interviewDt = TextEditingController();

  final interviewTime = TextEditingController();

  final officeEmail = TextEditingController();

  final officePhone = TextEditingController();

  List companyName = [
    'Vaps Kuowledge services Pvt Ltd',
    'Vaps Technosoft Pvt Ltd',
    'Unnathi Marketing',
    'Smart Infrastructure and Service',
    'Marga Innovation Infrastructure and Developer',
    'Pacific System Enterprises',
    'Global Quality Training & Assessors Pvt Ltd'
  ];

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title).getAppBar(),
      body: Form(
          key: _key,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: callLetterController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter call letter No.";
                  }
                  return null;
                },
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Call Letter",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelText: "Call Letter",
                    labelStyle: Get.textTheme.titleSmall,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.indigo)),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: candidateNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Candidate name";
                  }
                  return null;
                },
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Candidate Name",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Candidate Name',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: addressController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Candidate Address";
                  }
                  return null;
                },
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Candidate Address",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Candidate Address',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: positionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Position Name";
                  }
                  return null;
                },
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Position Name",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Position Name',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: candidateEmail,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Candidate Email Id";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Candidate Email Id",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Candidate Email Id',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null) {
                    return 'Select Company';
                  }
                  return null;
                },
                iconSize: 0,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                ),
                decoration: InputDecoration(
                    hintText: "Job Posting Site",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Job Posting Site',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
                items: List.generate(companyName.length, (index) {
                  return DropdownMenuItem(
                      value: companyName[index],
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          companyName[index],
                          maxLines: 2,
                          style: Get.textTheme.titleSmall,
                        ),
                      ));
                }),
                onChanged: (value) {
                  controller.text = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: jobPostingSiteController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Job Posting Site Name";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Job Posting Site",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Job Posting Site',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: jobLocationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Job Location Name";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Job Location Name",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Job Location Name',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: postDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Select Job Post Date";
                  }
                  return null;
                },
                readOnly: true,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Job Post Date",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Job Post Date',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
                onTap: () async {
                  postDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030));
                  if (postDate != null) {
                    postDateController.text = dateFormat(postDate!);
                  } else {
                    Fluttertoast.showToast(msg: "Select Date");
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: interviewDt,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Select Date Of Interview";
                  }
                  return null;
                },
                readOnly: true,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Interview Date",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Interview Date',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
                onTap: () async {
                  ivDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030));
                  if (ivDate != null) {
                    interviewDt.text = dateFormat(ivDate!);
                  } else {
                    Fluttertoast.showToast(msg: "Select Date");
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: interviewTime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Select Interview Time";
                  }
                  return null;
                },
                readOnly: true,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Interview Time",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Interview Time',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
                onTap: () async {
                  newTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (newTime != null) {
                    interviewTime.text =
                        '${newTime!.hourOfPeriod}:${newTime!.minute} ${newTime!.period.name.toUpperCase()}';
                  } else {
                    Fluttertoast.showToast(msg: "Select Time");
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: officeEmail,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Office Email Id";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Office Email Id",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Office Email Id',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: officePhone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Office Ph No.";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                style: Get.textTheme.titleSmall,
                decoration: InputDecoration(
                    hintText: "Office Office Ph No.",
                    hintStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                    labelStyle: Get.textTheme.titleSmall,
                    labelText: 'Office Office Ph No.',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red))),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MSkollBtn(
                    title: "Generate Template",
                    onPress: () async {
                      if (_key.currentState!.validate()) {
                        await generateCallLetter(
                                base: baseUrlFromInsCode(
                                    'recruitement', widget.mskoolController),
                                updateBy: widget.loginSuccessModel.userId!)
                            .then((value) {
                          if (value == 'Error occured') {
                            Fluttertoast.showToast(
                                msg: "Template is not Generated");
                          } else {
                            Fluttertoast.showToast(
                                msg: "Template Generated Successfully");
                            callLetterController.clear();
                            candidateNameController.clear();
                            addressController.clear();
                            positionController.clear();
                            candidateEmail.clear();
                            companyController.clear();
                            jobPostingSiteController.clear();
                            jobLocationController.clear();
                            postDateController.clear();
                            interviewDt.clear();
                            interviewTime.clear();
                            officeEmail.clear();
                            officePhone.clear();
                            Get.back();
                            setState(() {});
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: "Fill All Fields");
                      }
                    }),
              )
            ],
          )),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }

  DateTime? postDate;
  DateTime? ivDate;
  TimeOfDay? newTime;
}
