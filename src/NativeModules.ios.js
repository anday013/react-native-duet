import {NativeModules} from 'react-native';

export const duetVideos = (
  first,
  second,
  orientation = 'H',
  reverse = false,
  isMuted = false,
  callback,
) =>
  NativeModules.RNDuetModule.duetFunction(
    first,
    second,
    orientation,
    reverse,
    isMuted,
    callback,
  );
