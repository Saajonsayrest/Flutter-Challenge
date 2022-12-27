import 'package:flutter/material.dart';
buildMessage() => Column(
  children: const [ Center(
    child: Text(
      'Hello DIDI',
      style: TextStyle(fontSize: 3.5),
    ),
  ),
    Center(
      child: Text(
        'Animation reload => App restart 😁',
        style: TextStyle(fontSize: 3.5),
      ),
    ),
  ],
);