import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NutritionCard extends StatelessWidget {

  final String text1;
  final String text2;
  final String imagePath;
  final String uri1;
  final String uri2;
  final String uri3;
  final String uri4;
  final double? alto;
  final double? ancho;

  const NutritionCard({Key? key,
    required this.text1,
    required this.text2,
    required this.imagePath,
    required this.uri1, // youtube.com || youtu.be
    required this.uri2, // /watch || // /qyN8URX_N0k
    required this.uri3, // v || si
    required this.uri4, // NgEJ9gMxP90 || FNhhCP4H6xM8KRVT
    this.alto = 90,
    this.ancho = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge, //https://www.tdea.edu.co/
      child: InkWell(
        splashColor: Colors.amber, //www.directoalpaladar.com/recetario/101-recetas-sanas-para-para-tener-menu-saludable-lunes-a-domingo
        onTap: () {
          var uri = Uri.https(uri1, uri2, {uri3: uri4}); // youtu.be/qyN8URX_N0k?si=FNhhCP4H6xM8KRVT 
          launchUrl(uri); // www.youtube.com/watch?v=NgEJ9gMxP90
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(image: AssetImage(imagePath), height: alto, width: ancho,),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(text1, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(text2)
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}