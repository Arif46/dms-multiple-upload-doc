<template>
  <div>
    <MainLayout></MainLayout>
    <div class="container">
      <h1>This is an about page</h1>
    </div>
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

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
