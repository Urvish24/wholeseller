class AppStrings {
  static String _baseUrl = "http://3.7.65.119:16002/api/";//"http://65.2.38.98:16002/api/";
  static String loginUrl = _baseUrl+'user/signIn';
  static String signout = _baseUrl+'user/signout';
  static String customerList = _baseUrl+'user/customerList';
  static String customerCreate = _baseUrl+'user/customerCreate';
  static String uploadImage = _baseUrl+'user/uploadData';
  static String dashboard = _baseUrl+'user/dashboard';
  static String dashboardSales = _baseUrl+'user/salesDashboard';
  static String customerUpdate = _baseUrl+'user/customerEdit/';
  static String itemUpdate = _baseUrl+'item/edit/';
  static String deleteItem = _baseUrl+'item/delete/';
  static String createItem = _baseUrl+'item/create';
  static String listServer = _baseUrl+'item/listServer';
  static String listZoho = _baseUrl+'item/list';
  static String slabList = _baseUrl+'slab/list';
  static String slabCreate = _baseUrl+'slab/create';
  static String slabUpdate = _baseUrl+'slab/edit/';
  static String createEstimateForUser = _baseUrl+'estimate/create';
  static String editEstimateForUser = _baseUrl+'estimate/edit/';
  static String estimateListForUser = _baseUrl+'estimate/list';
  static String estimateReports = _baseUrl+'user/estimateReports';
  static String estimateDeleteForUser = _baseUrl+'estimate/delete/';
  static String estimateUpdate = _baseUrl+'estimate/updateUrl/';
  static String estimateUpdateStatus = _baseUrl+'estimate/updateStatus/';
  static String invoiceUrl = _baseUrl+'estimate/listInvoiceCustomer/';
  static String invoiceByIdUrl = _baseUrl+'estimate/listInvoice/';
  static String estimateByIdUrl = _baseUrl+'estimate/detail/';
  static String stateListApi = _baseUrl+'user/stateList';
  static String sallesListApi = _baseUrl+'user/salesList';
  static String saleCreate = _baseUrl+'user/saleCreate';
  static String forgotPassword = _baseUrl+'user/forgotPassword';
  static String saleEdit = _baseUrl+'user/salesEdit/';
  static String reports = _baseUrl+'user/reports';
  static String settings = _baseUrl+'item/settings';
  static String listEstimatesPendingCount = _baseUrl+'estimate/listEstimatesPendingCount';



}