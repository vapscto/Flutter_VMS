// import 'package:flutter/material.dart';

// class SelectMonthScrollContainer extends StatefulWidget {
//   const SelectMonthScrollContainer({super.key});

//   @override
//   State<SelectMonthScrollContainer> createState() =>
//       _SelectMonthScrollContainerState();
// }

// class _SelectMonthScrollContainerState
//     extends State<SelectMonthScrollContainer> {
//   List<String> demoList = [
//     'Demo',
//     'Demo1',
//     'Demo3',
//     'Demo5',
//     'Demo6',
//     'Demo7',
//     'Demo8',
//   ];
//   String slected = 'Demo';
//   var ee = false;
//   final _controller = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           height: 180,
//           padding: const EdgeInsets.only(top: 10, bottom: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).scaffoldBackgroundColor,
//             borderRadius: BorderRadius.circular(16.0),
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(0, 1),
//                 blurRadius: 4,
//                 color: Colors.black12,
//               ),
//             ],
//           ),
//           child: RawScrollbar(
//             thumbColor: const Color(0xFF1E38FC),
//             trackColor: const Color.fromRGBO(223, 239, 253, 1),
//             trackRadius: const Radius.circular(10),
//             trackVisibility: true,
//             radius: const Radius.circular(10),
//             thickness: 14,
//             thumbVisibility: true,
//             controller: _controller,
//             child: ListView.builder(
//               // padding: const EdgeInsets.only(top: 1),
//               controller: _controller,
//               itemCount: demoList.length,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   height: 30,
//                   child: CheckboxListTile(
//                     controlAffinity: ListTileControlAffinity.leading,
//                     checkboxShape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6)),
//                     dense: true,
//                     activeColor: Theme.of(context).primaryColor,
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//                     visualDensity: const VisualDensity(horizontal: -4.0),
//                     title: Text(
//                       demoList[index],
//                       style: Theme.of(context).textTheme.labelSmall!.merge(
//                           const TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14.0,
//                               letterSpacing: 0.3)),
//                     ),
//                     value: ee,
//                     onChanged: (value) {
//                       setState(() {
//                         ee = value!;
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         Positioned(
//           top: -20,
//           left: 14,
//           child: Container(
//             height: 30,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
//             decoration: const BoxDecoration(
//               color: Color.fromRGBO(229, 243, 255, 1),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(12),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   'assets/images/darkbluecalendar.png',
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   'Select Month',
//                   style: Theme.of(context).textTheme.titleSmall!.merge(
//                         const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14.0,
//                           color: Color.fromRGBO(62, 120, 170, 1),
//                         ),
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
