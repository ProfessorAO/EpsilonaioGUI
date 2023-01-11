
import 'package:flutter/material.dart';

class OnHoverChange extends StatefulWidget{
  final Widget Function(bool isHovered) builder;

  const OnHoverChange({
    Key? key,

    required this.builder,
  }) : super(key:key);
  @override
  _OnHoverChangeState createState() => _OnHoverChangeState();
}

class _OnHoverChangeState extends State<OnHoverChange>{

  bool isHovered = false ;

  @override
  Widget build(BuildContext context){
    // use 3d matrix to move it instead of scaling it
    final hoveredTransform = Matrix4.identity()..scale(1.05);
    final transform = isHovered? hoveredTransform: Matrix4.identity();
    return MouseRegion(
      cursor: SystemMouseCursors.click ,
      onEnter: (event)=> OnEntered(true),
      onExit: (event)=> OnEntered(false) ,
      child:AnimatedContainer(
        transform: transform,
        duration: const Duration(milliseconds: 100),
        child: widget.builder(isHovered),
      ),
    );

  }
  void OnEntered(bool isHovered)=> setState ((){
    this.isHovered = isHovered ;
  });
}

