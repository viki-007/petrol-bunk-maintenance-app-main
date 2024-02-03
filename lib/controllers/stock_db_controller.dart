import 'package:get/get.dart';
import '../database/stock_bd.dart';

class StockDBController extends GetxController{

  @override
  void onInit() {
    getFromApi();
    super.onInit();
  }
  
  StockDB stockDB = StockDB();
  List<dynamic> data = [].obs ;

  getFromApi() async {
    data = await stockDB.getFromDB() ;
    update();
  }
}