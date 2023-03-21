import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData? icon;
  final ValueChanged<int> changeIndex;
  final int currentIndex;
  bool isSelected;

  BottomNavigationItem({
    super.key,
    this.icon,
    required this.changeIndex,
    required this.currentIndex,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              changeIndex(currentIndex);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            icon,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int>? changeIndex;
  final Color? color;
  final int? index;
  final String title;

  BottomNavBar(
      {Key? key, this.changeIndex, this.color, this.index, this.title = ''})
      : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  _changeIndex(int index) {
    widget.changeIndex!(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 4.0,
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        color: widget.color ?? Theme.of(context).bottomAppBarColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            BottomNavigationItem(
              icon: Icons.explore,
              changeIndex: _changeIndex,
              currentIndex: 0,
              isSelected: (widget.index == 0),
            ),
            BottomNavigationItem(
              icon: Icons.favorite,
              changeIndex: _changeIndex,
              currentIndex: 1,
              isSelected: widget.index == 1,
            ),
          ],
        ));
  }
}
