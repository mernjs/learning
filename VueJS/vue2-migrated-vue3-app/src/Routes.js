import { createRouter, createWebHistory } from 'vue-router';

const routes = [
	{
		path: '/',
		alias: '/todos',
		name: 'todos',
		component: () => import('./pages/TodosList.vue'),
	},
	{
		path: '/todos/:id',
		name: 'todo-details',
		component: () => import('./pages/UpdateTodo.vue'),
	},
	{
		path: '/add',
		name: 'add',
		component: () => import('./pages/AddTodo.vue'),
	},
];

const router = createRouter({
	history: createWebHistory(),
	routes,
});

export default router;
