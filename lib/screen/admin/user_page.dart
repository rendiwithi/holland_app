import 'package:flutter/material.dart';
import 'package:holland/data/variableModel.dart';
import 'package:holland/model/user_model.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Tambah User"),
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
          itemCount: listUser.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(listUser[index].username),
                subtitle: Text("Role: " + listUser[index].role.toString()),
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