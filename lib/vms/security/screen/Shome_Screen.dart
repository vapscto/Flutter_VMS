import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_skool_flutter/controller/global_utilities.dart';
import 'package:m_skool_flutter/controller/mskoll_controller.dart';
import 'package:m_skool_flutter/model/login_success_model.dart';
import 'package:m_skool_flutter/vms/security/api/api.dart';
import 'package:m_skool_flutter/vms/security/controller/security_controller.dart';
import 'package:m_skool_flutter/widget/animated_progress_widget.dart';
import 'package:m_skool_flutter/widget/custom_app_bar.dart';
import 'package:m_skool_flutter/widget/custom_back_btn.dart';

class ShomeScreen extends StatefulWidget {
  final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  ShomeScreen(
      {required this.loginSuccessModel,
      required this.mskoolController,
      super.key});

  @override
  State<ShomeScreen> createState() => _ShomeScreenState();
}

class _ShomeScreenState extends State<ShomeScreen> {
  SecurtyWorkController controller = Get.put(SecurtyWorkController());
  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    await feacthSecurityApi(
        base: baseUrlFromInsCode('issuemanager', widget.mskoolController),
        ivrmrtId: widget.loginSuccessModel.roleId!,
        userId: widget.loginSuccessModel.userId!,
        mi_id: widget.loginSuccessModel.mIID!,
        controller: controller,
        loginSuccessModel: widget.loginSuccessModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          leading: const CustomGoBackButton(),
          title: const Text(
            "Security",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Obx(() => controller.securtyWorkList.isEmpty
              ? const AnimatedProgressWidget(
                  animationPath: 'assets/json/nodata.json',
                  title: 'No data',
                  desc: "there is no data",
                )
              :  SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DataTable(
                          dataTextStyle: const TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(0, 0, 0, 0.95),
                              fontWeight: FontWeight.w500),
                          dataRowHeight: 150,
                          headingRowHeight: 40,
                          horizontalMargin: 10,
                          columnSpacing: 30,
                          dividerThickness: 1,
                          headingTextStyle: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                          border: TableBorder.all(
                              borderRadius: BorderRadius.circular(10),
                              width: 0.5),
                          headingRowColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          columns: const [
                            DataColumn(
                              numeric: true,
                              label: Align(
                                alignment: Alignment.center,
                              ),
                            ),
                            // 1
                            DataColumn(
                              numeric: true,
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'S.No',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            //2
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'BuildingName',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            // 3
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'FloorName',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            // 4
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'AreaName',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            // 5
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'ActivityName',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            // 6
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),

                            //7
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            //8
                            DataColumn(
                              label: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'ActivityDuration',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(controller.securtyWorkList.length,
                              (index) {
                            var i = index + 1;
                            return DataRow(
                              cells: [
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Checkbox(
                                      checkColor: Colors.indigo,
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onChanged: (value) async{
                                        controller.securityUploadImage.clear();
                                        controller.checkBox[index] = !value!;
                                        setState(() {});
                                              controller.getFromCamera(miId: 0,base: "").then((value) {
                                                if(value){
                                                 showDialog(
                                            context: context,
                                            builder: (_) {
                                              return Dialog(
                                                  insetPadding:
                                                      const EdgeInsets.all(
                                                          16.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0)),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16.0,
                                                                  vertical:
                                                                      16.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8.0),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                 child: Text(
                                                                  "Upload images",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  controller.checkBox[
                                                                          index] =
                                                                      value;
                                                                  setState(
                                                                      () {});
                                                                  Get.back();
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .close_sharp,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      Obx(() =>  Container(
                                                          height: 200,
                                                          child: ListView.builder(itemBuilder: (context, index) {
                                                            return Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                ListTile(
                                                                  title:Text(controller.securityUploadImage[index],style: TextStyle(
                                                                     color:Colors.black
                                                                  ),) ,
                                                                ),
                                                                SizedBox(height: 20,),
                                                                 SizedBox(
                                                                  width: 120,
                                                                   child: ElevatedButton(
                                                                    
                                                                    onPressed: () {
                                                                     
                                                                   },
                                                                    
                                                                   child: Center(child: Text("submit")),),
                                                                 )
                                                              ],
                                                            );
                                                          },
                                                          itemCount: controller.securityUploadImage.length,
                                                          ),
                                                        ))
                                                      ]));
                                            });
                                                }
                                              },);
                                      

                                        ///
                                      },
                                      value: !controller.checkBox[index],
                                    ))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text('$i'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        width: 100,
                                        child: Text(
                                            '${controller.securtyWorkList.elementAt(index).hRMBBuildingName}')))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${controller.securtyWorkList.elementAt(index).hRMFFloorName}'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${controller.securtyWorkList.elementAt(index).hRMARAreaName}'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${controller.securtyWorkList.elementAt(index).hRMARACTActivityName}'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${controller.securtyWorkList.elementAt(index).hRMARACTSTMAPDate}'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${controller.securtyWorkList.elementAt(index).hRMARACTTTime}'))),
                                DataCell(Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '${controller.securtyWorkList.elementAt(index).hRMARACTTActivityDuration}'))),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    controller.checkBox.clear();
    super.dispose();
  }
}
