import 'package:flutter/material.dart';
import 'package:quizzler/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatefulWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  State<Quizzler> createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  QuizBrain quiz = QuizBrain();
  List<Icon> scorekeeper = [];

  void onpress(bool user) {
    if (quiz.checkanswer(user)) {
      scorekeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      scorekeeper.add(const Icon(Icons.close, color: Colors.red));
    }
  }

  void reset() {
    quiz.reset();
    scorekeeper.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    height: 450,
                    width: 300,
                    child: Center(
                        child: Text(quiz.question(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20))),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                child: Container(
                  height: 60,
                  width: 300,
                  color: Colors.green,
                  child: const Center(
                      child: Text(
                    'True',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                ),
                onPressed: () {
                  onpress(true);
                  setState(() {
                    if (quiz.isfinished()) {
                      reset();
                    }
                    quiz.nextquestion();
                  });
                },
              ),
              TextButton(
                child: Container(
                  height: 60,
                  width: 300,
                  color: Colors.red,
                  child: const Center(
                      child: Text(
                    'False',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
                ),
                onPressed: () {
                  onpress(false);
                  setState(() {
                    if (quiz.isfinished()) {
                      reset();
                    }
                    quiz.nextquestion();

                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: scorekeeper,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
