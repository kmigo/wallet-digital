part of 'ds.dart';

class ErrorTryAgain extends StatelessWidget {
  final String? message;
  final VoidCallback? onTap;
  const ErrorTryAgain({super.key,this.message, this.onTap});

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
                  TopText(text: "Atenção",
                  style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  TopText(text: message ?? "Desculpe, ocorreu um erro inesperado no aplicativo. Por favor, tente novamente mais tarde. Se o problema persistir, entre em contato com nossa equipe de suporte para que possamos ajudá-lo a resolver o problema. Lamentamos qualquer inconveniente causado.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8,),
                 if(onTap != null)...[
                   TopButton(text: "Tentar Novamente",
                  onTap: onTap,
                  )
                 ]
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}