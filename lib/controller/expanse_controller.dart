import 'package:get/get.dart';
import 'package:money_handler/controller/add_controller.dart';
import 'package:money_handler/expanse_modal/budgetmodal.dart';
import 'package:money_handler/utils/database_helper.dart';

class Expansecontroller extends GetxController {
  RxList<Map> l1 = <Map>[].obs;
  RxList<Map> budgetlist = <Map>[].obs;

  RxInt pageindex = 0.obs;
  num totalincome = 0;
  num overall = 0;
  num totalexpanse = 0;
  RxString dayselection = "Daily".obs;
  List<String> daylist = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly",
    "All",
    "Custom",
  ];
  List expanse_category = [
    "Bills and utilities",
    "Food and Drinks",
    "Entertainment",
    "Investment",
    "Transportation",
    "Shopping",
    "Medical",
    "Education",
    "Gifts and Donation",
    "Insurance",
    "Taxes",
    "other",
  ];
  List income_category = [
    "Salary",
    "Sales",
    "Awards",
    "Other",
  ];

  Future<void> readdata() async {
    Databasehelper data = Databasehelper();
    l1.value = await data.readdb();
    budgetlist.value = await data.budgetread();
    print("${budgetlist.length}********************");
    if (budgetlist.isEmpty) {
      createBudget();
    }
    totalamount();
    budget_SpentTotal();
    // update();
  }

  Future<void> createBudget() async {
    Databasehelper data = Databasehelper();
    for (int j = 0; j < expanse_category.length; j++) {
      Budgetmodal b = Budgetmodal(category: expanse_category[j]);
      await data.budgetinsert(b);
    }
  }

  void dayfilter(int i) {
    dayselection.value = daylist[i];
    update();
  }

  void totalamount() {
    totalincome = 0;
    totalexpanse = 0;
    for (int i = 0; i < l1.length; i++) {
      if (l1[i]['status'] == 0) {
        totalincome = totalincome + l1[i]['amount'];
      } else if (l1[i]['status'] == 1) {
        totalexpanse = totalexpanse + l1[i]['amount'];
      }
    }
    overall = totalincome - totalexpanse;
    update();
  }

  RxList<Map> spentlist = <Map>[].obs;

  void budget_SpentTotal() {
    spentlist.clear();
    RxList<Map> blist = <Map>[
      {"category": "Bills and utilities", "spent": 0},
      {"category": "Food and Drinks", "spent": 0},
      {"category": "Entertainment", "spent": 0},
      {"category": "Investment", "spent": 0},
      {"category": "Transportation", "spent": 0},
      {"category": "Shopping", "spent": 0},
      {"category": "Medical", "spent": 0},
      {"category": "Education", "spent": 0},
      {"category": "Gifts and Donation", "spent": 0},
      {"category": "Insurance", "spent": 0},
      {"category": "Taxes", "spent": 0},
      {"category": "other", "spent": 0},
    ].obs;

    for (int i = 0; i < blist.length; i++) {
      for (int j = 0; j < l1.length; j++) {
        if (l1[j]['category'] == blist[i]['category']) {
          blist[i]['spent'] += l1[j]['amount'];
        }
      }
      // if (budgetlist[i]['budget'] == null) {
      //   Databasehelper data = Databasehelper();
      //   Budgetmodal b = Budgetmodal(
      //       category: budgetlist[i]['categoryname'],
      //       id: budgetlist[i]['id'],
      //       amount: blist[i]['spent']);
      //   data.budgetupdate(b);
      //   readdata();
      // }
    }
    // print(blist);
    spentlist = blist;
    // print(spentlist);
  }

  List filterlist = [
        "Income",
        "Expanse",
  ];
  RxInt type = 0.obs;
  RxString category="".obs;

  Future<void> read_filterdata({type, cate}) async {
    Databasehelper data = Databasehelper();
    l1.value = await data.filterdata(type: type,category: cate);
    print("Filter l1:${l1}");
  }
}
