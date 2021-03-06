import 'package:holland/model/extra_item.dart';

class MenuItem {
  int id;
  String title;
  String position;
  String imgUrl;
  String desc;
  int price;
  List<ExtraItem> extraItem;
  MenuItem({
    required this.id,
    required this.title,
    required this.position,
    required this.imgUrl,
    required this.desc,
    required this.price,
    required this.extraItem,
  });
}
