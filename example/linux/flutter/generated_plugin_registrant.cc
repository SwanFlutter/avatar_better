//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_saver/flutter_saver_plugin.h>
#include <image_picker_master/image_picker_master_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_saver_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterSaverPlugin");
  flutter_saver_plugin_register_with_registrar(flutter_saver_registrar);
  g_autoptr(FlPluginRegistrar) image_picker_master_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ImagePickerMasterPlugin");
  image_picker_master_plugin_register_with_registrar(image_picker_master_registrar);
}
