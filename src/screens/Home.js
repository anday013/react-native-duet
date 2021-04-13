import React from 'react';
import {Image, SafeAreaView, StyleSheet, Text, View} from 'react-native';
import Button from '../components/Button';
import {perH, perW, Window} from '../constants';

export default function App({navigation}) {
  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.title}>
        Functional limitations of React Native {'\n'} and how to overcome them
      </Text>
      <Image source={require('../assets/rn.png')} />
      <Button
        title="Get started"
        style={styles.button}
        onPress={() => navigation.navigate('Examples')}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    fontStyle: 'italic',
    textAlign: 'center',
    marginTop: perH(2),
  },
  button: {
    width: Window.width * 0.85,
    marginBottom: 10,
  },
});
