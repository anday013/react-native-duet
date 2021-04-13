import {Dimensions, Platform} from 'react-native';
export const Window = {
  width: Dimensions.get('window').width,
  height: Dimensions.get('window').height,
};

export const perH = percent => (Window.height * percent) / 100;
export const perW = percent => (Window.width * percent) / 100;

export const IOS = Platform.OS === 'ios';
export const ANDROID = Platform.OS === 'android';
