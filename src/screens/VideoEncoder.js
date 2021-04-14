import React, {useEffect, useState} from 'react';
import {
  ActivityIndicator,
  Alert,
  SafeAreaView,
  StyleSheet,
  View,
} from 'react-native';
import {launchImageLibrary} from 'react-native-image-picker';
import Video from 'react-native-video';
import Button from '../components/Button';
import {IOS, perH, perW} from '../constants';
import {duetVideos as duetVideosIOS} from '../NativeModules.ios';

const OPTIONS = {mediaType: 'video'};
export default function VideoEncoder() {
  const [firstVideoUri, setFirstVideoUri] = useState('');
  const [secondVideoUri, setSecondVideoUri] = useState('');
  const [resultVideoUri, setResultVideoUri] = useState('');
  const [loading, setLoading] = useState(false);

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.buttonsWrapper}>
        <Button
          title="Choose First Video"
          style={styles.button1}
          onPress={() =>
            launchImageLibrary(OPTIONS, res => setFirstVideoUri(res.uri))
          }
        />
        <Button
          title="Choose Second Video"
          style={styles.button2}
          onPress={() =>
            launchImageLibrary(OPTIONS, res => setSecondVideoUri(res.uri))
          }
        />
      </View>
      <View style={styles.buttonsWrapper}>
        {firstVideoUri ? (
          <Video
            source={{uri: firstVideoUri}}
            style={styles.video}
            muted
            resizeMode="stretch"
            repeat
          />
        ) : (
          <View style={[styles.video, styles.button1]} />
        )}
        {secondVideoUri ? (
          <Video
            source={{uri: secondVideoUri}}
            style={styles.video}
            muted
            resizeMode="stretch"
            repeat
          />
        ) : (
          <View style={[styles.video, styles.button2]} />
        )}
      </View>

      {resultVideoUri ? (
        <Video
          source={{uri: resultVideoUri}}
          style={styles.resultVideo}
          muted
          resizeMode="stretch"
          repeat
        />
      ) : (
        <View style={styles.resultVideo}>
          {loading ? <ActivityIndicator size="large" color="#000" /> : null}
        </View>
      )}

      <Button
        title="Merge Videos"
        style={styles.button}
        disabled={!firstVideoUri && !secondVideoUri}
        onPress={() => {
          if (IOS) {
            setLoading(true);
            duetVideosIOS(
              firstVideoUri,
              secondVideoUri,
              'H',
              false,
              false,
              uri => {
                setResultVideoUri(uri);
                setLoading(false);
              },
            );
          } else {
            Alert.alert('For now only available on IOS');
          }
        }}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginVertical: perH(2),
  },
  buttonsWrapper: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  button1: {
    backgroundColor: '#d90429',
  },
  button2: {
    backgroundColor: '#fb8500',
  },
  video: {
    marginTop: perH(3),
    width: perW(42),
    height: perW(42),
  },
  resultVideo: {
    width: perW(90),
    height: perW(80),
    alignSelf: 'center',
    backgroundColor: 'green',
    marginTop: 'auto',
    justifyContent: 'center',
    alignItems: 'center',
  },
  button: {
    width: perW(85),
    marginBottom: 10,
    alignSelf: 'center',
    marginTop: 'auto',
  },
});
