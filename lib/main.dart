import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF222222),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimationControllerWidget(
                        options: ["idle", "running", "jumping"],
                      ),
                      const SizedBox(height: 24),
                      ControlButtons(),
                      const SizedBox(height: 24),
                      ThinBlackWhiteSlider(
                        value: 0.5,
                        onChanged: (value) => () {},
                      ),
                      const SizedBox(height: 24),

                      const SizedBox(height: 24),
                      PixelArtButton(
                        text: 'Press Me',
                        callback: _onButtonPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void _onButtonPressed() {
    debugPrint('PixelArtButton pressed!');
  }
}

class PixelArtButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const PixelArtButton({Key? key, required this.text, required this.callback})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ThinBlackWhiteSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final int? divisions;

  const ThinBlackWhiteSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2.0,
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.white,

        thumbColor: Colors.black,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),

        overlayColor: Colors.black.withOpacity(0.12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: divisions != null ? value.round().toString() : null,
        onChanged: onChanged,
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF222222),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.play_arrow, color: Colors.grey[300]),
          ),
        ),
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF222222),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.pause, color: Colors.grey[300]),
          ),
        ),
        SizedBox(width: 16),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF222222),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.square, color: Colors.grey[300]),
          ),
        ),
      ],
    );
  }
}

class AnimationControllerWidget extends StatefulWidget {
  final List<String> options;

  const AnimationControllerWidget({super.key, required this.options});

  @override
  _AnimationControllerWidgetState createState() =>
      _AnimationControllerWidgetState();
}

class _AnimationControllerWidgetState extends State<AnimationControllerWidget>
    with TickerProviderStateMixin {
  bool _isChecked = false;
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AnimatedSize(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Card(
          color: Color(0xFF222222),
          elevation: 4,

          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color>((
                        Set<MaterialState> states,
                      ) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      }),
                      side: BorderSide(color: Colors.white, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Animation Component",
                        style: TextStyle(
                          fontFamily: 'PressStart2P',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),

                Visibility(
                  visible: _isChecked,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children:
                          widget.options.map((option) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: RadioListTile<String>(
                                activeColor: Colors.white,
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  overflow: TextOverflow.ellipsis,
                                  option,
                                  style: TextStyle(
                                    fontFamily: 'PressStart2P',
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                                value: option,
                                groupValue: _selectedOption,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedOption = value;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
