# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# OkHttp platform implementations
-dontwarn org.conscrypt.**
-dontwarn org.openjsse.**
-dontwarn org.bouncycastle.**

# Keep OkHttp
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontwarn okhttp3.internal.platform.**
-dontwarn org.conscrypt.ConscryptHostnameVerifier

# BouncyCastle
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# Conscrypt
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**

# OpenJSSE
-keep class org.openjsse.** { *; }
-dontwarn org.openjsse.**

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep custom exceptions
-keep public class * extends java.lang.Exception

# TTS
-keep class com.google.android.tts.** { *; }

# Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# HTTP
-keep class io.flutter.plugins.urllauncher.** { *; }
