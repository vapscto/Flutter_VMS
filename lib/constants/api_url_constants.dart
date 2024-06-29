class URLS {
  // static String base = "http://192.168.55.164:4000/";
  static String base = "http://43.205.143.174/";
  static String institutionCodeBaseUrl = "https://bdcampus.azurewebsites.net/";
  // static String base = "http://192.168.1.8:4000/";
  static String userPath = "api/user/";
  static String mobileNoLogin = "mobileno/login";
  static String passWordLogin = "accountLogin";
  static String otpVerification = "verify/otp";
  static String loginVerification = "islogin";
  static String signUp = "create";
  // static String logout = "logout";
  // static String getProfile = "profile";
  // static String updateProfile = "profile/update";
  static String fileUpload = "upload/file";
  static String versionControl = "api/EmployeePtalFacade/Mobileversion_control";
  static String getApiUrl = "api/LoginFacade/getinstitutionapiNew/";

  //Common ids used in all pages.
  static String miId = "mi_id";
  static String userId = "user_Id";
  static String asmayId = "asmaY_Id";
  static String ivrmrtId = "ivrmrt_Id";
  static String amstId = "amst_id";
  static String ivrmrtRole = "ivrmrt_role";
  static String hrmeId = "hrme_Id";

  // Endpoints for different Categories

  static String login = "api/LoginFacade";

  // profile
  // static String profile = "api/StudentDashboardFacade/Getdetails";

  //feedback
  // static String saveFeedBack = "api/StudentFeedbackFormFacade/savefeedback/";
  // static String getFeedBack = "api/StudentFeedbackFormFacade/getloaddata/";

  //Information
  static String uploadHomeWorkBase = "https://bdcampus.azurewebsites.net/";
  static String uploadHomeWorkEnd = "api/LoginFacade/HomeworkUpload";

  //ForgotPassword
  static String verifyUser = "api/LoginFacade/VerifyUserName";
  static String sendOtp = "api/LoginFacade/Mobileappotp";
  static String changePassword = "api/LoginFacade/forgotpassword";
  static String resetPassword = "api/changepwdFacade";
  static String verifyOTP = 'api/Login/VerifyEmailOtp';

  //PaymentApi

  static String getFeeDetForCurrentAcademic =
      "api/FeeOnlinePaymentFacade/getFeetotalamount";
  static String getInstallmentDetails =
      "api/FeeOnlinePaymentFacade/getpagedetails";

  static String openPaymentGateWay =
      "api/FeeOnlinePaymentFacade/mobilepayuconnect/";

  static String razorPayResponse =
      "api/FeeOnlinePaymentFacade/Razorpaypaymentresponse";
  static String easeBuzzPaymentResponseCall =
      "api/FeeOnlinePaymentFacade/getpaymentresponseeasybuzzmobile/";

  // Dashboard
  static String studentDashboard = "api/AdmissionCtrl/stdDashboardDet/";

  static String paymentCharges = "api/FeesCtrl/paymentGatewayrate/";

  static String emailOtp = "api/Login/ForgotOTPForEmail";

  static String updateHwSeen =
      "api/StudentDashboardFacade/onclick_Homework_seen/";

  static String transHistory = "api/FeesCtrl/feeTransactionlog/";

  static String transStatus = "api/FeesCtrl/feeTransactiondetail/";

  static String getSyllabusNotice =
      "api/StudentDashboardFacade/onclick_syllabus/";

  static String getTTNotice = "api/StudentDashboardFacade/onclick_TT/";

  static String stdFeeDue = "api/AdmissionCtrl/stdFeeDue/";

  static String updateCwSeen =
      "api/StudentDashboardFacade/onclick_classwork_seen/";

  static String dailyTT = "api/AdmissionCtrl/daywiseTimetable";

  /////   Interaction
  static String getStaffList = 'api/IVRM_InteractionsFacade/getdetails/';

  static String examGraph = "api/AdmissionCtrl/stdDashboardExam";
  static String getInboxData = 'api/IVRM_InteractionsFacade/getloaddata/';
  // static String getUnreadData = 'api/IVRM_InteractionsFacade/reply/';
  static String composeInteraction = 'api/IVRM_InteractionsFacade/savedetails/';
  static String getMessages = 'api/IVRM_InteractionsFacade/reply/';
  static String sendMessage = 'api/IVRM_InteractionsFacade/savereply/';
  static String interactionImageUpload = 'api/LoginFacade/InteractionUpload';

  // Role Constant's

  static String student = "Student";
  static String hod = "Hod";
  static String staff = "Staff";
  static int principal = 23;
  static int chairman = 22;
  static String manager = "Manager";

  // SALARY SLIP API .........
  static String getYearandMonth = 'api/SalarySlipFacade/onloadgetdetails/';
  static String getSalarySlipDetails =
      'api/SalarySlipFacade/GenerateEmployeeSalarySlip/';

  // SALARY DETAILS API .........
  static String salaryDetailsApi =
      "api/EmployeeSalaryDetailsFacade/getdaily_data/";
  static String getSalaryBreak =
      "api/EmployeeSalaryDetailsFacade/getsalaryalldetails/";

  // PunchReport
  static String punchReport = "api/EmployeePunchAttendenceFacade/getrpt/";

  /*  Staff Interaction */
  static String composeOnload = 'api/IVRM_InteractionsFacade/getdetails/';
  static String onChangeOfClass =
      'api/EmployeeStudentAttendenceDetailsFacade/Getsection/';
  static String onChangeOfSection = 'api/IVRM_InteractionsFacade/getstudent/';
  static String onSubmit = 'api/IVRM_InteractionsFacade/savedetails/';
  static String getInbox = 'api/IVRM_InteractionsFacade/getloaddata/';

  /* Online leave apply */
  static String getLeaveName =
      "api/OnlineLeaveApplicationFacade/getonlineLeave/";
  static String viewLeaveComment =
      "api/OnlineLeaveApplicationFacade/viewcomment/";
  static String appliedLeaves =
      "api/OnlineLeaveApplicationFacade/getonlineLeavestatus";
  static String saveLeave = "api/OnlineLeaveApplicationFacade/save/";
  static String checkLeaveBalance =
      'api/OnlineLeaveApplicationFacade/CheckAppliedDate/';
  static String leaveAuthorization =
      "api/OnlineLeaveApplicationFacade/CheckApprovalAuthorizationMapped/";
  static String leaveApprovalComment = 'api/LeaveApprovalFacade/viewcomment/';

  /* Global Endpoints */
  static String pushNotification = "api/AdmissionCtrl/PushNotificationonload/";
  static String attendanceShortage =
      "api/AdmissionCtrl/shortageOfAttendanceAlert";
  //LeaveApprovalManager
  static String getLeaves = "api/LeaveApprovalFacade/getApprovalStatus/";
  static String approveLeave = "api/LeaveApprovalFacade/get_status/";
  static String playStoreLink =
      "https://play.google.com/store/apps/details?id=com.app.vmss";
  static String expiredPwd = "api/changepwdFacade/";
  static String appStorelink =
      "https://apps.apple.com/us/app/vaps-management-system/id6470649988";

  static String onclickpurchaseapi = "api/IndentApprovalFacade/getpidetails/";
  static String purchaseindentapi = "api/IndentApprovalFacade/getloaddata/";
  // Maker and checker
  static String designationsListapi =
      "api/ISM_DailyReport_ApprovalFacade/GetDetails/";
  static String drDetailsApprove =
      "api/ISM_DailyReport_ApprovalFacade/GetSavedDetails/";
  static String employeeModelList =
      "api/ISM_DailyReport_ApprovalFacade/DesgSelectionDetails/";
  static String getDrs = "api/ISM_DailyReport_ApprovalFacade/GetSavedDetails/";
  static String getDrCheckList =
      "api/ISM_DailyReport_ApprovalFacade/ViewCheckListSavedDetails/";
  static String deptList =
      "api/ISM_DailyReport_ApprovalFacade/DeptSelectionDetails/";
  static String security = "api/ISMDashboardFacade/getdetails";
  static String submit =
      "api/ISM_DailyReport_ApprovalFacade/SaveApprovalDetails/";
  static String updateCheck = "api/CheckBookEntryApprovalFacade/ApprovalData/";
  static String getcmpn = "api/CheckBookEntryApprovalFacade/getalldata/";
  static String submitCheck = "api/CheckBookEntryApprovalFacade/Getdata/";

  //** TADA Advance Apply APIS **//
  static String stateList = 'api/TADA_Advance_ApplyFacade/getalldata/';
  static String cityList = 'api/TADA_Advance_ApplyFacade/getstate/';
  static String allowense = 'api/TADA_Advance_ApplyFacade/TadaAllwence/';
  static String saveTada = 'api/TADA_Advance_ApplyFacade/savedta/';
  static String tadaEdit = 'api/TADA_Advance_ApplyFacade/edit/';
  static String tadaDeactive = 'api/TADA_Advance_ApplyFacade/deactive/';
  //** TADA Advance Approval APIS **//
  static String tadaSave = 'api/TADAAdvanceApprovalFacade/savedta';
  static String tadaList = 'api/TADAAdvanceApprovalFacade/getalldata/';
  static String tadaDetails = 'api/TADAAdvanceApprovalFacade/edit';
  // ** TADA Approval **//
  static String tadaApprovalList = 'api/TADAApprovalFacade/getalldata/';
  static String tadaApprovalDetails = 'api/TADAApprovalFacade/edit';
  static String tadaApprovalSave = 'api/TADAApprovalFacade/savedta';

  //TADA Apply Apis
  static String stateAndClintList = 'api/TADA_ApplyFacade/getalldata/';
  static String tadaCityList = 'api/TADA_ApplyFacade/getstate/';
  static String tadaAllowense = 'api/TADA_ApplyFacade/TadaAllwence/';
  static String tadaApplyDeactive = 'api/TADA_ApplyFacade/deactive/';
  static String applyTada = 'api/TADA_ApplyFacade/savedta/';
  static String tadaApplyEdit = 'api/TADA_ApplyFacade/edit/';
  static String saveImage = 'api/TADA_ApplyFacade/Updatefile/';

  //**  PETTY CASH APPROVAL  **//

  static String onChangeInstitution =
      "api/PC_Indent_ApprovalFacade/OnChangeInstitution";
  static String onLoadPcApproval = "api/PC_Indent_ApprovalFacade/onloaddata";
  static String particularapprovedIndentPC =
      "api/PC_Indent_ApprovalFacade/Viewdata";
  static String particularIndentDetails =
      "api/PC_Indent_ApprovalFacade/getindentdetails";
  static String onChangeDatePC = "api/PC_Indent_ApprovalFacade/onchangedate";
  static String saveRecordPC = "api/PC_Indent_ApprovalFacade/saverecord";

  //**  PETTY INDENT APPROVAL  **//

  static String onLoadIndentApproval = "api/PC_IndentFacade/onloaddata";
  static String onChangeIndentapprovalIns =
      "api/PC_IndentFacade/OnChangeInstitution";
  static String onChangeIndentDatePC = "api/PC_IndentFacade/onchangedate";
  static String particularReqDetails =
      "api/PC_IndentFacade/getrequisitiondetails";
  static String indentDetailsApproved = "api/PC_IndentFacade/onloaddata";
  static String indentViewData = "api/PC_IndentFacade/Viewdata";
  static String saveRecordIndentPC = "api/PC_IndentFacade/saverecord";

  //** PETTY CASH REQUISITION **//
  static String departmentonLoadPCRequest =
      "api/PC_RequisitionFacade/onloaddata";
  static String employeeListPCRequest = "api/PC_RequisitionFacade/onchangedept";
  static String reqDetailsSaveRecord = "api/PC_RequisitionFacade/saverecord";
  static String viewDataPcReq = "api/PC_RequisitionFacade/Viewdata";
  //--- RATING REPORT API ENDPOINT ---//
  static String yearListRatingReport =
      "api/Rating_TransactionFacade/get_Consolidated_details";
  static String monthRatingReport =
      "api/Rating_TransactionFacade/get_Consolidated_details";
  static String dataReport = "api/Rating_TransactionFacade/getemployeereport/";
  static String taskGetDetails = "api/ISM_TaskCreationFacade/getdetails/";
  static String taskGetProjects = "api/ISM_TaskCreationFacade/get_category/";
  static String getTskClinet = "api/ISM_TaskCreationFacade/getmodule/";
  // Planner Creation
  static String planStatusList = 'api/ISM_PlannerCreationFacade/getdetails/';
  static String assignTaskList =
      'api/ISM_PlannerCreationFacade/geteffortdetails';
  static String purchaserequisitionapi =
      'api/INV_PurchaseRequisitionFacade/GetOnchangeData/';
  static String purchaseRequisitionSave =
      'api/INV_PurchaseRequisitionFacade/savedetails/';
  static String savePlanner = 'api/ISM_PlannerCreationFacade/savePlanner/';
  static String onchangeMoudleChange = "api/ISM_TaskCreationFacade/getIEuser/";

  // VMS common
  static String logintransation = 'api/LoginFacade/getRoleData';
  static String saveTaskCreation = "api/ISM_TaskCreationFacade/savedata/";

  // Sales Report
  static String department = 'api/ISM_Client_ProjectFacade/getcmtrpt_data/';
  static String designation = 'api/ISM_Client_ProjectFacade/get_desig/';
  static String employeeList = 'api/ISM_Client_ProjectFacade/get_employee/';
  static String salesList = 'api/ISM_Client_ProjectFacade/report_cmtrpt/';
  // Pre sales
  static String preSalesList = 'api/Sales_Lead_Facade/get_load_lead_demo/';
  static String priSalesView = 'api/Sales_Lead_Facade/view_lead_demo/';
  //
  static String visitormanagementapi =
      "api/AddVisitorsFacade/getAssignDetails/";
  static String gridoptionapi =
      "api/AddVisitorsFacade/getVisitorAssignDetails/";
  static String saveapi = "api/AddVisitorsFacade/saveAssignedData/";
  static String gpsFeacth = "api/GPSLocationFacade/getalldetails/";
  static String savePunchApi = "api/GPSLocationFacade/savedata/";
  static String drDetailsGenration =
      "api/ISM_DailyReportGenerationFacade/loaddata/";
  static String plannerList = 'api/ISM_PlannerApprovalFacade/getdetails/';
  static String plannerApprovelist =
      'api/ISM_PlannerApprovalFacade/getplannerdetails/';
  static String plannerSave =
      "api/ISM_PlannerApprovalFacade/updateplannerStatus";
  static String profileData = 'api/ISMDashboardFacade/getdetails/';
  static String visitorapprovalapi =
      'api/V_AppointmentApprovalStatusFacade/getDetails/';
  static String leaveCountList =
      "api/OnlineLeaveApplicationFacade/getonlineLeave";
  static String hcClassList = "api/HW_HeathCheckUpFacade/OnLoadHWHealthCheckUp";
  static String saveHC = "api/HW_HeathCheckUpFacade/SaveHWHealthChekUp";
  static String getdocxApi = 'api/HW_HeathCheckUpFacade/ViewHealthCheckUpFiles';
  static String getTaskCheckList =
      "api/ISM_DailyReportGenerationFacade/GetCategoryChecklistDetails";
  //Interaction VMS
  static String staffList = 'api/ISM_InteractionFacade/getdetails/';
  static String interactionSave = 'api/ISM_InteractionFacade/savedata';
  static String interactionAllList =
      'api/ISM_InteractionFacade/get_replydetails';
  static String vmsInteractionSave = 'api/ISM_InteractionFacade/savereply';
  static String vmsMessageList = 'api/ISM_InteractionFacade/get_replydetails';
  // VMS Notification
  static String vMSNotification = 'api/ISM_InteractionFacade/getnotification';
  //dr
  static String drSaveAPI =
      'api/ISM_DailyReportGenerationFacade/generatedailyreport';
  static String drNotSave =
      'api/ISM_DailyReportGenerationFacade/SaveDRNotSentRemarks';
  static String otpCheck = "api/CheckBookEntryFacade/geterifyEmail/";
  static String seacurityTaskSave =
      "api/StaffAreaActivityRecordFacade/Activitysavedetails/";

  ///////////  PURCHASE API //////////////

  static String purchaseLoadData = "api/IndentApprovalFacade/getloaddata/";
  static String purchaseSaveApi = "api/IndentApprovalFacade/savedetails/";
  static String indentItem = "api/INV_PurchaseRequisitionFacade/getitemDetail/";
  static String othersDayCount =
      'api/ISM_DailyReportGenerationFacade/Otherdaycount/';
  static String punchList = 'api/ISMDashboardFacade/getdetails/';
  static String addExtraTaskDR =
      'api/ISM_DailyReportGenerationFacade/addextratask/';
  static String previousTaskList =
      'api/ISM_DailyReportGenerationFacade/searchpreviousdailyreport/';
  static String instituteList = 'api/LoginFacade/getMIdataMaster';
  static String extensionLoad = 'api/ISM_ExtensionFacade/getdetails';
  static String extensionSave = 'api/ISM_ExtensionFacade/savedata';
  static String attendance =
      'api/FrontOfficeMonthEndReportFacade/getmonthreport/';
  //Certificate Approval
  static String certificateList =
      'api/ISM_Certificate_Process_Facade/loaddata/';
  static String certificateFileView =
      'api/ISM_Certificate_Process_Facade/viewuploadflies';
  static String certificateApprove =
      'api/ISM_Certificate_Process_Facade/approvedrecord';
  //Driver indent
  static String driverIndent = 'api/DriverIndent/getApprovalStatus/';
  static String driverIndentApprove = 'api/DriverIndent/get_status/';
  static String driverIndentReject = 'api/DriverIndent/reject_status/';
  //Interview feed back
  static String interviewList =
      'api/CandidateInterviewListVMSFacade/onloadgetdetails';
  static String saveFeedback =
      'api/AddCandidateInterviewVMSFacade/savefeedback/';
  static String editData = 'api/CandidateInterviewListVMSFacade/getRecordById/';
  static String getLeads = "api/TADA_Advance_TourFacade/getload";
  static String saveLeads = "api/TADA_Advance_TourFacade/savedata";
  // NOC Approval
  static String nocLoad = 'api/HR_NOC_Process_Facade/loaddata';
  static String nocDetails = 'api/HR_NOC_Process_Facade/viewuploadflies';
  static String nocApproval = 'api/HR_NOC_Process_Facade/approvedrecord';

  //
  static String taskList = 'api/ISMDashboardFacade/pendingissues/';
  // All Emp rating
  static String allEmpRating =
      'api/Rating_TransactionFacade/get_Consolidated_details';
  static String ratingList = 'api/Rating_TransactionFacade/mobemployeerating/';

  static String purchaserequisitiongridapi =
      'api/INV_PurchaseRequisitionFacade/getloaddata';

  static String ontapviewapi =
      'api/INV_PurchaseRequisitionFacade/get_prdetails/';

  static String onpurchaseviewapi =
      'api/INV_RequisitionNotificationFacade/savedetails/';

  static String getTourName = "api/TADA_Advance_TourFacade/getload";

  static String getTourLeadList = "api/TADA_Advance_TourFacade/Lead_Update";
  // Call Letter
  static String generateTemplate = 'api/AppointmentFacade/';
  static String sendCallletter =
      'api/AddCandidateVMSFacade/sendCallLettermail/';

  static String getTourDemoResponseApi =
      "api/TADA_Advance_TourFacade/Edit_response_lead_demo";

  static String getSaveDemoResponse =
      "api/TADA_Advance_TourFacade/Save_response_lead_demo";

  static String getLeadDemoResponse =
      "api/TADA_Advance_TourFacade/view_lead_demo";

  //Interview schdule
  static String interviewSchduleOnLoad =
      'api/AddCandidateInterviewVMSFacade/onloadgetdetails';
  static String interviewSchedule = 'api/AddCandidateInterviewVMSFacade/';
  //Job Posting
  static String jobPostingOnLoad = 'api/AddJobVMSFacade/onloadgetdetails';
  static String postJob = 'api/AddJobVMSFacade/';
  // Add to HRMS
  static String addToHrmsOnLoad = 'api/AddtoHRMSFacade/onloadgetdetails';
  static String addToHrmsSave = 'api/AddtoHRMSFacade/savetohrms/';
  static String candidateDetails = 'api/AppointmentFacade/getcandidate/';

  static String candidate =
      'api/CandidateInterviewListVMSFacade/getallwithoutcondtn/';

  // Interview Report
  static String report = 'api/AddCandidateInterviewVMSFacade/getrpt';
  //
  static String newcandidate = 'api/CandidateListVMSFacade/onloadgetdetails';

  static String getTourViews = "api/TADAAdvanceApprovalFacade/getTourApproval/";
  static String editTadaTour = "api/TADAAdvanceApprovalFacade/editTour/";

  static String getViewTada = "api/TADAAdvanceApprovalFacade/getView/";

  static String getTadaCat = "api/TADAAdvanceApprovalFacade/TadaAllwence/";

  static String getLeadsClients = "api/TADAAdvanceApprovalFacade/TadaAllwence/";

  static String savaTadaTourApi = "api/TADAAdvanceApprovalFacade/TourApproval/";

  static String getFinalAdavncedViewApi =
      "api/TADAApprovalFacade/getfinaldata/";

  static String getTadaTourPlanerDetails =
      "api/TADA_Advance_TourFacade/FinalSubMission/";

  static String getViewAdancedFinal = "api/TADAApprovalFacade/editTada/";

  static String saveFinalTadaApproval = "api/TADAApprovalFacade/savefinaldta/";
  // Staff gate pass
  static String gatePassOnload = 'api/StaffGatePassFacade/Getdetails';
  static String gatePassDeg = 'api/StaffGatePassFacade/getdepchange/';
  static String gatePassEmpList = 'api/StaffGatePassFacade/get_staff1';
  static String gatePassSave = 'api/StaffGatePassFacade/saveRecord';
  static String gatePassActive = 'api/StaffGatePassFacade/deactive';
  // planner Deviation
  static String devEmpList = 'api/ISM_PlannerDeviationReportFacade/getdetails/';
  static String devReport =
      'api/ISM_PlannerDeviationReportFacade/getdeviationReport';
}
