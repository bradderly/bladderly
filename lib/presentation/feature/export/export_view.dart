// // Flutter imports:
// // Project imports:
// import 'package:bladderly/presentation/common/bloc/membership_bloc.dart';
// import 'package:bladderly/presentation/feature/export/calendar/export_calendar_builder.dart';
// import 'package:bladderly/presentation/feature/export/report/export_report_builder.dart';
// import 'package:bladderly/presentation/feature/export/term/export_term_builder.dart';
// import 'package:bladderly/presentation/router/route/main_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ExportView extends StatefulWidget {
//   const ExportView({
//     super.key,
//   });

//   @override
//   State<ExportView> createState() => _ExportViewState();
// }

// class _ExportViewState extends State<ExportView> {
//   final pageContorller = PageController();

//   List<DateTime> selectedDates = <DateTime>[];

//   @override
//   void dispose() {
//     pageContorller.dispose();
//     super.dispose();
//   }

//   void animateToPage(int page) {
//     pageContorller.animateToPage(
//       page,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//         child: PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           controller: pageContorller,
//           children: [
//             ExportCalendarBuilder(
//               onTapNext: (dates) async {
//                 if (!context.read<MembershipBloc>().state.isValidMembership) {
//                   await ExportPageWallRoute().push<void>(context);
//                 }

//                 setState(() => selectedDates = dates);
//                 animateToPage(1);
//               },
//             ),
//             ExportTermBuilder(
//               onExport: () => animateToPage(2),
//               dates: selectedDates,
//             ),
//             const ExportReportBuilder(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ExportView extends StatelessWidget {
  const ExportView({
    super.key,
    required this.navigator,
  });

  final Widget navigator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: navigator,
      ),
    );
  }
}
