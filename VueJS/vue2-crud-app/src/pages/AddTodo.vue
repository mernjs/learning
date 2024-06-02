<template>
    <div class="submit-form">
        <h4>Add Todo</h4><br>
        <div v-if="!submitted">
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" class="form-control" id="title" required v-model="todo.title" name="title" />
            </div><br>
            <button @click="saveTodo" class="btn btn-success">Submit</button>
        </div>

        <div v-else>
            <h4>You submitted successfully!</h4>
            <button class="btn btn-success" @click="newTodo">Add</button>
        </div>
    </div>
</template>

<script>
import TodosDataService from "../services/TodosDataService";

export default {
    name: "add-todo",
    data() {
        return {
            todo: {
                id: null,
                title: ""
            },
            submitted: false
        };
    },
    methods: {
        saveTodo() {
            const data = {
                title: this.todo.title
            };

            TodosDataService.create(data)
                .then(response => {
                    this.todo.id = response.data.id;
                    console.log(response.data);
                    this.submitted = true;
                })
                .catch(e => {
                    console.log(e);
                });
        },

        newTodo() {
            this.submitted = false;
            this.todo = {};
        }
    }
};
</script>

<style>
.submit-form {
    max-width: 300px;
    margin: auto;
}
</style>
