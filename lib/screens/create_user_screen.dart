// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_sqlite_demo/database/database_helper.dart';
import 'package:flutter_sqlite_demo/model/user_model.dart';
import 'package:flutter_sqlite_demo/provider/user_provider.dart';
import 'package:flutter_sqlite_demo/screens/user_list_screen.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {

  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final user = UserModel(
        name: nameController.text,
        email: emailController.text,
        desc: descController.text,
      );
      Provider.of<UserProvider>(context, listen: false).addUser(user);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserListScreen(),),
      );
      nameController.clear();
      emailController.clear();
      descController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: emailController,
                validator: (input) => !input!.contains('@')
                    ? 'Please enter a valid email'
                    : null,
                //onSaved: (input) => _email = input!,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: descController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Desc'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

