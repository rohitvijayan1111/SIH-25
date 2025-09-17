import React, { useState, useEffect } from 'react';
import { View, Text, TextInput, Button, StyleSheet, TouchableOpacity, PermissionsAndroid, Platform, Alert } from 'react-native';
import Voice from '@react-native-voice/voice';
import { Picker } from '@react-native-picker/picker';

async function requestMicPermission() {
  if (Platform.OS !== 'android') {
    return true;
  }
  try {
    const granted = await PermissionsAndroid.request(
      PermissionsAndroid.PERMISSIONS.RECORD_AUDIO,
      {
        title: 'Microphone Permission',
        message: 'This app needs access to your microphone to recognize speech.',
        buttonPositive: 'OK',
      }
    );
    return granted === PermissionsAndroid.RESULTS.GRANTED;
  } catch (err) {
    console.warn(err);
    return false;
  }
}

const VoicePage = ({ navigation }) => {
  const [language, setLanguage] = useState("en");
  const [text, setText] = useState("");
  const [output, setOutput] = useState("Original text will appear here...");
  const [translation, setTranslation] = useState("English translation will appear here...");

  const langMap = {
    en: "en-US",
    hi: "hi-IN",
    ta: "ta-IN",
    te: "te-IN",
    kn: "kn-IN",
    ml: "ml-IN",
    mr: "mr-IN",
    gu: "gu-IN",
    pa: "pa-IN",
    bn: "bn-IN",
    or: "or-IN",
    as: "as-IN",
    ur: "ur-IN",
  };

  const translateText = async (inputText, lang) => {
    try {
      const response = await fetch("http://127.0.0.1:4000/api/translate", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ text: inputText, lang: lang }),
      });
      const data = await response.json();
      if (data.translatedText) {
        setTranslation(data.translatedText);
      } else {
        setTranslation("Error: " + data.error);
      }
    } catch (err) {
      setTranslation("Error: " + err.message);
    }
  };

  useEffect(() => {
    Voice.onSpeechStart = () => setOutput("Speech started...");
    Voice.onSpeechEnd = () => setOutput("Speech ended.");
    Voice.onSpeechResults = (event) => {
      if (event.value && event.value.length > 0) {
        const spokenText = event.value[0];
        setOutput(spokenText);
        setText(spokenText);
        translateText(spokenText, language);
      }
    };
    Voice.onSpeechError = (error) => {
      setOutput("Error: " + JSON.stringify(error));
    };

    return () => {
      Voice.destroy().then(() => {
        Voice.removeAllListeners();
      });
    };
  }, [language, translateText]);

  const startListening = async () => {
    try {
      const hasPermission = await requestMicPermission();
      if (hasPermission) {
        setOutput("Listening...");
        setTranslation("Translating...");
        await Voice.start(langMap[language] || "en-US");
      } else {
        Alert.alert("Permission Denied", "Microphone access is required to use speech recognition.");
      }
    } catch (e) {
      setOutput("Error: " + e.message);
    }
  };

  const handleTranslate = () => {
    if (text.trim()) {
      setOutput(text);
      translateText(text, language);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Multilingual Speech & Text to English</Text>

      <Text>Select your language:</Text>
      <Picker
        selectedValue={language}
        style={styles.picker}
        onValueChange={(itemValue) => setLanguage(itemValue)}
      >
        <Picker.Item label="English" value="en" />
        <Picker.Item label="Hindi" value="hi" />
        <Picker.Item label="Tamil" value="ta" />
        <Picker.Item label="Telugu" value="te" />
        <Picker.Item label="Kannada" value="kn" />
        <Picker.Item label="Malayalam" value="ml" />
        <Picker.Item label="Marathi" value="mr" />
        <Picker.Item label="Gujarati" value="gu" />
        <Picker.Item label="Punjabi" value="pa" />
        <Picker.Item label="Bengali" value="bn" />
        <Picker.Item label="Odia" value="or" />
        <Picker.Item label="Assamese" value="as" />
        <Picker.Item label="Urdu" value="ur" />
      </Picker>

      <TouchableOpacity style={styles.speakBtn} onPress={startListening}>
        <Text style={styles.btnText}>🎤 Speak Now</Text>
      </TouchableOpacity>

      <TextInput
        style={styles.textInput}
        placeholder="Or type your text here..."
        value={text}
        onChangeText={setText}
        multiline
      />

      <Button title="Translate Text" onPress={handleTranslate} />

      <Text style={styles.box}>{output}</Text>
      <Text style={styles.box}>{translation}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    alignItems: "center",
    justifyContent: "flex-start",
  },
  title: {
    fontSize: 20,
    marginBottom: 20,
    fontWeight: "bold",
  },
  picker: {
    height: 50,
    width: "80%",
  },
  speakBtn: {
    backgroundColor: "#007bff",
    padding: 12,
    borderRadius: 10,
    marginVertical: 10,
  },
  btnText: {
    color: "#fff",
    fontSize: 16,
  },
  textInput: {
    width: "90%",
    borderColor: "#ccc",
    borderWidth: 1,
    borderRadius: 8,
    padding: 10,
    marginVertical: 10,
    minHeight: 60,
    textAlignVertical: "top",
  },
  box: {
    width: "90%",
    borderColor: "#ccc",
    borderWidth: 1,
    borderRadius: 8,
    padding: 10,
    marginVertical: 10,
    fontSize: 16,
  },
});

export default VoicePage;