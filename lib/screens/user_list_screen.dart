// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_sqlite_demo/model/user_model.dart';
import 'package:flutter_sqlite_demo/provider/user_provider.dart';
import 'package:flutter_sqlite_demo/screens/create_user_screen.dart';
import 'package:flutter_sqlite_demo/screens/edit_user_screen.dart';
import 'package:provider/provider.dart';

import '../app_constants.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final userProvider =
      Provider.of<UserProvider>(AppConstants.globalNavKey.currentContext!);

  @override
  void initState() {
    // TODO: implement initState
    userProvider.loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('User List'),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return userProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : userProvider.users.isEmpty
                ? const Center(
                    child: Text(
                    "Data Not Found",
                    style: TextStyle(fontSize: 18),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: userProvider.users.length,
                      itemBuilder: (context, index) {
                        final user = userProvider.users[index];
                        return Card(
                          elevation: 3,
                          color: Colors.teal.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  user.name,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.email,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    user.desc,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      _navigateToEditUser(context, user);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.black),
                                    onPressed: () {
                                      userProvider.deleteUser(user.id ?? 0);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateUser(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateUser(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateUserScreen()),
    );
    setState(() {});
  }

  void _navigateToEditUser(BuildContext context, UserModel user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUserScreen(user: user)),
    );
    setState(() {});
  }
}
