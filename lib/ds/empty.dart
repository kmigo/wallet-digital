part of 'ds.dart';

class TopEmpty extends StatelessWidget {
  final String? message;
  final VoidCallback? onTap;
  const TopEmpty({super.key,this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _EmptyListPlaceholder()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class _EmptyListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.list,
            size: 50.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'A lista está vazia',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}