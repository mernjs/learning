import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

const Routes = new Router({
	mode: "history",
	routes: [
		{
			path: "/",
			alias: "/todos",
			name: "todos",
			component: () => import("./pages/TodosList")
		},
		{
			path: "/todos/:id",
			name: "todo-details",
			component: () => import("./pages/UpdateTodo")
		},
		{
			path: "/add",
			name: "add",
			component: () => import("./pages/AddTodo")
		}
	]
});

export default Routes