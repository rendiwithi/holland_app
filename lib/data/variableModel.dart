import 'package:holland/model/menu_model.dart';
import 'package:holland/model/voucher_model.dart';

// Public
List<MenuModel> listCartOrder = [];
List<MenuModel> listShopOrder = [];

int total = 0;
int totalPerItem = 0;
int voucherClaim = 99999;
// logic



List<Voucher> listVoucher = [
  Voucher(
    title: "Disc 10K",
    desc: "Diskon 10 persen",
    imgUrl:
        "https://i.pinimg.com/564x/86/46/fd/8646fdda0ed1966cd96d5f51175c0077.jpg",
    discount: 10000,
    priceLimit: 0,
    isClaim: false,
  )
];
