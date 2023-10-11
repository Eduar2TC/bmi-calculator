import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;

class Weight extends StatefulWidget {
  final int? width; //width

  const Weight({super.key, this.width});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  int? width;
  @override
  void initState() {
    super.initState();
    width = widget.width ?? 40;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => WeightPicker(
                widgetWidth: constraints.maxWidth,
                width: width ?? 40,
                onValueChanged: (value) {
                  setState(() {
                    width = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeightPicker extends StatefulWidget {
  final double? widgetWidth;
  final int? width;
  final int minWidth;
  final int maxWidth;
  final ValueChanged<int>? onValueChanged;

  const WeightPicker({
    super.key,
    this.widgetWidth,
    this.width,
    this.minWidth = 40,
    this.maxWidth = 100,
    this.onValueChanged,
  });

  int get totalUnits => maxWidth - minWidth;

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  late double startDragXOffset;
  late int startDragWidth;
  double get pixelsPerUnit => drawingWidth / widget.totalUnits;
  double get drawWidthSlider => widget.widgetWidth!; //TODO: delete margins
  bool tapped = false;

  double get sliderPosition {
    int unitsFromLeft = widget.width! - widget.minWidth;
    return unitsFromLeft * pixelsPerUnit;
  }

  //return actual width of slider to be able to slide
  double get drawingWidth {
    double totalWidth = widget.widgetWidth!;
    return totalWidth - 15; //TODO: delete left and right margins
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: onTapDown,
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onTapCancel: () {
        setState(() {
          tapped = false;
        });
      },
      onPanDown: (details) {
        setState(() {
          tapped = true;
        });
      },
      onPanCancel: () {
        setState(() {
          tapped = false;
        });
      },
      onPanEnd: (details) {
        setState(() {
          tapped = false;
        });
      },
      onHorizontalDragCancel: () {
        setState(() {
          tapped = false;
        });
      },
      onHorizontalDragEnd: (_) {
        setState(() {
          tapped = false;
        });
      },
      child: Stack(
        children: [
          drawDropDownButton(),
          drawPerson(),
          drawSlider(tapped),
          drawLabels(),
        ],
      ),
    );
  }

  onTapDown(TapDownDetails details) {
    int width = globalOffsetToWidth(details.globalPosition);
    widget.onValueChanged!(normalizeWidth(width));
    print('onTapDown ---------> ${widget.width}');
    setState(() {
      tapped = true;
    });
  }

  int normalizeWidth(int width) {
    return math.max(widget.minWidth, math.min(widget.maxWidth, width));
  }

  int globalOffsetToWidth(Offset globalOffset) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localOffset = box.globalToLocal(globalOffset);
    double dx = localOffset.dx;
    int width = widget.minWidth + (dx / pixelsPerUnit).round();
    print('-----> $width');
    return width;
  }

  //Horizontal dragging
  onDragStart(DragStartDetails dragStartDetails) {
    int newWidth = globalOffsetToWidth(dragStartDetails.globalPosition);
    widget.onValueChanged!(newWidth);
    setState(() {
      startDragXOffset = dragStartDetails.globalPosition.dx;
      startDragWidth = newWidth;
    });
  }

  onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    double currentXOffset = dragUpdateDetails.globalPosition.dx;
    double horizontalDifference = startDragXOffset - currentXOffset;
    int widthDifference = (horizontalDifference / pixelsPerUnit).round();
    int newWidth = normalizeWidth(startDragWidth - widthDifference);
    setState(() {
      widget.onValueChanged!(newWidth);
      tapped = true;
    });
  }

  Widget drawLabels() {
    int labelsToDisplay = (widget.totalUnits / 10 + 1).truncate();
    List<Widget> labels = List.generate(
      labelsToDisplay,
      (index) => Text(
        "${widget.maxWidth - 10 * index}",
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
      ),
    ).reversed.toList();
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IgnorePointer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels,
          ),
        ),
      ),
    );
  }

  Widget drawSlider(bool tapped) {
    print('sliderPosition: $sliderPosition');
    return Positioned(
      top: 80,
      left: sliderPosition,
      child: WidthSlider(
        width: widget.width!,
        tapped: tapped,
      ),
    );
  }

  Widget drawPerson() {
    double personImageWidth = widget.minWidth + sliderPosition;
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        child: SvgPicture.asset(
          'lib/assets/man012.svg',
          width: personImageWidth,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget drawDropDownButton() {
    return const Align(
      alignment: Alignment.topCenter,
      child: DropDownButton(),
    );
  }
}

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  List<String> options = ['Weight (lbs)', 'Weight (kg)'];
  String? dropdownValue;
  @override
  void initState() {
    dropdownValue = options.first;
    super.initState();
  }

  Widget dropDownButton() {
    final borderRadiusDropdown = BorderRadius.circular(14);
    const textColorItem = Colors.black;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      elevation: 16,
      borderRadius: borderRadiusDropdown,
      underline: const SizedBox(),
      isExpanded: false,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: options.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: textColorItem,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return dropDownButton();
  }
}

class WidthSlider extends StatelessWidget {
  final int? width;
  final bool? tapped;
  const WidthSlider({super.key, this.width, this.tapped});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Column(
        children: [
          SliderLabel(
            width: width!,
          ),
          Column(
            children: [
              SliderCircle(tapped: tapped), //passing tapped to change shadow
              const SizedBox(
                child: SliderLine(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SliderLine extends StatelessWidget {
  const SliderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        40,
        (index) => SizedBox(
          width: 2.0,
          child: Container(
            height: 3.0,
            decoration: BoxDecoration(
              color:
                  index.isEven ? Theme.of(context).primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SliderCircle extends StatelessWidget {
  final bool? tapped;
  const SliderCircle({super.key, this.tapped});

  //TODO: CORREGIR ESTO DESDE EL WIDGET PADRE
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeInOutCubic,
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          tapped == true
              ? BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 15,
                  blurRadius: 0.0,
                  offset: const Offset(0, 1.0), // changes position of shadow
                )
              : BoxShadow(
                  color: Colors.black.withOpacity(0.0),
                  spreadRadius: 0,
                  blurRadius: 0.0,
                  offset: const Offset(0, 1.0), // changes position of shadow
                )
        ],
      ),
      child: Transform.rotate(
        angle: math.pi / 2,
        child: const Icon(
          Icons.unfold_more,
          color: Colors.white,
          size: 10,
        ),
      ),
    );
  }
}

class SliderLabel extends StatelessWidget {
  final int? width;
  const SliderLabel({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Text(
        "$width",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
