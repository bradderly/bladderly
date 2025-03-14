import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.navigator,
  });

  final Widget navigator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: navigator,
        ),
      ),
    );
  }
}
