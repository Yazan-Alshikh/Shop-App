import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DefaultFormFiled({
  @required TextEditingController controller,
  @required String label,
  @required IconData preifex,
   IconData suffix,
  bool Ispassword = false,
  @required TextInputType type,
  Function validator,
  Function onsubmit,
  Function onsuffixpressed

}) =>
    TextFormField(
      validator: validator,
      onFieldSubmitted:onsubmit ,
      obscureText:Ispassword ,
      controller: controller,
      keyboardType: type,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: Icon(
            preifex
        ),
        suffix: IconButton(onPressed: onsuffixpressed, icon: Icon(suffix)),
        labelStyle: TextStyle(fontSize: 18),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
