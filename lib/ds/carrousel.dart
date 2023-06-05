
part of 'ds.dart';
class TopCarrossel extends StatefulWidget {
  final List<Widget> children;
  final Duration? automaticSwitchPageDuration;
  final PageController? pageController;
  const TopCarrossel({super.key, required this.children,this.automaticSwitchPageDuration, this.pageController });

  @override
  State<TopCarrossel> createState() => _TopCarrosselState();
}

class _TopCarrosselState extends State<TopCarrossel> {
  final ValueNotifier<int> _indexPage = ValueNotifier(0);
  PageController? _pageController;
  Timer? _timer;
 @override 
 void initState(){
  super.initState();
  _pageController = widget.pageController ?? PageController(); 
  if(widget.automaticSwitchPageDuration != null){
    _timer =Timer.periodic(widget.automaticSwitchPageDuration!, (timer) { 
      if(widget.children.length == (_indexPage.value +1)){
        _pageController!.jumpToPage(0);
      }else{
        _pageController!.jumpToPage(_indexPage.value+1);
      }
    });
  }

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _indexPage,
      builder: (context, currentIndex,child) {
        return Stack(
          children: [
            PageView(
              controller: _pageController,
              children: widget.children,
              onPageChanged: (p){
                _indexPage.value = p;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.children.length, (index) => index)
                      .map<Widget>((index) => AnimatedOpacity(
                        duration: const Duration(microseconds: 800),
                        opacity: index == currentIndex ? 1:.4 ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:2.0),
                          child: Container(
                            height: 3,
                            width: 25,
                            color: Colors.white,
                          ),
                        )))
                      .toList(),
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
