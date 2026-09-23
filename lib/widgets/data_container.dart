import 'package:flutter/material.dart';

class DataContainer extends StatelessWidget {
  const DataContainer({super.key, this.isActive = false, required this.statusText, this.onTap});
  final bool isActive;
  final String statusText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(onTap: onTap,
        child: Container(
      
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(12),
            color: isActive ? Color(0xff4E5AE8) : Color(0xffB4AAAA),
          ),
          child: Text(statusText,style:TextStyle(
        color: Colors.white 
        ,fontWeight: FontWeight.bold,fontSize: 18
          ),),
        ),
      ),
    );
  }
}
