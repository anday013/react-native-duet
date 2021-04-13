import React from 'react';
import {
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import {perH} from '../constants';

export default function Examples({navigation}) {
  return (
    <ScrollView contentContainerStyle={styles.homeContainer}>
      <TouchableOpacity
        style={styles.listItem}
        onPress={() => navigation.navigate('VideoEncoder')}>
        <Text style={styles.listText}>Video Encoding 🎦</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  homeContainer: {
    flex: 1,
    paddingVertical: perH(2),
  },
  listItem: {
    // flex: 1,
    padding: 20,
    backgroundColor: '#3d405b',
    justifyContent: 'center',
    // alignItems: 'center',
    marginBottom: 10,
  },
  listText: {
    fontSize: 18,
    color: 'white',
    fontWeight: 'bold',
  },
});
