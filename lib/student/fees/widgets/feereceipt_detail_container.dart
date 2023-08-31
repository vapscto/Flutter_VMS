import 'package:flutter/material.dart';
import 'package:m_skool_flutter/constants/constants.dart';
import 'package:m_skool_flutter/student/fees/model/fee_receipt_details_model.dart';

class FeeReceiptDetailContainer extends StatefulWidget {
  final List<CurrpaymentdetailsValues> currentPaymentDataList;
  final FillStudentViewDetails dataModel;
  final String logo;
  const FeeReceiptDetailContainer({
    super.key,
    required this.dataModel,
    required this.logo,
    required this.currentPaymentDataList,
  });

  @override
  State<FeeReceiptDetailContainer> createState() =>
      _FeeReceiptDetailContainerState();
}

class _FeeReceiptDetailContainerState extends State<FeeReceiptDetailContainer> {
  double totalCharges = 0.0;
  double totalConcession = 0.0;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.dataModel.values!.length; i++) {
      totalCharges += widget.dataModel.values!.elementAt(i).ftPPaidAmt ?? 0.0;
      totalConcession +=
          widget.dataModel.values!.elementAt(i).ftPConcessionAmt ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 8,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fee Details',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.network(
              //   widget.logo,
              //   height: 36,
              // ),
              const SizedBox(
                width: 12.0,
              ),
              widget.logo.startsWith("http") || widget.logo.startsWith("https")
                  ? Image.network(
                      widget.logo,
                      width: 150,
                    )
                  : Text(
                      widget.logo,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .merge(const TextStyle(color: Color(0xFF35658F))),
                    ),
            ],
          ),
          const SizedBox(height: 15),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.065,
              mainAxisSpacing: 4,
              childAspectRatio: 1 / 0.05,
            ),
            children: [
              Text(
                'Receipt No        : ${widget.dataModel.values!.first.fyPReceiptNo}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Date                     : ${widget.dataModel.values!.first.fyPDate!.day} - ${widget.dataModel.values!.first.fyPDate!.month} - ${widget.dataModel.values!.first.fyPDate!.year}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Adm No             : ${widget.dataModel.values!.first.admno}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Session               : ${widget.dataModel.values!.first.admno}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Name                 : ${widget.dataModel.values!.first.amsTFirstName} ${widget.dataModel.values!.first.amsTMiddleName} ${widget.dataModel.values!.first.amsTLastName}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Class/sec           : ${widget.dataModel.values!.first.classname}/${widget.dataModel.values!.first.sectionname}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Father Name    : ${widget.dataModel.values!.first.fathername}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Type                    : ${widget.dataModel.values!.first.fMCCConcessionName}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'TransactionId   : ${widget.dataModel.values!.first.fypTransactionId}',
                style: const TextStyle(
                    fontSize: 7,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              // Text(
              //   'Duration             : ${widget.dataModel.values!.first.admno}',
              //   style: const TextStyle(
              //       fontSize: 7,
              //       color: Colors.black,
              //       fontWeight: FontWeight.w500),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DataTable(
                dataTextStyle: const TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                dataRowHeight: 24,
                headingRowHeight: 24,
                horizontalMargin: 2,
                columnSpacing: 20,
                dividerThickness: 1,
                headingTextStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
                border: TableBorder.all(width: 1, color: Colors.black),
                showBottomBorder: true,
                headingRowColor: MaterialStateProperty.all(
                    const Color.fromRGBO(227, 244, 255, 1)),
                columns: const [
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'S.No',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Particulars',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Installments',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Concession',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '  Paid\nAmount',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                ],
                rows: [
                  ...List.generate(widget.dataModel.values!.length, (index) {
                    var i = index + 1;
                    return DataRow(
                      cells: [
                        DataCell(
                          Text('$i'),
                        ),
                        DataCell(Text(widget.dataModel.values!
                            .elementAt(index)
                            .fmHFeeName!)),
                        DataCell(Text(widget.dataModel.values!
                            .elementAt(index)
                            .ftIName!)),
                        DataCell(Center(
                            child: Text(widget.dataModel.values!
                                .elementAt(index)
                                .ftPConcessionAmt
                                .toString()))),
                        DataCell(Text(widget.dataModel.values!
                            .elementAt(index)
                            .ftPPaidAmt
                            .toString())),
                      ],
                    );
                  }),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text('**'),
                      ),
                      const DataCell(Text("Total Amount")),
                      const DataCell(Text("-------")),
                      DataCell(Center(child: Text(totalConcession.toString()))),
                      DataCell(Text(totalCharges.toString())),
                    ],
                  ),
                ]),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            'Current Payment Details',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: DataTable(
                dataTextStyle: const TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                dataRowHeight: 24,
                headingRowHeight: 24,
                horizontalMargin: 2,
                columnSpacing: 20,
                dividerThickness: 1,
                headingTextStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
                border: TableBorder.all(width: 1, color: Colors.black),
                showBottomBorder: true,
                headingRowColor: MaterialStateProperty.all(
                    const Color.fromRGBO(227, 244, 255, 1)),
                columns: const [
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'S.No',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Amount',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Bank',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'DD.No',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '  Date',
                      style: TextStyle(fontSize: 7),
                    ),
                  ),
                ],
                rows: [
                  ...List.generate(widget.currentPaymentDataList.length,
                      (index) {
                    var i = index + 1;
                    var dt = DateTime.parse(widget.currentPaymentDataList
                        .elementAt(index)
                        .fyPDate!);
                    return DataRow(
                      cells: [
                        DataCell(
                          Text('$i'),
                        ),
                        DataCell(Text(widget.currentPaymentDataList
                            .elementAt(index)
                            .ftPPaidAmt
                            .toString())),
                        DataCell(Text(widget.currentPaymentDataList
                            .elementAt(index)
                            .fyPBankName
                            .toString())),
                        DataCell(Center(
                            child: Text(widget.currentPaymentDataList
                                .elementAt(index)
                                .fyPDDChequeNo
                                .toString()))),
                        DataCell(Text(
                            "${numberList[dt.day]}-${numberList[dt.month]}-${dt.year}")),
                      ],
                    );
                  }),
                  // DataRow(
                  //   cells: [
                  //     const DataCell(
                  //       Text('1'),
                  //     ),
                  //     const DataCell(Text("Total Amount")),
                  //     const DataCell(Text("-------")),
                  //     DataCell(Center(child: Text(totalConcession.toString()))),
                  //     DataCell(Text(totalCharges.toString())),
                  //   ],
                  // ),
                ]),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
