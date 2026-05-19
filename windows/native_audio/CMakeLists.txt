cmake_minimum_required(VERSION 3.14)

add_library(fzprox_audio SHARED
  audio_engine.cpp
  audio_engine.h
)

target_compile_definitions(fzprox_audio PRIVATE FZPROX_AUDIO_EXPORTS)
target_compile_features(fzprox_audio PRIVATE cxx_std_17)
target_compile_options(fzprox_audio PRIVATE /W3 /EHsc)

# WASAPI + COM + AVRT
target_link_libraries(fzprox_audio PRIVATE
  mmdevapi
  avrt
  ole32
  psapi
  propsys
)

# Put the DLL alongside the Flutter runner executable.
set_target_properties(fzprox_audio PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/runner/$<CONFIG>"
)
