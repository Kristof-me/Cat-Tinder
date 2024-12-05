import 'package:cat_tinder/common/widgets/gradient_shader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuNavigation extends StatelessWidget {
  MenuNavigation({super.key});

  final List<Map<String, dynamic>> items = [
    // * { 'label': 'Chats',    'path': '/chats', 'icon': Icons.chat_bubble_outline }, - not implemented
    { 'label': 'Liked',    'path': '/liked', 'icon': Icons.favorite_border_outlined },
    { 'label': 'Rate',     'path': '/rate',  'icon': Icons.star_outline },
    { 'label': 'Disliked', 'path': '/disliked', 'icon': Icons.close },
    { 'label': 'Settings', 'path': '/settings', 'icon': Icons.settings_rounded },
  ];

  final Color unselectedColor = Colors.grey.shade600;
  
  final LinearGradient gradient = LinearGradient(
    colors: [ Colors.orange, Colors.red, Colors.deepPurple, Colors.blueAccent.shade700], 
    begin: Alignment.topCenter, end: Alignment.bottomCenter
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool showLabels = size.height > 600 && size.width > 500;
    final String path = GoRouterState.of(context).uri.path;

    return Container(
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHighest, 
            width: 2
          )
        ),
        boxShadow: [ 
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 18.0,
            spreadRadius: 5.0,
          ) 
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          if (path == item['path']) {
            return getSelectedButton(
              label: item['label'], 
              icon: item['icon'],
              gradient: gradient,
              isExpanded: showLabels,
            );
          }
          
          return getUnselectedButton(
            label: item['label'], 
            icon: item['icon'], 
            onPressed: () => context.go(item['path']), 
            showLabels: showLabels
          );
        }).toList(),
      ),
    );
  }

  Widget getUnselectedButton({String? label, required IconData icon, VoidCallback? onPressed, bool showLabels = true}) {
    if (showLabels && label != null) {
      return TextButton(
        onPressed: onPressed, 
        style: OutlinedButton.styleFrom(
          foregroundColor: unselectedColor,
          shape: CircleBorder(),
          padding: EdgeInsets.all(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28.0),
            Text(label, style: TextStyle(fontSize: 12.0)),
          ],
        ),
      );
    } 

    return IconButton(
      color: unselectedColor,
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }

   Widget getSelectedButton({String? label, required IconData icon, required LinearGradient gradient, bool isExpanded = true}) {
    return GradientShader(
      gradient: gradient,
      child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(isExpanded ? 20.0 : 14.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon, 
                size: isExpanded ? 32.0 : 25.0, 
                weight: 600.0
              ),
              if(isExpanded && label != null) 
                Text(
                  label, 
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  )
                ),
            ],
          ),
        ),
    );
  }
   
}