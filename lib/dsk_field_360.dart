import 'package:flutter/cupertino.dart';

import 'dsk_field_numeric.dart';
import 'dsk_picker_360.dart';

class DSKField360 extends StatefulWidget {
  final double defaultValue;
  final double textSize;
  final bool enabled;
  final Function(double)? onChanged;
  const DSKField360({
    Key? key,
    this.defaultValue = 0.0,
    this.textSize = 12,
    this.enabled = true,
    this.onChanged,
  }) : super(key: key);

  @override
  DSKField360State createState() => DSKField360State();
}

class DSKField360State extends State<DSKField360> {
  GlobalKey<DSKPicker360State> keyPicker = GlobalKey();
  GlobalKey<DSKFieldNumericState> keyNumeric = GlobalKey();
  double _currentAngle = 0;

  @override
  void initState() {
    super.initState();
    _currentAngle = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DSKPicker360(
          key: keyPicker,
          defaultValue: _currentAngle,
          size: widget.textSize + 8,
          enabled: widget.enabled,
          onChanged: (angle) {
            setState(() {
              keyNumeric.currentState?.setValue(angle);
              _currentAngle = angle;
            });
          },
        ),
        const SizedBox(width: 4),
        Expanded(
          child: DSKFieldNumeric(
            key: keyNumeric,
            defaultValue: _currentAngle,
            textSize: widget.textSize,
            min: 0,
            max: 360,
            increment: 1,
            decimals: 0,
            enabled: widget.enabled,
            onChanged: (value) {
              setState(() {
                keyPicker.currentState?.setValue(value);
                _currentAngle = value;
                widget.onChanged?.call(value);
              });
            },
          ),
        )
      ],
    );
  }
}
