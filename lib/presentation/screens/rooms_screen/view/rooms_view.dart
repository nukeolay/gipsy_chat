import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gipsy_chat/presentation/common/widgets/error_snack_bar.dart';
import 'package:gipsy_chat/presentation/common/routes/routes.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/bloc/rooms_cubit.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/bloc/rooms_state.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/widgets/app_bar_user_name.dart';
import 'package:gipsy_chat/presentation/screens/rooms_screen/widgets/room_tile.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarUserName(),
        leading: null,
        actions: [
          IconButton(
            onPressed: () => context.read<RoomsCubit>().logout(),
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<RoomsCubit, RoomsState>(
          listener: (context, state) {
            if (state.status.isNotLogined) {
              Navigator.of(context).pushReplacementNamed(Routes.login);
            }
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
                context,
                state.errorMessage!,
              ));
            }
            if (state.status.isDisconnected) {
              ScaffoldMessenger.of(context).showSnackBar(ErrorSnackBar(
                context,
                'No network connection 😤',
              ));
            }
          },
          builder: (context, state) => state.status.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: state.rooms.length,
                  itemBuilder: (context, index) => RoomTile(state.rooms[index]),
                ),
        ),
      ),
      floatingActionButton:
          context.watch<RoomsCubit>().state.status.isDisconnected
              ? reconnectFab(context)
              : addNewRoomFab(context),
    );
  }

  FloatingActionButton addNewRoomFab(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab',
      onPressed: () => Navigator.of(context).pushNamed(Routes.createRoom),
      child: const Icon(Icons.add),
    );
  }

  FloatingActionButton reconnectFab(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'fab',
      onPressed: () => context.read<RoomsCubit>().reconnect(),
      label: const Text('Reconnect'),
    );
  }
}
