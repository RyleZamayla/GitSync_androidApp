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
    final firebaseUsers = Provider.of<List<UserModel>>(context) ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: firebaseUsers.length,
      itemBuilder: (context, index) {
        final users = firebaseUsers[index];
        return InkWell(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  users.profileImageUrl != null ?
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        users.profileImageUrl!
                      ),
                    ) : Icon(Icons.person_add_alt_1_outlined,
                          size: 40,)
                ],
              ),),
              const Divider(thickness: 1)
            ],
          ),
        );
      });
  }
}
