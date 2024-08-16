// import 'package:filehive/core/utils/colors.dart';
// import 'package:filehive/core/utils/other_constants.dart';
// import 'package:filehive/core/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// class TypesButtons extends StatelessWidget {
//   const TypesButtons({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     List<String> buttonLabels = ["All", "Images", "Documents"];
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//           borderRadius: generalBorderRadius.add(BorderRadius.circular(2)),
//           border: Border.all(color: kPrimaryColor)),
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: buttonLabels
//               .asMap()
//               .entries
//               .map(
//                 (entry) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: CustomButton(
//                     backgroundColor:
//                         entry.key == 0 ? kSecondaryColor : transparentColor,
//                     textColor:
//                         entry.key == 0 ? Colors.white : kSecondaryColor,
//                     text: entry.value,
//                     fontSize: 15,
//                     borderRadius: generalBorderRadius,
//                     onPressed: () {
//                       // Handle button press
//                       print('Pressed ${entry.value}');
//                     },
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
