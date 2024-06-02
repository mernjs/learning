// mockApi.js
const data = [
    { id: 1, name: 'Item 1', description: 'Description 1' },
    { id: 2, name: 'Item 2', description: 'Description 2' },
    { id: 3, name: 'Item 3', description: 'Description 3' },
  ];
  
  export const fetchItems = () => {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(data);
      }, 1000);
    });
  };
  
  export const createItem = (item) => {
    return new Promise((resolve) => {
      setTimeout(() => {
        const newItem = { id: data.length + 1, ...item };
        data.push(newItem);
        resolve(newItem);
      }, 1000);
    });
  };
  
  export const updateItem = (id, updatedItem) => {
    return new Promise((resolve) => {
      setTimeout(() => {
        const index = data.findIndex((item) => item.id === id);
        if (index !== -1) {
          data[index] = { ...data[index], ...updatedItem };
          resolve(data[index]);
        } else {
          resolve(null);
        }
      }, 1000);
    });
  };
  
  export const deleteItem = (id) => {
    return new Promise((resolve) => {
      setTimeout(() => {
        const index = data.findIndex((item) => item.id === id);
        if (index !== -1) {
          data.splice(index, 1);
          resolve(true);
        } else {
          resolve(false);
        }
      }, 1000);
    });
  };
  