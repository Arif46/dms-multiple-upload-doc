<template>
    <div>
     <MainLayout></MainLayout>
     <div class="container">
        <b-card class="mt-3">
            <b-card-title>
                <b-row>
                    <b-col>
                        <h4 class="card-title mb-0 pl-0">User List</h4>
                    </b-col>
                    <b-col class="text-left">
                        <b-button size="sm" variant="info" @click="addUserForm()" style="margin-left: 541px;"><i class="ri-add-fill"></i>Add User</b-button>
                    </b-col>
                </b-row>
            </b-card-title>
            <b-row>
                <b-col>
                    <b-overlay :show="loading">
                    <table class="table table-striped table-hover table-bordered">
                        <thead>
                        <tr>
                            <!-- <th class="text-center">
                                <b-form-checkbox
                                    style="display: table-cell"
                                    name="checked"
                                    v-model="selectAll"
                                    @change="checkAll"
                                    :value=true
                                    :unchecked-value=false
                                >
                                </b-form-checkbox>
                            </th> -->
                            <th class="text-center">Sl</th>
                            <th class="text-center">Name</th>
                            <th class="text-center">Email</th>
                            <th class="text-center">Phone</th>
                            <th class="text-center">Action</th>
                        </tr>
                        </thead>
                            <tbody v-if="users.length">
                                <tr v-for="(user, index) in users" :key="index">
                                    <!-- <td>
                                        <b-form-checkbox
                                            name="checked"
                                            v-model="user.is_checked"
                                            @change="check()"
                                            :value=true
                                            :unchecked-value=false
                                        >
                                        </b-form-checkbox>
                                    </td> -->
                                    <td class="text-center">{{ index+1 }}</td>
                                    <td class="text-left">{{ user.name }}</td>
                                    <td>{{ user.email }}</td>
                                    <td>{{ user.phone }}</td>
                                    <td class="text-center">
                                        <b-button class="btn btn-sm btn-success" @click="editData(user)">Edit</b-button>&nbsp;
                                        <b-button class="btn btn-sm btn-danger" @click="deleteConfirmation(user)">Delete</b-button>
                                    </td>
                                    </tr>
                                </tbody>
                        </table>
                            <b-button v-if="showAllDeleteButton" @click="deleteAllChecked" class="btn btn-danger" style="margin-left:1120px">
                                Delete Selected
                            </b-button>
                    </b-overlay>
                </b-col>
            </b-row>
        </b-card>
        <b-modal v-model="show" size="lg" :hide-footer=true title="Add New User">
            <AddUser v-if="show" :editItem="editItem" @closeModal="close_modal()"  @loadData="user_list()"/>
        </b-modal>
        </div>
    </div>
  </template>


  <script>
//   import axios from 'axios';
  import MainLayout from '../components/MainLayout.vue';
  import AddUser from '../components/modalComponents/addUser.vue';

  export default {
        data() {
          return {
              app_name: 'DMS',
              users: [],
              show: false,
              editItem: '',
              loading: false,
              selectAll: false,
              isDisabled: true,
              showAllDeleteButton: false
          };
        },
        components: {
            MainLayout,
            AddUser
        },
        created(){
            this.axios_setup();
        },
        mounted(){
            this.user_list();
        },
        methods:{
            user_list:async function(){
                this.loading = true
                let url = this.apiUrl('api/v1/auth/ajax/user_list');

                try {
                    let res = await this.axios.get(url);
                    this.users = res.data.data.list;
                    this.loading = false
                } catch (error) {

                }
            },
            checkAll () {
                this.showAllDeleteButton = this.selectAll;
                if (this.selectAll) {
                    this.users.forEach(element => {
                        element.is_checked = true
                    })
                } else {
                    this.users.forEach(element => {
                        element.is_checked = false
                    })
                }
                const trueItem = this.users.find(item => item.is_checked === true)
                if (trueItem) {
                    this.isDisabled = false
                } else {
                    this.isDisabled = true
                }
            },
            check () {
                this.showAllDeleteButton = this.users.some(user => user.is_checked)
                const userObj = this.users.filter(item => item.is_checked === true)
                if (userObj.length === 0) {
                    this.isDisabled = true
                } else if (userObj.length > 0) {
                    this.isDisabled = false
                }
                const trainerObj = this.users.find(item => item.is_checked === false)
                if (trainerObj === undefined) {
                    this.selectAll = true
                } else {
                    this.selectAll = false
                }
            },
            deleteConfirmation (item) {
                this.$swal({
                    title: 'Are you sure to delete?',
                    showCancelButton: true,
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                    focusConfirm: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.deleteUser(item)
                    }
                })
            },
            async deleteUser (item) {
                let url = this.apiUrl('/api/v1/auth/ajax/user_delete')
                var result = await this.axios.post(url, item)
                this.$swal({
                   toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000,

                    icon: 'success',
                    title: 'Success',
                    text: 'Delete Successfully!',
                });
                this.user_list()
            },
            deleteAllChecked () {
                this.$swal({
                    title: 'Are you sure to delete?',
                    showCancelButton: true,
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                    focusConfirm: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.deleteAllTestChecked()
                    }
                })
            },
            async deleteAllTestChecked () {
                const selectedIds = this.users.filter(user => user.is_checked).map(user => user.id);
                // console.log('selectedIds', selectedIds)
                let url = this.apiUrl('/api/v1/auth/ajax/all_user_delete')
                var result = await this.axios.post(url, selectedIds)
                this.$swal({
                   toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000,

                    icon: 'success',
                    title: 'Success',
                    text: 'Delete Successfully!',
                });

                this.user_list()
            },
            addUserForm(){
                this.editItem = null;
                this.show = true;
            },
            close_modal(){
                this.show = false;
            },
            editData(item){
                this.editItem = item
                this.show = true;
            }
        }
  }
  </script>
