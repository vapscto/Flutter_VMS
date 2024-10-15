import 'package:get/get.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/employee_model.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/gridoption_model.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/insituional_model.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/visitor_details.dart';
import 'package:m_skool_flutter/vms/visitor%20managements/model/visitor_model.dart';

class VisitorManagementsController extends GetxController {
  RxBool isFromDataRequestVisitor = RxBool(false);
  RxBool isLoadingRequestVisitor = RxBool(false);

  void updateIsFromDataVisitor(bool isProvided) {
    isFromDataRequestVisitor.value = isProvided;
  }

  void updateIsLoadingVisitor(bool isLoading) {
    isLoadingRequestVisitor.value = isLoading;
  }

  RxList<InstitutionlistModelValues> getrequestGetVisitorList =
      <InstitutionlistModelValues>[].obs;

  RxBool isErrorOccuredVisitor = RxBool(false);

  void getData(List<InstitutionlistModelValues> data) {
    if (getrequestGetVisitorList.isNotEmpty) {
      getrequestGetVisitorList.clear();
    }
    for (int i = 0; i < data.length; i++) {
      getrequestGetVisitorList.add(data.elementAt(i));
    }
  }

  void updateIsErrorOccuredVisitor(bool error) {
    isErrorOccuredVisitor.value = error;
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////

  RxBool isFromDataRequestvisit = RxBool(false);
  RxBool isLoadingRequestVisit = RxBool(false);

  void updateIsFromDataVisit(bool isProvided) {
    isFromDataRequestvisit.value = isProvided;
  }

  void updateIsLoadingVisit(bool isLoading) {
    isLoadingRequestVisit.value = isLoading;
  }

  RxList<VisitorlistModelValues> getrequestGetVisitList =
      <VisitorlistModelValues>[].obs;

  RxBool isErrorOccuredVisit = RxBool(false);

  void getvisitor(List<VisitorlistModelValues> data) {
    if (getrequestGetVisitList.isNotEmpty) {
      getrequestGetVisitList.clear();
    }
    for (int i = 0; i < data.length; i++) {
      getrequestGetVisitList.add(data.elementAt(i));
    }
  }

  void updateIsErrorOccuredVisit(bool error) {
    isErrorOccuredVisit.value = error;
  }

//////////////////////////////////////////////////////////////////////////////////////////

  RxBool isFromDataRequestassigned = RxBool(false);
  RxBool isLoadingRequestassigned = RxBool(false);

  void updateIsFromDataassigned(bool isProvided) {
    isFromDataRequestassigned.value = isProvided;
  }

  void updateIsLoadingassigned(bool isLoading) {
    isLoadingRequestassigned.value = isLoading;
  }

  RxList<GridOptionslistModelValues> getrequestGetgridoptionList =
      <GridOptionslistModelValues>[].obs;

  RxBool isErrorOccuredassigned = RxBool(false);

  void getassigned(List<GridOptionslistModelValues> data) {
    if (getrequestGetgridoptionList.isNotEmpty) {
      getrequestGetgridoptionList.clear();
    }
    for (int i = 0; i < data.length; i++) {
      getrequestGetgridoptionList.add(data.elementAt(i));
    }
  }

  void updateIsErrorOccuredassigned(bool error) {
    isErrorOccuredassigned.value = error;
  }

/////////////////////////////////////////////////////////////////////////////////////////////////

  RxBool isFromDataRequestemployee = RxBool(false);
  RxBool isLoadingRequestemployee = RxBool(false);

  void updateIsFromDataemployee(bool isProvided) {
    isFromDataRequestemployee.value = isProvided;
  }

  void updateIsLoadingemployee(bool isLoading) {
    isLoadingRequestemployee.value = isLoading;
  }

  RxList<EmployeelistModelValues> getrequestGetemployeeList =
      <EmployeelistModelValues>[].obs;

  RxBool isErrorOccuredemployee = RxBool(false);

  void getemployee(List<EmployeelistModelValues> data) {
    if (getrequestGetemployeeList.isNotEmpty) {
      getrequestGetemployeeList.clear();
    }
    for (int i = 0; i < data.length; i++) {
      getrequestGetemployeeList.add(data.elementAt(i));
    }
  }

  void updateIsErrorOccuredempoyee(bool error) {
    isErrorOccuredemployee.value = error;
  }
////////////////////////////////////////////////////////////////////////////////////////////////

  RxBool isFromDataRequestsave = RxBool(false);
  RxBool isLoadingRequestsave = RxBool(false);

  void updateIsFromDatasave(bool isProvided) {
    isFromDataRequestsave.value = isProvided;
  }

  void updateIsLoadingsave(bool isLoading) {
    isLoadingRequestsave.value = isLoading;
  }

  RxBool isErrorOccuredsave = RxBool(false);

  void updateIsErrorOccuredsave(bool error) {
    isErrorOccuredsave.value = error;
  }

  // QR Loading
  RxBool isQrLoading = RxBool(false);
  RxList<VisitorDetailsModelValues> visitorData =
      <VisitorDetailsModelValues>[].obs;
}
