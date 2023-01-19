import 'package:flutter/material.dart';

class WorkerDetailScreen extends StatelessWidget {
  const WorkerDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],shape: BoxShape.circle,image: DecorationImage(image: AssetImage())),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
