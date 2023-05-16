import 'package:flutter/material.dart';

Widget defaultTextFormField(
    context, {
      required TextEditingController controller,
      required TextInputType keyboardtype,
      ValueChanged<String>? submitFunction,
      required FormFieldValidator validator,
      required IconData prefix,
      required String labelText,
      bool isPassword = false,
      IconData? suflix,
      ValueChanged<String>? onchange,
      VoidCallback? suflixpressed,
      VoidCallback? onTap,
      String? value,
      String? hint,
      bool autofocus = false,
    }) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardtype,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 20,),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 20,color: Colors.grey),
        prefixIcon: Icon(prefix),
        suffixIcon: suflix != null
            ? IconButton(icon: Icon(suflix), onPressed: suflixpressed)
            : null,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue, width: 5)),
      ),
      obscureText: isPassword,
      onFieldSubmitted: submitFunction,
      onChanged: onchange,
      onTap: onTap,
      validator: validator,
      style: TextStyle(fontSize: 20,),
    );

Widget defultButton({
  double width = double.infinity,
  double height = 50,
  Color background = Colors.lightBlue,
  double borderRadius = 5.0,
  required Function() pressfunction,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
          onPressed: pressfunction,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: background,
      ),
    );

void navGoTo(context, Widget goto) => Navigator.push(context, MaterialPageRoute(builder: (context) => goto));