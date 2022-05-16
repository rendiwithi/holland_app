import 'package:flutter/material.dart';
import 'package:holland/data/colorData.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundApp,
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: backgroundApp,
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: boxInput,
          ),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/79/b3/59/79b35959bed4bdc686fabe244a2c6ca4.jpg'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Suaep wahidin',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Text('bebeksalto@gmail.com'),
            ],
          ),
        ));
  }
}
