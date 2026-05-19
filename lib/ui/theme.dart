import 'package:flutter/material.dart';

// ── Colour palette ─────────────────────────────────────────────────────────
const _kBg        = Color(0xFF0A0A0F);
const _kSurface   = Color(0xFF13131F);
const _kCard      = Color(0xFF1C1C2E);
const _kBorder    = Color(0xFF2E2E45);
const _kPrimary   = Color(0xFFFF6B00); // Forza orange
const _kSecondary = Color(0xFF00C9FF); // electric blue
const _kSuccess   = Color(0xFF00FF88);
const _kWarning   = Color(0xFFFFD600);
const _kError     = Color(0xFFFF4444);
const _kText      = Color(0xFFE0E0F0);
const _kTextMuted = Color(0xFF7070A0);

// Expose for widgets
const kColorPrimary   = _kPrimary;
const kColorSecondary = _kSecondary;
const kColorSuccess   = _kSuccess;
const kColorWarning   = _kWarning;
const kColorError     = _kError;
const kColorBg        = _kBg;
const kColorSurface   = _kSurface;
const kColorCard      = _kCard;
const kColorBorder    = _kBorder;
const kColorText      = _kText;
const kColorTextMuted = _kTextMuted;

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3:     true,
    brightness:       Brightness.dark,
    scaffoldBackgroundColor: _kBg,
    colorScheme: const ColorScheme.dark(
      primary:   _kPrimary,
      secondary: _kSecondary,
      surface:   _kSurface,
      error:     _kError,
      onPrimary: Colors.white,
      onSurface: _kText,
    ),
    cardTheme: CardThemeData(
      color:        _kCard,
      elevation:    0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:         const BorderSide(color: _kBorder, width: 1),
      ),
      margin: const EdgeInsets.all(0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled:          true,
      fillColor:       _kSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:   const BorderSide(color: _kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:   const BorderSide(color: _kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:   const BorderSide(color: _kPrimary, width: 2),
      ),
      labelStyle:  const TextStyle(color: _kTextMuted),
      hintStyle:   const TextStyle(color: _kTextMuted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        textStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _kPrimary,
        side:            const BorderSide(color: _kPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _kPrimary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
    dividerTheme: const DividerThemeData(color: _kBorder, thickness: 1),
    textTheme: const TextTheme(
      displayLarge:  TextStyle(color: _kText,      fontSize: 32, fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(color: _kText,      fontSize: 24, fontWeight: FontWeight.w700),
      headlineMedium:TextStyle(color: _kText,      fontSize: 20, fontWeight: FontWeight.w600),
      titleLarge:    TextStyle(color: _kText,      fontSize: 16, fontWeight: FontWeight.w600),
      titleMedium:   TextStyle(color: _kText,      fontSize: 14, fontWeight: FontWeight.w500),
      bodyLarge:     TextStyle(color: _kText,      fontSize: 14),
      bodyMedium:    TextStyle(color: _kTextMuted, fontSize: 13),
      labelLarge:    TextStyle(color: _kText,      fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.8),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor:   _kPrimary,
      inactiveTrackColor: _kBorder,
      thumbColor:         _kPrimary,
      overlayColor:       Color(0x33FF6B00),
    ),
    switchTheme: SwitchThemeData(
      thumbColor:  WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? _kPrimary : _kTextMuted),
      trackColor:  WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? _kPrimary.withAlpha(100) : _kSurface),
    ),
    chipTheme: ChipThemeData(
      backgroundColor:   _kCard,
      selectedColor:     _kPrimary.withAlpha(40),
      side:              const BorderSide(color: _kBorder),
      labelStyle:        const TextStyle(color: _kText, fontSize: 12),
    ),
  );
}
