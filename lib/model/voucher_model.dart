class Voucher {
  String title;
  String desc;
  String imgUrl;
  // String desc;
  int discount;
  int priceLimit;
  bool isClaim;
  Voucher({
    required this.title,
    required this.desc,
    required this.imgUrl,
    // required this.desc,
    required this.discount,
    required this.priceLimit,
    required this.isClaim,
  });
}
