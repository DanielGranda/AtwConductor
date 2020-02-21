
import 'package:antawaschool/10%20Perfil_usuario/views/widgets/cabecera_perfil.dart';
import 'package:antawaschool/10%20Perfil_usuario/views/widgets/fondoRegistro.dart';
import 'package:antawaschool/10%20Perfil_usuario/views/widgets/formulario_perfil.dart';
import 'package:antawaschool/10%20Perfil_usuario/views/widgets/tarjeta_perfil.dart';
import 'package:flutter/material.dart';


class PerfilUserUi extends StatefulWidget {
  @override
  _PerfilUserUiState createState() => _PerfilUserUiState();
}

//UserBloc userBloc;

class _PerfilUserUiState extends State<PerfilUserUi> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FondoRegistro(),
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      CabeceraPerfil(),
                      TarjetaPerfilFoto(
                        urlImg: 'assets/marce.png',
                        tipoEPS: 'Monitor',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormularioPerfil(),
                      SizedBox(
                        height: 10,
                      ),
                      TarjetaPerfilFoto(
                        tipoEPS: 'Condcutor',
                        urlImg: 'assets/daniel.png',
                      ),
                      FormularioPerfil(),
                        TarjetaPerfilFoto(
                        urlImg: 'assets/vehiculoAtg.png',
                        tipoEPS: 'Vehículo: PSX-0198',
                      ),
                     
                      Divider(),
                  
                
                          SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
