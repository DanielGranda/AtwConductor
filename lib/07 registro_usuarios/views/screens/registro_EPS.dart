import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ResgistroEps extends StatefulWidget {
  ResgistroEps({Key key}) : super(key: key);

  @override
  _ResgistroEpsState createState() => _ResgistroEpsState();
}

class _ResgistroEpsState extends State<ResgistroEps> {
  final GlobalKey<FormBuilderState> _registreKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstIn),
              image: AssetImage("assets/backGround/FondoBlancoATW.png"),
              fit: BoxFit.contain,
            )),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Registro de Vehículo'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/imgEps/VehiculoEps.png"),
                            radius: 30,
                          ),
                          Divider(
                            color: Colors.blueGrey,
                            thickness: 5,
                          ),
                        ],
                      ),
                    ),
                    FormBuilder(
                      key: _registreKey,
                      initialValue: {
                        'date': DateTime.now(),
                        'accept_terms': false,
                      },
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          FormBuilderDateTimePicker(
                            attribute: "date",
                            inputType: InputType.date,
                            //format: DateTime(),
                            decoration:
                                InputDecoration(labelText: "Appointment Time"),
                          ),
                          FormBuilderSlider(
                            attribute: "slider",
                            validators: [FormBuilderValidators.min(6)],
                            min: 0.0,
                            max: 10.0,
                            initialValue: 1.0,
                            divisions: 20,
                            decoration:
                                InputDecoration(labelText: "Number of things"),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'accept_terms',
                            label: Text(
                                "I have read and agree to the terms and conditions"),
                            validators: [
                              FormBuilderValidators.requiredTrue(
                                errorText:
                                    "You must accept terms and conditions to continue",
                              ),
                            ],
                          ),
                          FormBuilderDropdown(
                            attribute: "gender",
                            decoration: InputDecoration(labelText: "Gender"),
                            // initialValue: 'Male',
                            hint: Text('Select Gender'),
                            validators: [FormBuilderValidators.required()],
                            items: ['Male', 'Female', 'Other']
                                .map((gender) => DropdownMenuItem(
                                    value: gender, child: Text("$gender")))
                                .toList(),
                          ),
                          FormBuilderTextField(
                            attribute: "age",
                            decoration: InputDecoration(labelText: "Age"),
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.max(70),
                            ],
                          ),
                          FormBuilderSegmentedControl(
                            decoration: InputDecoration(
                                labelText: "Movie Rating (Archer)"),
                            attribute: "movie_rating",
                            options: List.generate(5, (i) => i + 1)
                                .map((number) =>
                                    FormBuilderFieldOption(value: number))
                                .toList(),
                          ),
                          FormBuilderSwitch(
                            label: Text('I Accept the tems and conditions'),
                            attribute: "accept_terms_switch",
                            initialValue: true,
                          ),
                          FormBuilderStepper(
                            decoration: InputDecoration(labelText: "Stepper"),
                            attribute: "stepper",
                            initialValue: 10,
                            step: 1,
                          ),
                          FormBuilderRate(
                            decoration:
                                InputDecoration(labelText: "Rate this form"),
                            attribute: "rate",
                            iconSize: 32.0,
                            initialValue: 1,
                            max: 5,
                          ),
                          FormBuilderCheckboxList(
                            decoration: InputDecoration(
                                labelText: "The language of my people"),
                            attribute: "languages",
                            initialValue: ["Dart"],
                            options: [
                              FormBuilderFieldOption(value: "Dart"),
                              FormBuilderFieldOption(value: "Kotlin"),
                              FormBuilderFieldOption(value: "Java"),
                              FormBuilderFieldOption(value: "Swift"),
                              FormBuilderFieldOption(value: "Objective-C"),
                            ],
                          ),
                          FormBuilderSignaturePad(
                            decoration: InputDecoration(labelText: "Signature"),
                            attribute: "signature",
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        MaterialButton(
                          child: Text("Submit"),
                          onPressed: () {
                            if (_registreKey.currentState.saveAndValidate()) {
                              print(_registreKey.currentState.value);
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("Reset"),
                          onPressed: () {
                            _registreKey.currentState.reset();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
