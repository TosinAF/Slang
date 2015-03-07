
// To check if a library is compiled with CocoaPods you
// can use the `COCOAPODS` macro definition which is
// defined in the xcconfigs so it is available in
// headers also when they are imported in the client
// project.


// AHKBendableView
#define COCOAPODS_POD_AVAILABLE_AHKBendableView
#define COCOAPODS_VERSION_MAJOR_AHKBendableView 0
#define COCOAPODS_VERSION_MINOR_AHKBendableView 2
#define COCOAPODS_VERSION_PATCH_AHKBendableView 0

// Cartography
#define COCOAPODS_POD_AVAILABLE_Cartography
#define COCOAPODS_VERSION_MAJOR_Cartography 0
#define COCOAPODS_VERSION_MINOR_Cartography 2
#define COCOAPODS_VERSION_PATCH_Cartography 0

// pop
#define COCOAPODS_POD_AVAILABLE_pop
#define COCOAPODS_VERSION_MAJOR_pop 1
#define COCOAPODS_VERSION_MINOR_pop 0
#define COCOAPODS_VERSION_PATCH_pop 7

// Debug build configuration
#ifdef DEBUG

  // Reveal-iOS-SDK
  #define COCOAPODS_POD_AVAILABLE_Reveal_iOS_SDK
  #define COCOAPODS_VERSION_MAJOR_Reveal_iOS_SDK 1
  #define COCOAPODS_VERSION_MINOR_Reveal_iOS_SDK 5
  #define COCOAPODS_VERSION_PATCH_Reveal_iOS_SDK 1

#endif
