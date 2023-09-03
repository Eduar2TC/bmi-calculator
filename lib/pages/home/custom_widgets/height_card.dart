import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

final ValueNotifier<String> heightNotifier = ValueNotifier<String>('');
int? valueA = 5;
int? valueB = 3;
Key pickerKey = UniqueKey();

class HeightCard extends StatefulWidget {
  const HeightCard({super.key});
  @override
  State<HeightCard> createState() => _HeightCardState();
}

class _HeightCardState extends State<HeightCard> {
  void setValueA(int value, String? longitude) {
    setState(() {
      valueA = value;
    });
  }

  void setValueB(int value, String? longitude) {
    setState(() {
      valueB = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          const DropdownOption(),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            direction: Axis.horizontal,
            spacing:
                constraints.maxWidth * 0.05, //TODO: modify this value later
            children: [
              ValueListenableBuilder(
                valueListenable: heightNotifier,
                builder: (context, value, _) => SelectionPicker(
                  key: pickerKey,
                  longitude:
                      heightNotifier.value == 'Height (inch)' ? 'ft' : 'm',
                  callback: setValueA,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: heightNotifier,
                builder: (context, value, _) => SelectionPicker(
                  key: pickerKey,
                  longitude:
                      heightNotifier.value == 'Height (inch)' ? 'in' : 'cm',
                  callback: setValueB,
                ),
              ),
            ],
          ),
          SizedBox(
            height: constraints.maxWidth * 0.05, //TODO: modify this value later
          ),
          Flexible(
            child: ValueListenableBuilder(
              valueListenable: heightNotifier,
              builder: (context, value, _) => Text(
                textAlign: TextAlign.center,
                heightNotifier.value == 'Height (inch)'
                    ? '$valueA feet $valueB inches (${(valueA! * 30.48).toInt() + (valueB! * 2.54).toInt()} cm)'
                    : '$valueA mts $valueB cms (${(valueA! * 39.37).toInt() + (valueB! * 0.393).toInt()} inches)',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18, //TODO: modify this value later
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownOption extends StatefulWidget {
  const DropdownOption({
    super.key,
  });
  @override
  State<DropdownOption> createState() => _DropdownOptionState();
}

class _DropdownOptionState extends State<DropdownOption> {
  static const List<String> listValues = ['Height (inch)', 'Height (cm)'];

  @override
  void initState() {
    heightNotifier.value = listValues.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadiusDropdown = BorderRadius.circular(14);
    const textColorItem = Colors.black;

    return StatefulBuilder(
      builder: (context, setInnerState) => DropdownButton<String>(
        //internal state for custom dropdown button
        value: heightNotifier.value,
        style: TextStyle(
            color: textColorItem,
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
        borderRadius: borderRadiusDropdown,
        underline: const SizedBox(),
        elevation: 9,
        onChanged: (String? value) {
          setInnerState(() {
            heightNotifier.value = value!;
            pickerKey = UniqueKey();
          });
        },
        items: listValues.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class SelectionPicker extends StatefulWidget {
  const SelectionPicker({
    super.key,
    this.longitude,
    required this.callback,
  });
  final String? longitude;
  final Function(int, String) callback;

  @override
  State<SelectionPicker> createState() => _SelectionPickerState();
}

class _SelectionPickerState extends State<SelectionPicker> {
  int currentValue = 1;
  late int maxValue;

  @override
  void initState() {
    maxValue = changeMaxLimit(widget.longitude);
    super.initState();
  }

  int changeMaxLimit(String? longitude) {
    switch (longitude) {
      case 'in':
        return 12;
      case 'ft':
        return 5;
      case 'm':
        return 2;
      case 'cm':
        return 100;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.045, //TODO: modify this value later
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFF8FAFF),
      ),
      child: NumberPicker(
        textMapper: (value) {
          return int.parse(value) - 1 < currentValue &&
                  int.parse(value) + 1 > currentValue
              ? '$value\t\t ${widget.longitude}'
              : value.toString();
        },
        axis: Axis.vertical,
        minValue: 1,
        maxValue: maxValue, //TODO: modify this value later
        itemWidth: screenWidth * 0.25, //TODO: modify this value later
        itemHeight: screenHeight * 0.050,
        textStyle: TextStyle(
          color: Colors.black.withOpacity(0.2),
          fontSize: 18, //TODO: modify this value later
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.black54,
        ),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Color(0xFF91AEF9),
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onChanged: (int value) {
          int newMaxValue = changeMaxLimit(widget.longitude);
          if (value > newMaxValue) {
            setState(() {
              currentValue = newMaxValue;
              maxValue = newMaxValue;
              widget.callback(currentValue, widget.longitude.toString());
            });
          } else {
            setState(() {
              currentValue = value;
              maxValue = newMaxValue;
              widget.callback(currentValue, widget.longitude.toString());
            });
          }
        },
        value: currentValue,
      ),
    );
  }
}
