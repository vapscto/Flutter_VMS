import 'package:flutter/material.dart';
import 'package:m_skool_flutter/student/exam/model/result_model.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class ResultContainerWidget extends StatelessWidget {
  const ResultContainerWidget({
    Key? key,
    required this.resultModel,
    required this.title,
  }) : super(key: key);

  final List<ResultModel> resultModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.red.shade100,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(
              16.0,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .merge(const TextStyle(color: Color(0xFF35658F))),
            ),
          ),
          ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return ListTile(
                visualDensity:
                    const VisualDensity(vertical: VisualDensity.minimumDensity),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  resultModel.elementAt(index).title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Text(resultModel.elementAt(index).value),
              );
            },
            // separatorBuilder: (_, index) {

            // },
            itemCount: resultModel.length,
          )
        ],
      ),
    );
  }
}
