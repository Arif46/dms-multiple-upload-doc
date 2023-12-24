<template>
    <div>
      <b-form @submit="onSubmit()" @reset="onReset">
        <span v-if="msg" class="text-danger">{{ msg }}</span>

        <!-- <input type="hidden" v-model="form.id"> -->

        <b-form-group id="input-group-2" label="Folder Name:" label-for="input-2">
            <b-form-input
            id="input-2"
            v-model="form.name"
            placeholder="Enter Folder Name"
            
            ></b-form-input>
        </b-form-group>
        <!-- <span v-if="errorMsg">{{ errorMsg }}</span> -->
        <b-button type="submit" variant="primary">Create</b-button>
      </b-form>
    </div>
</template>

<script>
    export default {
        props: ['parent_id'],
        data() {
            return {
                app_name: 'DMS',
                form: {
                    name: '',
                    parent_id: 0,
                    level_id: 0,
                    type: 'Folder',
                    url: null,
                    status: 1
                },
                show: true,
                msg: null,
                errorMsg: []
            };
        },
        created(){
            this.axios_setup();
        },
        mounted(){
            // alert(this.parent_id);
        },
        methods: {
            onSubmit:async function(){

            // console.log(this.form);

            let url = this.apiUrl('/api/v1/auth/ajax/create_folder');
            let form = {
                name: this.form.name,
                parent_id: this.parent_id,
                level_id:  this.form.level_id,
                type:  this.form.type,
                url:  this.form.url,
                status:  this.form.status
            };
            
            try {
                this.msg = null;
                var res = await this.axios.post(url, form);
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
                this.$emit('fileFolderList', true);

            } catch (error) {
                this.msg = error.response.data.msg;
            }

            }
        }
    }
</script>