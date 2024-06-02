<template>
    <div class="list row">
        <div class="col-md-6">
            <h4>Todos List</h4>
            <ul class="list-group">
                <li class="list-group-item" v-for="(tutorial, index) in todos" :key="index">
                    <span>{{ tutorial.title }}</span>
                    <router-link :to="'/todos/' + tutorial.id" class="badge badge-warning"
                        style="color: red;">Edit</router-link>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
import TodosDataService from "../services/TodosDataService";

export default {
    name: "todos-list",
    data() {
        return {
            todos: [],
        };
    },
    methods: {
        retrieveTodos() {
            TodosDataService.getAll()
                .then(response => {
                    this.todos = response.data;
                    console.log(response.data);
                })
                .catch(e => {
                    console.log(e);
                });
        }
    },
    mounted() {
        this.retrieveTodos();
    }
};
</script>

<style>
.list {
    text-align: left;
    max-width: 750px;
    margin: auto;
}
</style>
