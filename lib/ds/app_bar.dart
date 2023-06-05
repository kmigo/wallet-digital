// ignore_for_file: unnecessary_null_in_if_null_operators

part of 'ds.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool avatarPerson;
  const TopAppBar(
      {super.key,
      this.onBack,
      this.title,
      this.centerTitle,
      this.avatarPerson =false,
      this.actions,
      this.leading})
      : assert(leading == null && onBack == null && avatarPerson  ==false ||
            onBack != null && leading == null  && avatarPerson  ==false||
            leading != null && onBack == null && avatarPerson  == false ||
            avatarPerson  && onBack == null && leading == null
            );

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _TopAppBarState extends State<TopAppBar> {
  final bloc = Modular.get<AutheticationBloc>();
  List<Widget> actions = []; 
  Widget? leading;
  @override
  void initState() {

    super.initState();
    
    actions.addAll(widget.actions ?? []);
    if(widget.avatarPerson){
      bloc.add(AuthenticationCurrentUserEvent());
      actions.add(IconButton(onPressed: ()=> bloc.add(AuthenticationSignOutEvent()), icon: const Icon(Icons.exit_to_app)));
    }
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AutheticationBloc, AutheticationState>(
      bloc: bloc,
      builder: (context, state) {
        widget.actions?.add(IconButton(onPressed: ()=> bloc.add(AuthenticationSignOutEvent()), icon: const Icon(Icons.exit_to_app)));
        return AppBar(

          iconTheme: const IconThemeData(color: TopColors.primaryColor),
          actionsIconTheme: const IconThemeData(color: TopColors.primaryColor),
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: TopColors.primaryColor),
          leading: _leading( state.status.user),
          title: widget.title,
          centerTitle: widget.centerTitle,
          actions: actions,
          elevation: 0,
          backgroundColor: TopColors.greyColor.withOpacity(.5),
        );
      },
    );
  }
  _leading( UserEntity? user){
    final person =  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            Modular.to.navigate(AppRoutes.profile);
          },
          child: Container(
                      decoration: BoxDecoration(
                        color: TopColors.greyColor,
                        borderRadius: BorderRadius.circular(360)
                      ),
                      child:  Padding(
                        padding:  const EdgeInsets.all(8.0),
                        child:  InkWell(
                          onTap: (){
Modular.to.navigate(AppRoutes.profile);
                          },
                          child: const Icon(Icons.person)),
                      )),
        ),
      ],
    );
    if(widget.avatarPerson && user != null){
      
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: InkWell(
            onTap: (){
              Modular.to.navigate(AppRoutes.profile);
            },
            child: SizedBox(
              height: 40,
              width: 40,
              child: Image.memory(base64Decode(user.image.substring(user.image.indexOf(',') + 1)),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return person;
              },
              ),
            ),
          ),
        ),
      );
    }
  return widget.onBack != null
              ? IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(
                    Icons.arrow_back,
                  ))
              : widget.leading ?? null;
}

}

