import 'package:flutter/material.dart';

pushTo (BuildContext context , Widget newScreen){
  Navigator.push(context, MaterialPageRoute(builder: (contex){
          return newScreen;
        }));
}

pushWithReplacement (BuildContext context , Widget newScreen){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex){
          return newScreen;
        }));
}