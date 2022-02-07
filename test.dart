import 'dart:convert';

import 'package:flutter/material.dart';

 const String fakeJson =
  '[{"name" : "Lorena Hickle","user_name" : "Lee.Hand","user_id" : "Abel.Carroll@hotmail.com"},'
  '{"name" : "Archibald Johnston","user_name" : "Curt82","user_id" : "Unique_Kihn@hotmail.com"},'
  '{"name" : "Aida Rippin","user_name" : "Rebecca.Von","user_id" : "Marina.Terry94@yahoo.com"}'
']';


class Issue66740819 extends StatefulWidget {
  @override
  _Issue66740819State createState() => _Issue66740819State();
}

class _Issue66740819State extends State<Issue66740819> {
  List<Person> users = [];

  @override
  void initState() {
    List jsonList = jsonDecode(fakeJson);
    loadUsers(jsonList);

    super.initState();
  }

  void loadUsers(List jsonList){
    setState(() {
      users = jsonList.map((user) => Person(
        name: user['name'],
        username: user['user_name'],
        userId: user['user_id']
      )).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(users[index].name!),
          subtitle: Text(users[index].username!),
          onTap: () => goToPersonView(users[index]),
        );
      }
    );
  }

  void goToPersonView(Person person){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return PersonView(person: person);
    }));
  }
}

class PersonView extends StatelessWidget {
  final Person person;

  const PersonView({Key ?key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${person.name}'),
            Text('Username: ${person.username}'),
          ],
        ),
      ),
    );
  }
}

class Person {
  String ?name;
  String ?username;
  String ?userId;

  Person({
    @required this.name,
    @required this.username,
    @required this.userId,
  });
}