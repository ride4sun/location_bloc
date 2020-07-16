terial.dart';
import 'package:location_bloc_example/misc/margins.dart';

class Button extends StatelessWidget {
  Button({@required this.onTap, @required this.text, this.maxLines = 1});

  final Function onTap;
  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) => RaisedButton(
      child: Margins(
          top: 15, bottom: 15, child: text == null ? Container() : Text(text)),
      onPressed: () {
        //debugger(when: true);
        onTap();
      },
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)));
}
