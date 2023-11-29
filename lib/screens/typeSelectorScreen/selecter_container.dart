import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelecterContainer extends StatelessWidget {
  const SelecterContainer(
      {super.key,
      required this.isUserLogedIn,
      required this.imageName,
      required this.textName});

  final void Function() isUserLogedIn;
  final String imageName;
  final String textName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      height: 211,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: InkWell(
          onTap: () {
            isUserLogedIn();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageName,
                width: 117,
                height: 117,
                fit: BoxFit.cover,
              ),
              Text(
                textName,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
