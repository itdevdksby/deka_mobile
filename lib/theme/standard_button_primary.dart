// ignore_for_file: prefer_const_constructors_in_immutables, use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class StandardButtonPrimary extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String titleHint;
  final bool? isLoading;
  final void Function()? onPressed;

  StandardButtonPrimary({
    Key? key,
    required this.formKey,
    required this.titleHint,
    this.isLoading,
    this.onPressed,
  }) : super(key: key);

  @override
  State<StandardButtonPrimary> createState() => StandardButtonPrimaryState();

}

class StandardButtonPrimaryState extends State<StandardButtonPrimary> {


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                if (widget.isLoading == false){
                  if(!widget.onPressed.isNull){
                    widget.onPressed!();
                  }
                }
              }
            },
            style: ButtonStyle(
                backgroundColor: widget.isLoading == true
                    ? MaterialStateProperty.all(Colors.grey)
                    : MaterialStateProperty.all(
                    colorPrimaryDark),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20)))),
            child: widget.isLoading == true
                ? Padding(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )))
                : Text(widget.titleHint,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w800)),
          ),
        ));
  }
}