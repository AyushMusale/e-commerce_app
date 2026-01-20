import 'package:flutter/material.dart';

class Radiobutton extends StatelessWidget {
  final VoidCallback ontap;
  final bool isSelected;
  final String title;
  const Radiobutton({super.key, required this.ontap, required this.isSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 2
              )
            ),
            child: isSelected ? Center(
              child: Container(
                height: 13,
                width: 13,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
              ),
            ): null,
          ),
          SizedBox(width: 2,),
          Text(title ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}