import React, {useEffect, useState} from 'react';
import {SafeAreaView, StyleSheet, Text, View} from 'react-native';
import {launchCamera, launchImageLibrary} from 'react-native-image-picker';
import Button from '../components/Button';
import {perH} from '../constants';
const OPTIONS = {mediaType: 'video'};
export default function VideoEncoder() {
  const [firstVideoUri, setFirstVideoUri] = useState('');
  const [secondVideoUri, setSecondVideoUri] = useState('');
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
});
