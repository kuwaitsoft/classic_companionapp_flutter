import 'package:drivers_companionn/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PVDropdown extends StatefulWidget {
  final List<String> options;
  final String hintText;
  final ValueChanged<String?>? onChanged;

  const PVDropdown({
    Key? key,
    required this.options,
    this.hintText = 'Select an option',
    this.onChanged,
  }) : super(key: key);

  @override
  _PVDropdownState createState() => _PVDropdownState();
}

class _PVDropdownState extends State<PVDropdown> {
  bool _isDropdownOpen = false;
  String? _selectedValue; // Holds the currently selected value

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dropdown Header (the visible "Select parking lot" part)
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
          child: Container(
            //height: 48, // fixed height for dropdown header
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: appDarkGreyColor, // Use cardColor for background
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: appGreyColor), // Subtle border
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedValue ?? widget.hintText,
                  style: theme.textTheme.bodyLarge,
                ),
                Icon(
                  _isDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: appGreyColor, // Lighter icon color
                ),
              ],
            ),
          ),
        ),

        // Dropdown Options List (conditionally visible)
        Visibility(
          visible: _isDropdownOpen,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0), // Space between header and options
            child: Material(
              // Use Material to get shadow and rounded corners
              color: appGreyColor,
              borderRadius: BorderRadius.circular(8.0),
              elevation: 4.0, // Shadow
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                // child: ConstrainedBox(
                //   constraints: BoxConstraints(
                //     maxHeight:
                //         200, // Max height for the list to allow scrolling
                //   ),
                child: ListView.separated(
                  shrinkWrap: true, // Important to make ListView fit content
                  padding: EdgeInsets.zero, // Remove default padding
                  itemCount: widget.options.length,
                  separatorBuilder: (context, index) => Divider(
                    color: appGreyColor, // Separator line color
                    height: 0.5, // Make separator thin
                    thickness: 0.5,
                    indent: 16, // Indent for the separator
                    endIndent: 16,
                  ),
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    return InkWell(
                      // InkWell provides a ripple effect on tap
                      onTap: () {
                        setState(() {
                          _selectedValue = option;
                          _isDropdownOpen = false;
                        });
                        widget.onChanged?.call(option);
                      },
                      child: Container(
                        color: appDarkGreyColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Text(
                          option,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                ),
                //),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
