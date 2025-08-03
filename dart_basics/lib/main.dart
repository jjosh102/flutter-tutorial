import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
          leading: Icon(IconData(0xe3b2, fontFamily: 'MaterialIcons')),
        ),
        body: CustomContainer(),
      ),
    ),
  );
}

class CustomContainer extends StatelessWidget
{
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context)  
    => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(94, 144, 194, 1),
                Color.fromRGBO(94, 144, 194, 0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://avatars.githubusercontent.com/u/50490077?v=4', 
                  width: 150, 
                  height: 150,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Text('Could not load image'); 
                  },
                ),
                SizedBox(height: 20),
                Text('jjosh102!'),
              ],
            ),
          ),
        );
}