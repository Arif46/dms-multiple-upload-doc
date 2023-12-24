<template>
    <b-container fluid class="px-0">
        <b-row align-v="center" no-gutters>
            <b-col md="8" class="d-none d-md-block">
                <!-- <div class="login-bg"></div> -->
            </b-col>
            <b-col sm="12" md="4" class="bg-light">
                <div class="login-wrapper">
                    <b-card>
                        <!-- <h6 class="text-center mt-2 mb-4">Sign In</h6> -->
                        <h3 class="text-center">Sign In</h3>
                        <div v-if="msg" class="text-danger">{{ msg }}</div><br>
                        <b-col lg="12" md="12" sm="12" xs="12">
                            <label>Email Address</label>
                            <input type="email"
                            v-model="email"
                            placeholder="Enter Email"
                            class="form-control form-control-lg"
                            />
                        </b-col>
                        <b-col lg="12" md="12" sm="12" xs="12">
                            <label>Password</label>
                            <input type="password"
                                v-model="password"
                            placeholder="Enter Password"
                            class="form-control form-control-lg" />
                        </b-col>
                        <!-- <button @click="login" class="btn btn-dark btn-lg btn-block">Sign In</button> -->
                        <b-button block @click="login" class="my-4 text-center" variant="primary">Sign In</b-button>
                    </b-card>
                </div>
            </b-col>
        </b-row>
    </b-container>
</template>
<script>
    import axios from 'axios';
    export default {
        data() {
            return {
                email: '',
                password: '',
                msg: null
            }
        },
        created () {
            var apiToken = localStorage.getItem('token_name')

            if (apiToken) {
            this.$router.replace('/folders')
            // this.$router.replace('/dashboard')
            }
        },
        methods:{
            login:async function(){

                let url = this.apiUrl('/api/v1/auth/email-login');
                let form = {
                email: this.email,
                password:  this.password
                };

                try {
                    let res = await axios.post(url, form);

                    localStorage.setItem("token_name", res.data.data.token);
                    localStorage.setItem("user_id", res.data.data.user.id);
                    localStorage.setItem("parent_id", 0);
                    localStorage.setItem("bread_crumbs_name", []);
                    localStorage.setItem("bread_crumbs_id", []);
                    this.$router.push('/folders');

                } catch (error) {

                    // console.log(error.response);
                    this.msg = error.response.data.msg;
                }

            }
        }
    }
</script>
<style scoped>
    body{
        background-color: antiquewhite;
    }
    .login-wrapper{
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .login-wrapper .card {
         width: 25em;
    }
    .login-bg{
        width: 100%;
        height: 100vh;
        /* background: linear-gradient(to bottom, rgb(50 50 50 / 35%), rgb(50 50 50 / 35%)),url(../../assets/images/login-bg.jpg); */
        background-position: center;
        background-size: cover;
    }
</style>
