import 'package:flutter/material.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/screen/admin/add_menu_page.dart';
import 'package:holland/screen/admin/banner_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BannerPage()),
                  );
                },
                child: const Text("Kelola Banner"),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    width: 3.0,
                    color: Colors.white,
                  ),
                  fixedSize: const Size(300, 60),
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: listMenuItem.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  title: Text(listMenuItem[index].title),
                  subtitle: Text("Rp. " + listMenuItem[index].price.toString()),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddMenuPage()));
                },
                child: const Text("Tambah Menu"),
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
        ],
      ),
    );
  }
}
