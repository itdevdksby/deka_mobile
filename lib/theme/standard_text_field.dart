// ignore_for_file: prefer_const_constructors_in_immutables, use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';

import 'app_colors.dart';

class StandardTextField extends StatefulWidget {
  final TextEditingController editingController;
  final String titleHint;
  final String msgError;
  final Icon? iconField;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;

  StandardTextField({
    Key? key,
    required this.editingController,
    required this.titleHint,
    required this.msgError,
    this.iconField,
    this.inputType,
    this.inputAction,
    this.isPassword,
  }) : super(key: key);

  @override
  State<StandardTextField> createState() => StandardTextState();

}

class StandardTextState extends State<StandardTextField> {
  var obscurePassword = false;

  @override
  void initState() {
    super.initState();
    if(widget.isPassword == true){
      obscurePassword = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(left: 20, right: 20, top: 20),
        child: TextFormField(
          controller: widget.editingController,
          keyboardType: widget.inputType ?? TextInputType.name,
          textInputAction: widget.inputAction ?? TextInputAction.next,
          style: TextStyle(fontSize: 15),
          obscureText: widget.isPassword == true ? obscurePassword : false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.msgError;
            }
            return null;
          },
          decoration: InputDecoration(
              hintText: widget.titleHint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: colorPrimary)),
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              prefixIcon: widget.iconField,
              prefixIconColor: Colors.black54,
              filled: true,
              fillColor: Colors.black12,
              suffixIcon: widget.isPassword == true ? IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ) : null
          ),
        ));
  }
}