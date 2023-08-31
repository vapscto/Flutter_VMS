// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:m_skool_flutter/main.dart';
// import 'package:m_skool_flutter/student/interaction/controller/interaction_controller.dart';
// import 'package:m_skool_flutter/student/interaction/widget/attach_file_field.dart';
// import 'package:m_skool_flutter/student/interaction/widget/custom_dropdown.dart';
// import 'package:m_skool_flutter/student/interaction/widget/custom_radio_button.dart';
// import 'package:m_skool_flutter/student/interaction/widget/custom_text_file.dart';
// import 'package:m_skool_flutter/widget/mskoll_btn.dart';

// class ComposeTabScreen extends StatefulWidget {
//   const ComposeTabScreen({super.key});

//   @override
//   State<ComposeTabScreen> createState() => _ComposeTabScreenState();
// }

// class _ComposeTabScreenState extends State<ComposeTabScreen> {
//   final _controller = Get.put(InteractionController());
//   final groupRadioGroup = [
//     RadioBox(name: "Student", value: true),
//     RadioBox(name: "Teacher", value: false),
//   ];
//   final List<RadioBox<String>> individualRadioGroup = [
//     RadioBox(name: "Student", value: "student"),
//     RadioBox(name: "Teacher", value: "teacher"),
//     RadioBox(name: "HOD", value: "hod"),
//     RadioBox(name: "Principle", value: "principle"),
//     RadioBox(name: "Academic Supervisor", value: "supervisor"),
//     RadioBox(name: "Exam Coordinator", value: "coordinator"),
//   ];
//   @override
//   void initState() {
//     logger.d('compose');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomRadioButton<bool>(
//             initial: _controller.isGroup.value,
//             radios: [
//               RadioBox(name: "Group", value: true),
//               RadioBox(name: "Individual", value: false),
//             ],
//             onChange: _controller.onGroupTypeSelect,
//           ),
//           SizedBox(width: Get.width * 0.1),
//           const SizedBox(height: 10),
//           CustomTextField(
//               label: "Group Name", controller: TextEditingController()),
//           const SizedBox(height: 20),
//           CustomTextField(label: "About", controller: TextEditingController()),
//           const SizedBox(height: 10),
//           Obx(() => _controller.isGroup.value
//               ? CustomRadioButton<bool>(
//                   initial: _controller.isStudent.value,
//                   alignment: MainAxisAlignment.start,
//                   radios: groupRadioGroup,
//                   onChange: _controller.onUserGroupType,
//                 )
//               : CustomRadioButton<String>(
//                   direction: Axis.vertical,
//                   initial: "student",
//                   radios: individualRadioGroup,
//                   onChange: _controller.onIndividualGroupType,
//                 )),
//           const SizedBox(height: 10),
//           Obx(() => Column(children: [
//                 if (_controller.isStudent.value) ...[
//                   CustomDropdown(
//                       label: "Class",
//                       items: const ['I', 'II', 'III'],
//                       onChange: (s) {}),
//                   const SizedBox(height: 25),
//                   CustomDropdown(
//                       label: "Section",
//                       items: const ['A', 'B', 'C'],
//                       onChange: (s) {}),
//                   const SizedBox(height: 25),
//                   CustomDropdown(
//                       label: "Select Students",
//                       items: const ['All', 'Class B', 'Class C'],
//                       onChange: (s) {}),
//                 ],
//                 if (!_controller.isStudent.value)
//                   CustomDropdown(
//                       label: "Select Teacher",
//                       items: const ['All', 'Class B', 'Class C'],
//                       onChange: (s) {}),
//               ])),
//           const SizedBox(height: 25),
//           const AttachFileField(label: "Attach Files"),
//           const SizedBox(height: 25),
//           Center(
//             child: MSkollBtn(
//               title: "Send",
//               size: const Size(120, 45),
//               onPress: () {},
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
