import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: StartScreen(),
  ));
}

class StartScreen extends StatelessWidget {
  const StartScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histologia'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: 400,
              height: 400,
            ),
            SizedBox(height: 20),
            Text(
              'Aprenda Jogando',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizApp()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text('Iniciar o Jogo', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp();

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Map<String, String>> imagesAndAnswers = [
    {
      "image": "image_01.jpg",
      "answer": "Mikey Mouse",
    },
    {
      "image": "image_02.jpg",
      "answer": "Lola Bunny",
    },
    {
      "image": "image_03.jpg",
      "answer": "Patolino",
    },
    {
      "image": "image_04.jpg",
      "answer": "Perna Longa",
    },
    {
      "image": "image_05.jpg",
      "answer": "Piu-Piu",
    },
    {
      "image": "image_06.jpg",
      "answer": "Pluto",
    },
    {
      "image": "image_07.jpg",
      "answer": "Snoopy",
    },
    {
      "image": "image_08.jpg",
      "answer": "Taz",
    },
    {
      "image": "image_09.jpg",
      "answer": "Velma",
    },
    {
      "image": "image_10.jpg",
      "answer": "Animaniacs",
    },
    {
      "image": "image_11.jpg",
      "answer": "Bart",
    },
    {
      "image": "image_12.jpg",
      "answer": "Bob Esponja",
    },
    {
      "image": "image_13.jpg",
      "answer": "Bob",
    },
    {
      "image": "image_14.jpg",
      "answer": "Dexter",
    },
    {
      "image": "image_15.jpg",
      "answer": "Donald",
    },
    {
      "image": "image_16.jpg",
      "answer": "Doug Funny",
    },
    {
      "image": "image_17.jpg",
      "answer": "Garfield",
    },
    {
      "image": "image_18.jpg",
      "answer": "Homer",
    },
    {
      "image": "image_19.jpg",
      "answer": "Jerry",
    },
    {
      "image": "image_20.jpg",
      "answer": "Ligeirinho",
    },
  ];

  int numberOfQuestions = 10;
  int score = 0;
  int questionCounter = 0;
  String _currentImage = "";
  List<String> _options = [];
  List<String> _usedImages = [];
  Color buttonColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _showQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HistoGame Aprenda Jogando'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pergunta $questionCounter de $numberOfQuestions',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(
              height: 200,
              child: _buildQuestion(),
            ),
            SizedBox(height: 20),
            _buildOptions(),
            SizedBox(height: 20),
            Text(
              'Pontuação: $score',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _restartQuiz,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: Text('Recomeçar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para sair do aplicativo
          // Neste exemplo, o aplicativo será encerrado
          SystemNavigator.pop(); // Use SystemNavigator.pop() para sair do aplicativo
        },
        backgroundColor: Colors.red, // Cor do botão de saída
        child: Icon(
          Icons.exit_to_app, // Ícone de saída padrão
          color: Colors.white, // Cor do ícone
          size: 30.0, // Tamanho do ícone
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showQuestion() {
    if (questionCounter >= numberOfQuestions) {
      _showResult();
      return;
    }

    int randomIndex;
    do {
      randomIndex = Random().nextInt(imagesAndAnswers.length);
    } while (_usedImages.contains(imagesAndAnswers[randomIndex]["image"]));

    setState(() {
      _currentImage = imagesAndAnswers[randomIndex]["image"]!;
      _usedImages.add(_currentImage);
      buttonColor = Colors.blue; // Resseta a cor do botão
    });

    List<String> options = [];
    options.add(imagesAndAnswers[randomIndex]["answer"]!);

    while (options.length < 4) {
      int randomOptionIndex = Random().nextInt(imagesAndAnswers.length);
      String? randomOption = imagesAndAnswers[randomOptionIndex]["answer"];
      if (!options.contains(randomOption)) {
        options.add(randomOption!);
      }
    }

    options.shuffle();

    setState(() {
      _options = options;
    });

    setState(() {
      questionCounter++;
    });
  }

  Widget _buildQuestion() {
    return Image.asset('assets/$_currentImage');
  }

  Widget _buildOptions() {
    return Column(
      children: _options.map((option) {
        return ElevatedButton(
          onPressed: () {
            _checkAnswer(option);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // Use backgroundColor em vez de primary
          ),
          child: Text(option),
        );
      }).toList(),
    );
  }

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer = imagesAndAnswers
        .firstWhere((element) => element["image"] == _currentImage)["answer"]!;
    if (selectedAnswer == correctAnswer) {
      setState(() {
        score++;
        buttonColor = Colors.green; // Cor do botão correta
      });
    } else {
      setState(() {
        buttonColor = Colors.red; // Cor do botão errada
      });
    }
    _showQuestion();
  }

  void _showResult() {
    double percentage = (score / numberOfQuestions) * 100;
    String resultText = percentage >= 80 ? 'Você ganhou!' : 'Você perdeu. Continue tentando.';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text('Pontuação: $score\n$percentage% $resultText'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _restartQuiz() {
    setState(() {
      questionCounter = 0;
      score = 0;
      _usedImages.clear(); // Limpar a lista de imagens usadas ao reiniciar o quiz.
    });
    _showQuestion();
  }
}
