

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double speed;
  final double pause;

  AnimatedText({this.text, this.style, this.speed = 50, this.pause = 1000});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  String _displayText = '';
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() async {
    for (int i = 0; i < widget.text.length; i++) {
      await Future.delayed(Duration(milliseconds: (widget.speed).round()));
      setState(() {
        _displayText = widget.text.substring(0, _index) + '|';
        if (_index < widget.text.length) {
          _index++;
        }
      });
    }
    await Future.delayed(Duration(milliseconds: (widget.pause).round()));
    setState(() {
      _displayText = widget.text;
      _index = 0;
    });
    _animateText();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style,
    );
  }
}
