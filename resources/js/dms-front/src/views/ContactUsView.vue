<template>
  <MainLayout></MainLayout>
  <div class="container">
    <h1>This is a contact-us page</h1>
  </div>
</template>

<script>
import MainLayout from '../components/MainLayout.vue';
export default {
    data() {
        return {
            app_name: 'DMS'
        };
    },
    components: { MainLayout }
}
</script>
