import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool englishOrArabic = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff54C556),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xffFFFFFF),
              Color(0xff54C556)
            ],
            begin: Alignment(-1, 1),
            end: Alignment(1, -1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to',
              style: TextStyle(fontFamily: 'poppins', fontSize: 30,fontWeight: FontWeight.bold),
            ),
            Image.asset('assets/images/logo.png',width: 170,height: 160,),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Language',
                    style: TextStyle(fontFamily: 'poppins', fontSize: 18,color: Color(0xff3C5A40),fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          height: 39,
                          onPressed: () {
                            setState(() {
                              englishOrArabic = true;
                            });
                          },
                          color: englishOrArabic?Colors.white:null,
                          shape: englishOrArabic?RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ):null,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,),
                            child: Text('English',style: TextStyle(fontFamily: 'poppins', fontSize: 18,color: Color(0xff3C5A40))),
                          ),
                        ),
                        MaterialButton(
                          height: 39,
                          onPressed: () {
                            setState(() {
                              englishOrArabic = false;
                            });
                          },
                          color: englishOrArabic?null:Colors.white,
                          shape: englishOrArabic?null:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Arabic',style: TextStyle(fontFamily: 'poppins', fontSize: 18,color: Color(0xff3C5A40))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
