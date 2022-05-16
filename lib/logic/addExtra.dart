import 'package:holland/data/variableModel.dart';
import 'package:holland/model/extra_item.dart';
import 'package:holland/model/menu_item.dart';

addExtraWidget({required bool isAdd, required int index, required int order}) {
  MenuItem shopOrder = listMenuItem[index];
  if (isAdd) {
    listShopOrder.add(shopOrder);
  } else {
    (order == 0) ? listShopOrder = [] : listShopOrder.removeAt(order - 1);
  }
  // Membbuat semua selected item menjadi false
  for (var k = 0; k < order; k++) {
    for (var l = 0; l < listShopOrder[k].extraItem.length; l++) {
      listShopOrder[k].extraItem[l].isSelected = false;
    }
  }
}

addExtraItem({required int i, required int j, required bool check}) {
  // ExtraItem exIt = listShopOrder[i].extraItem[j];
  // exIt.isSelected = check;
  // listShopOrder[i].extraItem[j] = exIt;
  listShopOrder[i].extraItem[j].isSelected =
      !listShopOrder[i].extraItem[j].isSelected;
  total = 0;
  // Menghitung ulang total
  total += (listShopOrder[i].price) * listShopOrder.length;
  if (listShopOrder[i].extraItem[j].isSelected) {
    if (check) {
      total += (listShopOrder[i].extraItem[j].price) * listShopOrder.length;
    } else {
      total -= (listShopOrder[i].extraItem[j].price) * listShopOrder.length;
    }
  }
}
