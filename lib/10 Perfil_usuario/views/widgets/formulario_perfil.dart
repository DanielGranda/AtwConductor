import 'package:antawaschool/utils/hexaColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormularioPerfil extends StatelessWidget {
  const FormularioPerfil({
    Key key,
    GlobalKey<FormBuilderState> perfilPadresKey,
    this.colorField,
  })  : _perfilPadresKey = perfilPadresKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _perfilPadresKey;
  final Color colorField;

  @override
  Widget build(BuildContext context) {
    final bool editDireccion = false;
    Color colorField = Color(hexColor('#3A4A64'));
    return FormBuilder(
      key: _perfilPadresKey,
      initialValue: {
        'date': DateTime.now(),
        'accept_terms': false,
      },
      autovalidate: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              readOnly: true,
              enableInteractiveSelection: false,
              focusNode: FocusNode(),
              enabled: false,
              keyboardType: TextInputType.emailAddress,
              attribute: "email",
              decoration: InputDecoration(
                  enabled: false,
                  icon: Icon(Icons.alternate_email, color: colorField),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 14, color: colorField),
                  helperStyle: TextStyle(fontSize: 12, color: colorField),
                  hintText: 'Ingrese su email'),
              style: TextStyle(fontSize: 14, color: colorField),
              validators: [
                FormBuilderValidators.required(
                  errorText: 'Requerido',
                ),
                FormBuilderValidators.email(
                    errorText: 'Debe ser un correo válido')
              ],
            ),
            SizedBox(
              height: 1,
            ),
            FormBuilderTextField(
              readOnly: true,
              keyboardType: TextInputType.emailAddress,
              attribute: "celular",
              decoration: InputDecoration(
                  enabled: false,
                  icon: Icon(Icons.call, color: colorField),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Celular",
                  labelStyle: TextStyle(fontSize: 14, color: colorField),
                  helperStyle: TextStyle(fontSize: 12, color: colorField),
                  hintText: 'Ingrese su cular'),
              style: TextStyle(fontSize: 14, color: colorField),
              validators: [
                FormBuilderValidators.required(
                  errorText: 'Requerido',
                ),
                FormBuilderValidators.email(
                    errorText: 'Debe ser un correo válido')
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: FormBuilderTextField(
                    readOnly: editDireccion,
                    keyboardType: TextInputType.emailAddress,
                    attribute: "dirección",
                    decoration: InputDecoration(
                        enabled: false,
                        icon: Icon(Icons.map, color: colorField),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Dirección",
                        labelStyle:
                            TextStyle(fontSize: 14, color: colorField),
                        helperStyle:
                            TextStyle(fontSize: 12, color: colorField),
                        hintText: 'Ingrese su dirección'),
                    style: TextStyle(fontSize: 14, color: colorField),
                    validators: [
                 
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Color(hexColor('#F6C34F')),
                    ),
                    onPressed: () {
                      print('object');
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
