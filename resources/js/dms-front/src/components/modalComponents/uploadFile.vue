<template>
    <b-card>
       <b-row>
            <b-col sm="12" md="8" class="bg-light" offset="2">
                <b-form @submit="onSubmit()" @reset="onReset">
                    <span v-if="msg" class="text-danger">{{ msg }}</span>

                    <b-form-group id="input-group-2" label="File Name:" label-for="input-2">
                        <b-form-input
                        id="input-2"
                        v-model="form.name"
                        placeholder="Enter File Name"
                        :disabled="form.files.length > 1"
                        ></b-form-input>
                    </b-form-group>

                    <input type="file" multiple @change="uploadFile" class="form-control">
                    <!-- Display a list of selected files -->
                    <div v-if="form.files.length > 0" class="mt-3">
                        <div v-for="(file, index) in form.files" :key="index" class="file-box">
                            <span>{{ file.name }}</span>
                            <button @click="removeFile(index)">Remove</button>
                        </div>
                    </div>
                    <b-button type="submit" variant="primary" style="margin-top: 10px;">Create</b-button>
                    <!-- <b-button type="submit" variant="danger" style="margin-top: 10px;">Cancel</b-button> -->
                </b-form>
            </b-col>
        </b-row> 
    </b-card>
</template>

<script>
    export default {
        props: ['parent_id'],
        data() {
            return {
                app_name: 'DMS',
                form: {
                    name: '',
                    files: [],
                },
                show: true,
                msg: null
            };
        },
        created(){
            this.axios_setup();
        },
        mounted(){
            // alert(this.parent_id);
        },
        methods:{
            uploadFile: function (event) {
                this.form.files.push(...(event.target.files)); // Add selected files to form.files array
                if (this.form.files.length > 1) {
                    this.form.name = ''
                }
            },
            removeFile(index) {
                this.form.files.splice(index, 1); // Remove file at specified index
            },
            // uploadFile: function (event) {
            //     this.form.files = event.target.files
            // }, 
            onSubmit:async function(){

                let url = this.apiUrl('/api/v1/auth/ajax/upload_file');
     
                const formData = new FormData()
                formData.append('name', this.form.name)
                formData.append('parent_id', this.parent_id)
                // formData.append('file', this.form.file)
                 // Append each selected file to the formData
                for (let index = 0; index < this.form.files.length; index++) {
                    //console.log('this.form.files[index]', this.form.files[index])
                    if (this.form.name) {
                        formData.append('files[]', this.form.files[index], this.form.name + '.' + this.form.files[index].name.split('.')[1]);
                    } else {
                        formData.append('files[]', this.form.files[index]);
                    }
                }

                try {
                    this.msg = null; 

                    if(this.form.files.length === null){
                        this.msg = "File required";
                    }else{
                       
                        let res = await this.axios.post(url, formData);

                        this.$swal({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,

                            icon: 'success',
                            title: 'Success',
                            text: 'Saved Successfully!',
                        });

                        this.$emit('closeFileModal', true);
                        this.$emit('fileFolderList', true);
                    }
                        

                } catch (error) {

                    this.msg = error.response.data.msg;
                }

            }
        }
    }
</script>
<style scoped>
.file-box {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}
.file-box span {
  margin-right: 10px;
}
</style>