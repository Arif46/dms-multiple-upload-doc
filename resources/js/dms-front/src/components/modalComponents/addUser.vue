<template>
    <div>
      <b-form @submit="onSubmit()" @reset="onReset">
        <span v-if="msg" class="text-danger">{{ msg }}</span>

        <input type="hidden" v-model="form.id">

        <b-form-group id="input-group-2" label="Your Name:" label-for="input-2">
            <b-form-input
            id="input-2"
            v-model="form.name"
            placeholder="Enter name"
            
            ></b-form-input>
        </b-form-group>

        <b-form-group
          id="input-group-1"
          label="Email address:"
          label-for="input-1"
          description="We'll never share your email with anyone else."
        >
            <b-form-input
            id="input-1"
            v-model="form.email"
            type="email"
            placeholder="Enter email"
            
            ></b-form-input>
        </b-form-group>

        <b-form-group id="input-group-2" label="Your Phone:" label-for="input-2">
            <b-form-input
            id="input-2"
            v-model="form.phone"
            placeholder="Enter Phone"
            
            ></b-form-input>
        </b-form-group>

          <!-- <div class="row mt-3">
          <div class="col-sm-3"></div>
          <div class="col text-right">
              <b-button type="submit" variant="primary" class="mr-2">Submit</b-button>
              &nbsp;
              <b-button variant="danger" class="mr-1">Reset</b-button>
          </div>
        </div> -->
  
        <b-button type="submit" variant="primary">Submit</b-button>
        &nbsp;
        <b-button type="reset" variant="danger">Reset</b-button>
      </b-form>
    </div>
</template>

<script>
import axios from 'axios';
export default {
    props: ['editItem'],
    
    data() {
      return {
        form: {
          email: '',
          name: '',
          phone: null,
          id: null
        },
        show: true,
        msg: null
      }
    },
    created(){
      this.axios_setup();
    },
    mounted(){
      if (this.editItem) {
        this.form = this.editItem
      }
    },
    methods: {
      onSubmit:async function(){

          // console.log(this.form);

          let url = this.apiUrl('/api/v1/auth/ajax/create-user');
          let form = {
            id: this.form.id,
            email: this.form.email,
            name:  this.form.name,
            phone:  this.form.phone
          };
          
          try {
              this.msg = null;
              let res = await this.axios.post(url, form);

              this.$swal({
              toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,

                icon: 'success',
                title: 'Success',
                text: 'Saved Successfully!',
              });
              this.$emit('closeModal', true);
              this.$emit('loadData', true)
              
              // this.show = true;
              // this.$bvModal.hide('modal-1')
              // this.$nextTick(() => {
              //   this.$bvModal.hide('modal-1')
              // })

          } catch (error) {

              this.msg = error.response.data.msg;
          }

      },
      onReset(event) {
        event.preventDefault()
        this.form.email = ''
        this.form.name = ''
        this.form.phone = ''
        this.show = false
        this.$nextTick(() => {
          this.show = true
        })
      }
    }
  }
</script>