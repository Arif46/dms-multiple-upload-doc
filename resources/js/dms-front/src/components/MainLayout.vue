<template>
      <b-navbar class="px-5" toggleable="lg" type="dark" variant="info">
        <b-navbar-brand href="#">DMS</b-navbar-brand>

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav>
            <b-nav-item to="/folders">Home</b-nav-item>
            <!-- <router-link to="/folders">Home</router-link> -->
            <!-- <b-nav-item href="/about" >Abous Us</b-nav-item>
            <b-nav-item href="/contact-us">Contact Us</b-nav-item> -->
            
          </b-navbar-nav>

          <!-- Right aligned nav items -->
          <b-navbar-nav class="ms-auto">
            <b-nav-item-dropdown right>
              <!-- Using 'button-content' slot -->
              <template #button-content>
                <em>User</em>
              </template>
              <b-dropdown-item to="/user-list">User List</b-dropdown-item>
              <b-dropdown-item to="#">Change Password</b-dropdown-item>
              <b-dropdown-item @click="logout">Sign Out</b-dropdown-item>
            </b-nav-item-dropdown>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>
</template>

<script>
export default{
    data(){
        return {
            app_name: 'DMS'
        }
    },
    methods:{
      logout: function(){
        // alert('logout');
        localStorage.removeItem("token_name");
        this.$router.push('/');
      }
    }
}
</script>