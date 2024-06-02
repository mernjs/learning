<template>
    <div v-if="currentTodo" class="edit-form">
        <h4>Update Todo</h4><br>
        <form>
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" class="form-control" id="title" v-model="currentTodo.title" />
            </div>
        </form>

        <br>
        <button class="btn btn-danger" @click="deleteTodo">
            Delete
        </button> &nbsp;&nbsp;

        <button type="submit" class="btn btn-success" @click="updateTodo">
            Update
        </button>
        <p>{{ message }}</p>
    </div>

    <div v-else>
        <br />
        <p>Loading...</p>
    </div>
</template>

<script>
import TodosDataService from "../services/TodosDataService";

export default {
    name: "todo",
    data() {
        return {
            currentTodo: null,
            message: ''
        };
    },
    methods: {
        getTodo(id) {
            TodosDataService.get(id)
                .then(response => {
                    this.currentTodo = response.data;
                    console.log(response.data);
                })
                .catch(e => {
                    console.log(e);
                });
        },

        updateTodo() {
            TodosDataService.update(this.currentTodo.id, this.currentTodo)
                .then(response => {
                    console.log(response.data);
                    this.message = 'The todo was updated successfully!';
                    setTimeout(() => {
                        this.$router.push({ name: "todos" });
                    }, 1000);
                })
                .catch(e => {
                    console.log(e);
                });
        },

        deleteTodo() {
            TodosDataService.delete(this.currentTodo.id)
                .then(response => {
                    console.log(response.data);
                    this.$router.push({ name: "todos" });
                })
                .catch(e => {
                    console.log(e);
                });
        }
    },
    mounted() {
        this.message = '';
        this.getTodo(this.$route.params.id);
    }
};
</script>

<style>
.edit-form {
    max-width: 300px;
    margin: auto;
}
</style>
