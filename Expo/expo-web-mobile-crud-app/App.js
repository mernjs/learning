import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { enableScreens } from 'react-native-screens';
import {
	BrowserRouter as Router,
	Routes,
	Route,
} from 'react-router-dom';
import CreateScreen from './src/components/Create';
import ReadScreen from './src/components/Read';
import UpdateScreen from './src/components/Update';
import DetailsScreen from './src/components/Details';
import { Platform } from 'react-native';

enableScreens();

const Stack = createStackNavigator();

function App() {
  return (
    <NavigationContainer>
      {Platform.OS === 'web' ? (
      <Router>
        <Routes>
          <Route path="/add" element={<CreateScreen/>} />
          <Route path="/update/:id" element={<UpdateScreen/>} />
          <Route path="/view/details/:id" element={<DetailsScreen/>} />
          <Route path="/" element={<ReadScreen/>} />
        </Routes>
      </Router>
       ) : (
        <Stack.Navigator>
          <Stack.Screen name="Home" component={ReadScreen} />
          <Stack.Screen name="Add" component={CreateScreen} />
          <Stack.Screen name="Update" component={UpdateScreen} />
          <Stack.Screen name="Details" component={DetailsScreen} />
        </Stack.Navigator>
      )}
    </NavigationContainer>
  );
}

export default App;
