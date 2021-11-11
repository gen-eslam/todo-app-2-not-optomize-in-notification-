import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 52,
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 8,
            ),
            padding:const  EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
              //  color: Colors.grey,
              border: Border.all(
                width: 1.0,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null? false :true,
                    autofocus: false,

                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Get.isDarkMode
                              ? Colors.grey[200]
                              : Colors.grey[700],
                          fontSize: 14,
                        ),
                    decoration: InputDecoration(
                      hintText: hint,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:Theme.of(context).backgroundColor,
                            width: 0
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:Theme.of(context).backgroundColor,
                          width: 0
                        ),
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Get.isDarkMode
                            ? Colors.grey[100]
                            : Colors.grey[600],
                        fontSize: 14,
                      ),


                    ),
                  ),
                ),
                if(widget != null)
                Container(child: widget!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
