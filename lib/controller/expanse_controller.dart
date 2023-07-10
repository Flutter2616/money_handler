import 'package:get/get.dart';
import 'package:money_handler/utils/database_helper.dart';

class Expansecontroller extends GetxController {
  RxList l1 = [].obs;
  RxInt pageindex = 0.obs;
  num totalincome=0;
  num overall=0;
  num totalexpanse=0;
  RxString dayselection = "Daily".obs;
  List<String> daylist = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
    "All",
    "Custom",
  ];

  Future<void> readdata() async {
    Databasehelper data = Databasehelper();
    l1.value = await data.readdb();
    totalamount();
    print("==================${totalincome}");
    print("==================${totalexpanse}");
    // update();
  }


  void dayfilter(int i)
  {
    dayselection.value=daylist[i];
    update();
  }


  void totalamount()
  {
    totalincome=0;
    totalexpanse=0;
    for(int i=0;i<l1.length;i++)
      {
        if(l1[i]['status']==0)
          {
            totalincome=totalincome+l1[i]['amount'];
          }
        else if(l1[i]['status']==1)
          {
            totalexpanse=totalexpanse+l1[i]['amount'];
          }
      }
    overall=totalincome-totalexpanse;
    update();
  }
}
