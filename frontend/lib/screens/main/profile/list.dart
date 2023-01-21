import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_feed/models/user.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {

  @override

  Widget build(BuildContext context) {

    final firebaseUsers = Provider.of<List<UserModel?>>(context) ?? [];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: firebaseUsers.length,
      itemBuilder: (context, index) {
        final dynamic users = firebaseUsers[index];

        if (firebaseUsers == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return InkWell(
          onTap: () => Navigator.pushNamed(context, '/profile', arguments: users.id),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                  child: Row(children: [
                    const SizedBox(width: 10),
                    Text(users.name)
                ],
              ),),
              const Divider(thickness: 1)
            ],
          ),
        );
      });
  }
}
