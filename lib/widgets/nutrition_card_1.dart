import 'package:flutter/material.dart';

class NutritionCard1 extends StatelessWidget {

  final String text1;
  final String text2;
  final String imagePath;
  final double? alto;
  final double? ancho;

  const NutritionCard1({Key? key,
    required this.text1,
    required this.text2,
    required this.imagePath,
    this.alto = 90,
    this.ancho = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge, 
      child: InkWell(
        splashColor: Colors.amber,
        onTap: () => _showAddTaskBottomSheet(context, imagePath),
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


void _showAddTaskBottomSheet(BuildContext context, String imagePath) {
    showModalBottomSheet(
      //enableDrag: true,
      //barrierColor: Colors.pink,
      //barrierLabel: "jesus",
      
      //isScrollControlled: true,
      //backgroundColor: Colors.purple,
      
      elevation: 50,
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text("Brócoli al vapor con aliño de tahini y limón", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              Image.asset(imagePath,scale: 2.3),
              const Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 15),
                  children: <TextSpan> [
                    TextSpan( text: "Mujer apunto del "),
                    TextSpan(text: "colapso emocional ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan( text: "tratando de canalizar sus emociones, mantenerse "),
                    TextSpan(text: "serena ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan( text: "y "),
                    TextSpan(text: "no explotar.", style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                )
              ),
              const SizedBox(height: 20,),
              const Text("Ingredientes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 15),
                  children: <TextSpan> [
                    TextSpan(text: "Factores biológicos: ", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    TextSpan( text: "genética o antecedentes familiares de depresión, enfermedades como la diabetes, enfermedades cardíacas o trastornos de tiroides, y cambios hormonales que ocurren durante toda la vida, como un embarazo o la menopausia.\n"),
                    TextSpan(text: "Factores sociales: ", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    TextSpan(text: "situaciones o hechos estresantes en la vida, como la pérdida de un ser querido, problemas laborales, problemas económicos, rupturas sentimentales, enfermedades, alcoholismo o consumo de drogas, baja autoestima o ser autocrítico, antecedentes personales de enfermedad mental, ciertos medicamentos, entre otros.\n"),
                    TextSpan(text: "Factores psicológicos: ", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    TextSpan(text: "ansiedad, dolor o enfermedad física, consumo inapropiado de alcohol o de drogas, entre otros."),
                  ]
                )
              ),
              const Text("Potatoes", style: TextStyle(fontWeight: FontWeight.bold),),
              FloatingActionButton.small(
                onPressed:() => Navigator.of(context).pop(), child: const Text("Okay"),
                )
            ],
          ),
        );
      },
    );
  }