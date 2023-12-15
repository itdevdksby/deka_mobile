// ignore_for_file: prefer_const_constructors_in_immutables, use_super_parameters, prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/extension.dart';
import 'app_colors.dart';

class StandardPickerField extends StatefulWidget {
  final String titleHint;
  final String? pathValue;
  final void Function(String path) onPressed;
  final void Function()? onRemove;

  StandardPickerField({
    Key? key,
    required this.titleHint,
    this.pathValue,
    required this.onPressed,
    this.onRemove,
  }) : super(key: key);

  @override
  State<StandardPickerField> createState() => StandardPickerFieldState();

}

class StandardPickerFieldState extends State<StandardPickerField> {
  String? pathString;

  @override
  void initState() {
    super.initState();
    pathString = widget.pathValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorGrey200,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(children: [
          Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Text(widget.titleHint)
            ),
            Expanded(child: Container()),
            IconButton(
                icon: const Icon(Icons.edit, color: Colors.orangeAccent),
                onPressed: () {
                  pickerPhoto(ImageSource.camera, (path) {
                    setState(() {
                      pathString = path;
                      widget.onPressed(path);
                    });
                  });
                }
            ),
            widget.onRemove.isNull
                ? SizedBox()
                : IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    pathString = null;
                    if(!widget.onRemove.isNull){
                      widget.onRemove!();
                    }
                  });
                }
            )
          ]),
          _loadFileFoto()
        ]),
      ),
    );
  }

  _loadFileFoto() {
    if(!pathString.isNull) {
      if (pathString!.contains("https")){
        return CachedNetworkImage(
          imageUrl: pathString!,
          placeholder: (context, url) => CircularProgressIndicator(),
          imageBuilder: (context, imageProvider) => Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
            )
          )
        );
      }
      else{
        return Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              image: FileImage(File(pathString!)),
              fit: BoxFit.cover
            )
          )
        );
      }
    }
    return Container(height: 120);
  }
}