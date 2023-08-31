import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/manager/feedemo/api/get_fee_report_api.dart';
import 'package:m_skool_flutter/manager/feedemo/controller/fee_demo_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_container.dart';
import 'package:m_skool_flutter/widget/err_widget.dart';




class FeeReporthome extends StatefulWidget {
  const FeeReporthome({super.key, required this.loginSuccessModel, required this.controller, required this.feeDemoController});
    final LoginSuccessModel loginSuccessModel;
  final MskoolController controller;

  final FeeDemoController feeDemoController;
  

  @override
  State<FeeReporthome> createState() => _FeeReporthomeState();
}


  @override
  void initState() {
    
  }

class _FeeReporthomeState extends State<FeeReporthome> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Fee  Details").getAppBar(),
      body: FutureBuilder(
          future: GetfeereportApi.instance.getfeereport(
              miId: widget.loginSuccessModel.mIID!,
              asmayId: widget.loginSuccessModel.asmaYId!,
              base: baseUrlFromInsCode("portal", widget.controller),
              controller:widget.feeDemoController,),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: AnimatedProgressWidget(
                    animationPath: 'assets/json/nodata.json',
                    title: 'No Details found',
                    desc: "For this month or employee has no data to show",
                    animatorHeight: 250,
                  ),
                );
              } 

 
//  int mobile;
//  String name;
//  String class_Name;
//  String section;
//  String regno;
             
             
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: CustomContainer(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SingleChildScrollView( 
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        headingRowColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        // columnSpacing: 36,
                        columns: [
                          DataColumn(
                              label: Text(
                                "Student Name",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(color: Colors.white)),
                              )),
                          DataColumn(
                              label: Text(
                                "Class",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(color: Colors.white)),
                              )),
                          DataColumn(
                              label: Text(
                                "Section",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(color: Colors.white)),
                              )),
                          DataColumn(
                              label: Text(
                                "Reg No",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(color: Colors.white)),
                              )),
                          DataColumn(
                              label: Text(
                                "Mobile Number",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(color: Colors.white)),
                              )),
                          DataColumn(
                              label: Text(
                                "Balance",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .merge(const TextStyle(color: Colors.white)),
                              )),
                        ],
                    
                        rows: List.generate(snapshot.data!.length, (index) =>  DataRow(
                            cells: [
                              DataCell(Center(child: Text("${snapshot.data!.elementAt(index).name}"))),
                              DataCell(Center(child: Text("${snapshot.data!.elementAt(index).className}"))),
                              DataCell(Center(child: Text("${snapshot.data!.elementAt(index).section}"))),
                              DataCell(Center(child: Text("${snapshot.data!.elementAt(index).regno}"))),
                              DataCell(Center(child: Text("${snapshot.data!.elementAt(index).mobile}"))),
                              DataCell(Center(child: Text("${snapshot.data!.elementAt(index).balance}"))),
                                  
                            ],
                          ),),
                      
                      ),
                    ),
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return ErrWidget(
                err: snapshot.error as Map<String, dynamic>,
              );
            }
            return const Center(
              child: AnimatedProgressWidget(
                animationPath: 'assets/json/default.json',
                title: 'Loading fee Details',
                desc: "We are getting fee Details, please wait for while",
              ),
            );
          }),
    );
  }
}