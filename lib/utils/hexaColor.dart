hexColor(String colorHexacode){
  String colornew = '0xff' + colorHexacode;
  colornew = colornew.replaceAll('#', '');
  int colorint = int.parse(colornew);
  return colorint;
}