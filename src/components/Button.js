import React from 'react';
import {StyleSheet, Text, TouchableOpacity, View} from 'react-native';

export default function Button({title, textStyle, style, disabled, ...props}) {
  return (
    <TouchableOpacity
      style={[styles.container, style, {opacity: disabled ? 0.5 : 1}]}
      disabled={disabled}
      {...props}>
      <Text style={[styles.text, textStyle]}>{title}</Text>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#3f37c9',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 10,
  },
  text: {
    color: '#fff',
    padding: 15,
    fontSize: 15,
    fontWeight: 'bold',
  },
});
