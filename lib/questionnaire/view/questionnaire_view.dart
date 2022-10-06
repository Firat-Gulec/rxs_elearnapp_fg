import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_kit/survey_kit.dart';



class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({Key? key}) : super(key: key);

  @override
  _QuestionnaireViewState createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView>
   {
  late String name;
  late String loadString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: FutureBuilder<Task>(
          future: getJsonTask(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              final task = snapshot.data!;

              return SurveyKit(
                onResult: (SurveyResult result) {
                  for (var stepResult in result.results) {
                    for (var questionResult in stepResult.results) {
                      // ignore: avoid_print
                      print(questionResult.result.toString());
                      // Here are your question results
                    }
                  }
                  if (result.finishReason.toString() ==
                      'FinishReason.DISCARDED') {
                    //navigation.navigateToPage(path: NavigationConstants.LOGIN);
                  }
                  if (result.finishReason.toString() ==
                      'FinishReason.COMPLETED') {
                   // navigation.navigateToPage(path: NavigationConstants.LOGIN);
                  }
                },
                task: task,
                showProgress: true,
                // ignore: prefer_const_literals_to_create_immutables
                localizations: {
                  'cancel': "Cancel",
                  'next': "Next",
                },
                themeData: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.cyan,
                  ).copyWith(
                    onPrimary: Colors.white,
                  ),
                  primaryColor: Colors.cyan,
                  backgroundColor: Colors.black26,
                  appBarTheme: const AppBarTheme(
                    color: Colors.white,
                    iconTheme: IconThemeData(
                      color: Colors.cyan,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.cyan,
                    ),
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.cyan,
                  ),
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: Colors.cyan,
                    selectionColor: Colors.cyan,
                    selectionHandleColor: Colors.cyan,
                  ),
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    primaryColor: Colors.cyan,
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(150.0, 60.0),
                      ),
                      side: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> state) {
                          if (state.contains(MaterialState.disabled)) {
                            return const BorderSide(
                              color: Colors.grey,
                            );
                          }
                          return const BorderSide(
                            color: Colors.cyan,
                          );
                        },
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      textStyle: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> state) {
                          if (state.contains(MaterialState.disabled)) {
                            return Theme.of(context).textTheme.button?.copyWith(
                                  color: Colors.white,
                                );
                          }
                          return Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.white,
                              );
                        },
                      ),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button?.copyWith(
                              color: Colors.cyan,
                            ),
                      ),
                    ),
                  ),
                  textTheme: const TextTheme(
                    headline2: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                    headline5: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                    bodyText2: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    subtitle1: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                surveyProgressbarConfiguration: SurveyProgressConfiguration(
                  backgroundColor: Colors.white,
                ),
              );
            }

            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }

  Future<Task> getJsonTask() async {
    //final prefs = await SharedPreferences.getInstance();
    //name = prefs.getString("name") ?? "null";
    //loadString = prefs.getString("loadstring") ?? "null";
    final taskJson = await rootBundle.loadString("assets/questionnaires/login_survey.json");
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }
}
