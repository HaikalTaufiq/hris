import 'package:flutter/material.dart';
import 'package:hr/core/header.dart';
import 'package:hr/presentation/pages/profile/widget/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Header(title: 'Profile'),
        ProfileEdit(),
      ],
    );
  }
}
