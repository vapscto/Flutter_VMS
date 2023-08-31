import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/main.dart';
import 'package:m_skool_flutter/student/library/api/library_data_api.dart';
import 'package:m_skool_flutter/student/library/model/library_data_model.dart';
import 'package:m_skool_flutter/student/library/widget/library_item_widget.dart';
import 'package:m_skool_flutter/student/library/widget/line_chart_trackball.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';
import 'package:m_skool_flutter/widget/home_fab.dart';

class LibraryHome extends StatelessWidget {
  final int asmayId;
  final int miId;
  final int asmtId;
  final String title;
  final String base;
  const LibraryHome({
    super.key,
    required this.asmayId,
    required this.miId,
    required this.asmtId,
    required this.base,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFab(),
      appBar: CustomAppBar(title: title).getAppBar(),
      body: FutureBuilder<LibraryDataModel>(
          future: LibraryDataApi.instance
              .getLibraryData(miId, asmayId, asmtId, base),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              int colorIndex = -1;

              if (snapshot.data!.librarydetails == null ||
                  snapshot.data!.librarydetails!.values == null ||
                  snapshot.data!.librarydetails!.values!.isEmpty) {
                return const AnimatedProgressWidget(
                    title: "No Book Found",
                    animatorHeight: 250,
                    desc:
                        "I think you haven't issued any book's or data is not available in db",
                    animationPath: "assets/json/nodata.json");
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    LineChartLib(
                      libraryGraph: snapshot.data!.libraryGraphs!,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (_, index) {
                          colorIndex += 1;
                          if (index % 6 == 0) {
                            colorIndex = 0;
                          }
                          logger.d(colors.elementAt(colorIndex));
                          return LibraryItemWidget(
                            color: colors.elementAt(colorIndex),
                            bookDetails: snapshot.data!.librarydetails!.values!
                                .elementAt(index),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const SizedBox(
                            height: 16.0,
                          );
                        },
                        itemCount:
                            snapshot.data!.librarydetails!.values!.length),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return ErrWidget(err: snapshot.error as Map<String, dynamic>);
            }

            return const AnimatedProgressWidget(
              title: "Getting your library ready",
              desc:
                  "We are getting your library details, please wait while we fetch it for you.",
              animationPath: "assets/json/lib.json",
            );
          }),
    );
  }
}

class CustomPgrWidget extends StatelessWidget {
  final String title;
  final String desc;
  const CustomPgrWidget({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(fontSize: 24.0),
                  ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryStatusDate extends StatelessWidget {
  final Color color;
  final String title;
  final String date;
  const LibraryStatusDate({
    Key? key,
    required this.color,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: (Get.size.width * 0.5) - 48,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: color,
      ),
      child: Column(
        children: [
          Text(
            title,
            style:
                Theme.of(context).textTheme.labelMedium!.merge(const TextStyle(
                      fontSize: 14.0,
                    )),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.titleSmall!.merge(
                  const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
          )
        ],
      ),
    );
  }
}
