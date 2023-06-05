


part of '../ds.dart';
enum TopButtonType {normal,outline, contain}

class TopButton extends StatefulWidget {
  final double? width;
  final VoidCallback? onTap;
  final String text;
  final TopButtonType type;
  final bool loading;
  final bool disabled;
  const TopButton({super.key,this.width,this.onTap,this.disabled = false, this.type = TopButtonType.normal,this.loading =false, required this.text});

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton>  with  SingleTickerProviderStateMixin{
   double? _scale;
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
     _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      
        setState(() {});
        if(_controller?.isCompleted == true){
          _controller?.reverse();
        }
      });
      
  }
  @override
  dispose(){
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value.toDouble();
    return Center(
      child: InkWell(
        onTap: (){

          if(widget.loading || widget.disabled) return;
          _controller?.forward();
          if(widget.onTap != null){

          widget.onTap!();
          }
        },
        child: Transform.scale(
          scale: _scale,
          child: Container(
            width: widget.width,
            height: 48,
            decoration: _switchByttonType(widget.type),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.loading ? const Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ) : _child(widget.type),
            ),
          ),
        ),
      ),
    );
  }

  _text(TopButtonType type,context){
     switch(type){
      case TopButtonType.normal:
        return TopText(text:widget.text.toUpperCase(),
              style: _textTheme(widget.type, context),
              );
      case TopButtonType.outline:
      return TopText(text:widget.text.toUpperCase(),
              style: _textTheme(widget.type, context),
              );
      case TopButtonType.contain:
      return TopText(text:widget.text.toUpperCase(),
              style: _textTheme(widget.type, context),
              );
    }
  }

  _child(TopButtonType type){
    switch(type){
      case TopButtonType.normal:
      return Center(
        child: _text(type, context),
      );
      case TopButtonType.outline:
      return Center(
        child: _text(type, context),
      );
      case TopButtonType.contain:
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _text(type,context)
        ],
      );
    }
  }

  _textTheme(TopButtonType type,BuildContext context){
    switch(type){
      case TopButtonType.normal:
        return Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white
            );
      case TopButtonType.outline:
        return Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: TopColors.greenColor
            );  
      case TopButtonType.contain:
        return Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white
            );
    }
  }

  _switchByttonType(TopButtonType type){
    switch(type){
      case TopButtonType.normal:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: TopColors.greenColor,
              width: .2
            ),
            boxShadow: const [BoxShadow(
              color: Colors.black12,
              offset: Offset.zero,
              blurRadius: 1,
              spreadRadius: 1
            )],
            gradient:   LinearGradient(
            colors: widget.disabled ? [TopColors.greyColor.withOpacity(.6),TopColors.greyColor] :[TopColors.lightGreen,TopColors.greenColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
            )
          );
      case TopButtonType.outline:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.green,
              width: 2
            ),
          );
      case TopButtonType.contain:
        return BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.green,
              width: .2
            ),
            boxShadow: const [BoxShadow(
              color: Colors.black12,
              offset: Offset.zero,
              blurRadius: 1,
              spreadRadius: 1
            )],
            gradient:   LinearGradient(
            colors:widget.disabled ? [TopColors.greyColor.withOpacity(.6),TopColors.greyColor] :[TopColors.lightGreen,TopColors.greenColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
            )
          );
    }
  }
}