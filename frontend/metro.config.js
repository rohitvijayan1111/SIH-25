const { getDefaultConfig } = require("expo/metro-config");
const { withNativeWind } = require("nativewind/metro");

const config = getDefaultConfig(__dirname);

// Add resolver configuration for React Native Web
config.resolver.alias = {
  ...config.resolver.alias,
  "react-native$": "react-native-web",
};

// Add platform extensions
config.resolver.platforms = ["web", "ios", "android"];

module.exports = withNativeWind(config, { input: "./app/global.css" });
