// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);
  final void Function()? onTap;
  final String text;
  

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hoverColor: Colors.red.withOpacity(0.2),
        focusColor: Colors.red.withOpacity(0.2),
        splashColor: Colors.red.withOpacity(0.2),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
