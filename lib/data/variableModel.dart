import 'package:holland/model/extra_item.dart';
import 'package:holland/model/list_extra_item.dart';
import 'package:holland/model/menu_item.dart';
import 'package:holland/model/voucher_model.dart';

// Public
List<MenuItem> listCartOrder = [];
List<MenuItem> listShopOrder = [];

int total = 0;
int totalPerItem = 0;
int voucherClaim = 99999;
// logic

//Static for design will remove if backend is ready
List<ExtraItem> listExtra = [
  ExtraItem(
    id: 1,
    name: "cokelat",
    isSelected: false,
    price: 1000,
  ),
  ExtraItem(
    id: 2,
    name: "susu",
    isSelected: false,
    price: 2000,
  ),
  ExtraItem(
    id: 3,
    name: "madu",
    isSelected: false,
    price: 3000,
  ),
];
final List<ExtraItem> listExtraAsin = [
  ExtraItem(
    id: 1,
    name: "Telor",
    isSelected: false,
    price: 4000,
  ),
  ExtraItem(
    id: 2,
    name: "Keju",
    isSelected: false,
    price: 5000,
  ),
  ExtraItem(
    id: 3,
    name: "Abon Sapi",
    isSelected: false,
    price: 6000,
  ),
];

final List<MenuItem> listMenuItem = [
  MenuItem(
    id: 1,
    title: "Martabak Manis Biasa",
    position: "Jl Mayjend Sungkono, Surabaya",
    imgUrl:
        "https://i.pinimg.com/236x/5a/8b/17/5a8b1715b0599a6b41c4ce5fe1f55c28.jpg",
    desc: "Martabak Manis aja sih ga ada lebihnya kaya aku",
    price: 25000,
    extraItem: listExtra,
  ),
  MenuItem(
    id: 2,
    title: "Martabak Asin Besar",
    position: "Jl Mayjend Sungkono, Surabaya",
    imgUrl:
        "https://i.pinimg.com/564x/b7/83/e5/b783e50c98526b8bea753e9ae3eac1f4.jpg",
    desc: "Martabak Asin gurih yang besar seperti perhatianku padamu",
    price: 30000,
    extraItem: listExtraAsin,
  ),
  MenuItem(
    id: 3,
    title: "Martabak Asin Biasa",
    position: "Jl Mayjend Sungkono, Surabaya",
    imgUrl:
        "https://i.pinimg.com/236x/9c/41/d6/9c41d6e8c80f4e04806410166346d880.jpg",
    desc: "Martabak Asin biasa mencintaimu dari jauh",
    price: 25000,
    extraItem: listExtraAsin,
  ),
];

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
