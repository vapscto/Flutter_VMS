import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/student/library/model/library_data_model.dart';
import 'package:m_skool_flutter/student/library/widget/library_dt_status.dart';
import 'package:m_skool_flutter/student/library/widget/library_sub_item.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';

class LibraryItemWidget extends StatelessWidget {
  final Color color;
  final LibraryDetailsValues bookDetails;
  const LibraryItemWidget({
    Key? key,
    required this.color,
    required this.bookDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Container(
        decoration: BoxDecoration(
            color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookDetails.lMBBookTitle!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8.0,
              ),
              LibrarySubItem(
                  title: "Accession No",
                  value: bookDetails.lMBANOAccessionNo ?? "N/a"),
              const SizedBox(
                height: 12.0,
              ),
              LibrarySubItem(
                  title: "Status", value: bookDetails.lBTRStatus ?? "N/a"),
              const SizedBox(
                height: 12.0,
              ),
              LibrarySubItem(
                  title: "Total Fine",
                  value: "₹ ${bookDetails.lBTRTotalFine ?? "N/a"}"),
              const SizedBox(
                height: 12.0,
              ),
              LibrarySubItem(
                  title: "Total Fine Collected",
                  value: "₹ ${bookDetails.lBTRFineCollected ?? "N/a"}"),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: Row(
                  // alignment: WrapAlignment.center,
                  // runSpacing: 16.0,
                  // spacing: 16.0,
                  children: [
                    Expanded(
                      child: LibraryStatusDate(
                        title: "Issued",
                        date: bookDetails.lBTRIssuedDate == null
                            ? "N/A"
                            : getFormatedDate(
                                DateTime.parse(bookDetails.lBTRIssuedDate!)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: LibraryStatusDate(
                        title: "Due",
                        date: bookDetails.lBTRDueDate == null
                            ? "N/A"
                            : getFormatedDate(
                                DateTime.parse(bookDetails.lBTRDueDate!)),
                        color: const Color(0xFFFF968F),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: LibraryStatusDate(
                        title: "Return",
                        date: bookDetails.lBTRReturnedDate == null
                            ? "N/A"
                            : getFormatedDate(
                                DateTime.parse(bookDetails.lBTRReturnedDate!)),
                        color: const Color(0xFFB9F0B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
