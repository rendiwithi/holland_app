import 'package:flutter/material.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/screen/admin/add_voucher_page.dart';

class VoucherPageAdmin extends StatefulWidget {
  const VoucherPageAdmin({Key? key}) : super(key: key);

  @override
  State<VoucherPageAdmin> createState() => _VoucherPageAdminState();
}

class _VoucherPageAdminState extends State<VoucherPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddVoucherPage(),
                  ),
                );
              },
              child: Text("Tambah Voucher"),
              style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 3.0,
                  color: Colors.white,
                ),
                fixedSize: const Size(300, 60),
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listVoucher.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(listVoucher[index].title),
                subtitle: Text("Rp. " + listVoucher[index].discount.toString()),
                onTap: () {},
                trailing: SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
