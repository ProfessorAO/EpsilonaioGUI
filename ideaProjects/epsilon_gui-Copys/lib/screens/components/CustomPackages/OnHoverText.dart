import 'package:sprung/sprung.dart';
import 'package:flutter/material.dart';

class OnHoverText extends StatefulWidget{
  final Widget child;

  const OnHoverText({
    Key? key,

    required this.child,
}) : super(key:key);
  @override
  _OnHoverTextState createState() => _OnHoverTextState();
}

  class _OnHoverTextState extends State<OnHoverText>{

  bool isHovered = false ;

  @override
  Widget build(BuildContext context){
    // use 3d matrix to move it instead of scaling it
    final hoveredTransform = Matrix4.identity()..scale(1.2);
    final transform = isHovered? hoveredTransform: Matrix4.identity();
  return MouseRegion(
    cursor: SystemMouseCursors.click ,
    onEnter: (event)=> OnEntered(true),
    onExit: (event)=> OnEntered(false) ,
    child:AnimatedContainer(
      transform: transform,
      child: widget.child,
      duration: Duration(milliseconds: 100),
    ),
  );

  }
  void OnEntered(bool isHovered)=> setState ((){
    this.isHovered = isHovered ;
  });
  }

