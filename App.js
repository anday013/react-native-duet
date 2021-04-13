import * as React from 'react';
import {View, Text} from 'react-native';
import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';
import Index from './src/screens/Home';
import Examples from './src/screens/Examples';
import VideoEncoder from './src/screens/VideoEncoder';

const Stack = createStackNavigator();

function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerStyle: {
            backgroundColor: '#3f37c9',
          },
          headerTintColor: '#fff',
          headerTitleAlign: 'center',
        }}>
        <Stack.Screen
          name="ThesisProject"
          component={Index}
          options={{headerTitle: 'Thesis Project'}}
        />
        <Stack.Screen name="Examples" component={Examples} />
        <Stack.Screen
          name="VideoEncoder"
          component={VideoEncoder}
          options={{headerTitle: 'Video Encoder'}}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default App;
