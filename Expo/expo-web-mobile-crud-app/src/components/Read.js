import React, { useState, useEffect } from 'react';
import { View, Text, FlatList, TouchableOpacity } from 'react-native';
import { Link } from 'react-router-dom';
import { fetchItems } from '../mockApi';

function Home() {
  const [items, setItems] = useState([]);

  useEffect(() => {
    fetchItems()
      .then((data) => {
        setItems(data);
      })
      .catch((error) => {
        console.error('Error fetching data:', error);
      });
  }, []);

  return (
    <View>
      <Text>Items:</Text>
      <FlatList
        data={items}
        keyExtractor={(item) => item.id.toString()}
        renderItem={({ item }) => (
          <TouchableOpacity>
            <Link to={`/view/details/${item.id}`}>
              <Text>{item.name}</Text>
            </Link>
          </TouchableOpacity>
        )}
      />
      <Link to="/add">Add Item</Link>
    </View>
  );
}

export default Home;
