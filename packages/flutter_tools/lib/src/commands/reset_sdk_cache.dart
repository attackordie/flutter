import '../globals.dart' as globals;
import '../runner/flutter_command.dart';
import '../base/file_system.dart';
import '../base/logger.dart'; // Import for Status

class ResetSdkCacheCommand extends FlutterCommand {
  @override
  final String name = 'reset_sdk_cache';

  @override
  final String description = 'Clears the Flutter SDK cache.';

  @override
  Future<FlutterCommandResult> runCommand() async {
    // Specify the directory name within the cache
    final Directory cacheDir = globals.fs.directory(globals.cache.getCacheDir('pkg'));

    if (cacheDir.existsSync()) {
      try {
        final Status status = globals.logger.startProgress('Deleting Flutter SDK cache...');
        cacheDir.deleteSync(recursive: true);
        status.stop();
        globals.printStatus('Flutter SDK cache deleted successfully.');
      } on FileSystemException catch (e) {
        globals.printError('Failed to delete Flutter SDK cache: $e');
        return const FlutterCommandResult(ExitStatus.fail);
      }
    } else {
      globals.printStatus('Flutter SDK cache is already clean.');
    }
    return const FlutterCommandResult(ExitStatus.success);
  }
}
