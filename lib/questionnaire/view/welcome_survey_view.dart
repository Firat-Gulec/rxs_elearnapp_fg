
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../core/widget/header_widget.dart';
import '../../core/widget/padding/custom_padding.dart';
import '../model/phonenumber_formatter.dart';
import '../model/question_model.dart';
import '../service/survey_controller.dart';

class WelcomeSurveyView extends StatefulWidget {
  const WelcomeSurveyView({Key? key}) : super(key: key);

  @override
  _WelcomeSurveyViewState createState() => _WelcomeSurveyViewState();
}
/*
//c435d18472f24afa926b73708916ef5c
Future<void> getIP() async {
  const apiKey = 'c435d18472f24afa926b73708916ef5c';
  const geolocation = IpGeoLocationIO(apiKey);
  final response = await geolocation.getUserLocation();
  _typeAheadController.text = response.city;
}
*/

final GroupButtonController _groupboxcontroller = GroupButtonController();
final TextEditingController _typeAheadController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
late final List<String> selectedOptions;
late final String selectedCity;

class _WelcomeSurveyViewState extends State<WelcomeSurveyView>
    {
  final List<QuestionModel> _questions = sample_data
      .map(
        (question) => QuestionModel(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    // getIP();
  }

  @override
  Widget build(BuildContext context) {
    final surveycontroller = Get.put(SurveyController());

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              surveycontroller.decrease();
              surveycontroller.visibilityfunc();
            });
          },
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                setState(() {
                  surveycontroller.increment();
                  surveycontroller.visibilityfunc();
                  // ignore: avoid_print
                  print(_groupboxcontroller.selectedIndexes);

                  _groupboxcontroller.selectedIndexes.clear();
                });
              },
              child: Text("tr(LocaleKeys.questionnaire_next)"),
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Colors.transparent.withOpacity(0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              )),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.2,
        title: Text("tr(LocaleKeys.questionnaire_questionnaire)"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).backgroundColor,
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const SizedBox(
              height: 100,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              //  alignment: Alignment.topCenter,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: CustomPadding()),
                    Image.asset(
                      'assets/logos/petlogo.png',
                      width: size.width * 0.50,
                    ),
                    Padding(padding: CustomPadding()),
                    Visibility(
                      visible: true,
                      child: Form(
                        //margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        //padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(children: [
                          Text(
                            _questions[surveycontroller.count.toInt()].question,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.white),
                          ),
                        ]),
                      ),
                    ),
                    Padding(padding: CustomPadding()),
                    Visibility(
                      visible: surveycontroller.isVisibleLoc.value,
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: _typeAheadController,
                            decoration: InputDecoration(
                                labelText: "tr(LocaleKeys.questionnaire_city)",
                                hoverColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                fillColor: Theme.of(context).backgroundColor,
                                filled: true)),
                        suggestionsCallback: (pattern) {
                          return surveycontroller.fetchSuggestions(pattern);
                        },
                        itemBuilder: (context, pattern) {
                          return ListTile(
                            title: Text(pattern.toString()),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          _typeAheadController.text = suggestion.toString();
                        },
                      ),
                    ),
                    Visibility(
                      visible: surveycontroller.isVisiblePho.value,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText:" tr(LocaleKeys.questionnaire_phone)",
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fillColor: Theme.of(context).backgroundColor,
                            filled: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12),
                          CountryCodeTextInputFormatter(),
                          PhoneNumberTextFormatter(),
                        ],
                      ),
                    ),
                 /*   Visibility(
                      visible: surveycontroller.isVisibleChe.value,
                      child:  GroupButton(
                        controller: _groupboxcontroller,
                       spacing: 10,
                        runSpacing: 10,
                        isRadio: false,
                        groupingType: GroupingType.wrap,
                        direction: Axis.horizontal,
                        onSelected: (index, isSelected) => debugPrint(
                          '$index button is ${isSelected ? 'selected' : 'unselected'}',
                        ),
                        buttons:
                            _questions[surveycontroller.count.toInt()].options,
                        //selectedButtons: const [1, 2, 3],
                        selectedTextStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                        unselectedTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        selectedColor: Colors.white,
                        //unselectedColor: Colors.grey[300],
                        selectedBorderColor: Colors.blue,
                        unselectedBorderColor: Colors.grey[500],
                        borderRadius: BorderRadius.circular(20.0),
                        selectedShadow: const <BoxShadow>[
                          BoxShadow(color: Colors.transparent)
                        ],
                        unselectedShadow: const <BoxShadow>[
                          BoxShadow(color: Colors.transparent)
                        ],
                        buttonHeight: 30,
                        buttonWidth: 115,
                      ),
                    ),*/
                    Padding(padding: CustomPadding()),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
