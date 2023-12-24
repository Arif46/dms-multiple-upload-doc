<template>
  <div>
    <MainLayout></MainLayout>
    <div class="container">
      <h1>
        <b-button class="btn btn-success" @click="createFolder()">
          Create Folder
        </b-button>
        <b-button class="btn btn-success" @click="uploadFile()" style="margin-left: 10px;">
          Upload File
        </b-button>
        <!-- <b-button class="btn btn-warning" @click="clearPath()">Clear</b-button> -->
         <b-button class="iconDesign" @click="gridChange()" variant="outline-success"><img src="../assets/grid.png" alt="File Image"  width="16"/> Grid</b-button>
         <b-button variant="outline-info" @click="listChange()"><img src="../assets/List.png" alt="File Image"  width="16"/>List</b-button>
      </h1>
      <!-- <FolderList :folderData="folderData" @fileFolderList="file_folder_list()"/> -->
      <div v-if="buttonGridValue === true">
          <!-- <h1>
              This Is Folder Lists
          </h1> -->
          <br/>
          <!-- <pre>{{ breadCrumbs }}</pre> -->
          <b-breadcrumb v-if="this.breadCrumbs">
              <b-breadcrumb-item to="/folders">
                  <b-icon icon="house-fill" scale="1.25" shift-v="1.25" aria-hidden="true"></b-icon>
                  Home
              </b-breadcrumb-item>
              <b-breadcrumb-item href="javascript:" v-for="(item, index) in this.breadCrumbs">
                <router-link
                  :to="{
                    name: 'folders',
                    params: {
                        parent_id: item.id
                    }
                  }">
                  <span>{{item.name}}</span>
                  </router-link>
              </b-breadcrumb-item>
          </b-breadcrumb>
         <!--Folder Data-->
          <div class="rounded p-3 border" style="background-color: #f1f1f1; min-height: 400px;">
            <div class="row">
              <template v-if="(folderData != null && folderData.length > 0)">
                <div class="col-md-2" v-for="val in folderData">
                  <a href="" @contextmenu.prevent.stop="handleClickFolder($event, val)">
                      <router-link
                      :to="{
                      name: 'folders',
                      params: {
                          parent_id: val.id
                      }
                      }">
                      <div class="text-center my-3">
                        <div :title="'Creator Name: '+ val.user_info.user.name + '\n ' + 'Date Created: ' + dDate(val.user_info.user.created_at)">
                          <!-- <div class="rounded bg-light text-center p-2 border border-info"> -->
                          <div>
                            <font-awesome-icon icon="fa-solid fa-user-secret" />
                              <span>
                                <img src="../assets/folder.png" alt="Folder Image"  width="70"/>
                                <br>
                                <!-- {{ val.name }} -->
                                <span v-if="!val.editMode" @click="enableEditMode(val)">
                                    {{ val.name }}
                                </span>
                                <span v-else>
                                  <input
                                    type="text"
                                    v-model="val.name"
                                    @keyup.enter="renameFolder(val)"
                                  />
                                </span>
                              </span>
                            </div>
                        </div>
                      </div>
                    </router-link>
                  </a>
                </div>
                <vue-simple-context-menu
                  element-id="myUniqueId_1"
                  :options="ContentMenuFolderOptions"
                  ref="vueSimpleContextMenuFolder"
                  @option-clicked="optionClickedFolder"
                />
              </template>
              <template v-else-if="(fileData != null && fileData.length > 0)">
              </template>
              <template v-else>
                <p class="text-center">This folder is empty</p>
              </template>
            </div>
            <!-- File Grid Data-->
            <div class="row mt-3">
              <div class="col-md-2" v-for="file in fileData" @contextmenu.prevent.stop="handleClick($event, file)">
                <!-- {{ file.url }} -->
                <!-- download_media -->
                <!-- <b-overlay :show="loading"> -->
                  <!-- <a :href="apiUrl('download-media')+'/'+ file.id" download="download"> -->
                    <!-- <span > -->
                      <!-- {{ file.id }} -->
                      <div class="text-center my-3">
                        <div :title="'Creator Name: '+ file.user_name + '\n ' + 'Date Created: ' + dDate(file.data_created)">
                          <!-- <div class="rounded bg-light text-center p-2 border border-info"> -->
                          <div>
                            <img src="../assets/file.png" alt="File Image"  width="60"/>
                            <br>
                            <span v-if="!file.editModeFile" @click="enableEditModeFile(file)">
                              {{ truncateFileName(file.original_name) }}
                            </span>
                            <span v-else>
                              <input
                                type="text"
                                v-model="file.original_name"
                                v-on:keyup.enter="renameFile(file)"
                              />
                            </span>
                          </div>
                        </div>
                      </div>
                  <!-- </a> -->
                  <!-- </b-overlay> -->
              </div>
              <vue-simple-context-menu
                element-id="myUniqueId_2"
                :options="ContentMenuOptions"
                ref="vueSimpleContextMenu"
                @option-clicked="optionClicked"
              />
            </div>
          </div>
      </div>
      <!--List show Button-->
      <div v-if="buttonListValue === true" class="mt-3">
        <b-breadcrumb v-if="this.breadCrumbs">
          <b-breadcrumb-item to="/folders">
              <b-icon icon="house-fill" scale="1.25" shift-v="1.25" aria-hidden="true"></b-icon>
              Home
          </b-breadcrumb-item>
          <b-breadcrumb-item href="javascript:" v-for="(item, index) in this.breadCrumbs">
            <router-link
              :to="{
                name: 'folders',
                params: {
                    parent_id: item.id
                }
              }">
              <span>{{ item.name }}</span>
            </router-link>
          </b-breadcrumb-item>
        </b-breadcrumb>
        <table class="table table-hover">
          <thead>
            <tr style="font-size: 16px; font-weight: 100; font-family: 'Courier New', Courier, monospace; color: cornflowerblue;">
              <th>Sl</th>
              <th class="text-left">Name</th>
              <th>Date Modified</th>
              <th>Type</th>
              <th>Created By</th>
            </tr>
          </thead>
          <template v-if="Object.keys(folderData).length > 0">
            <tbody v-for="(item, index) in folderData" :key="index" @contextmenu.prevent.stop="handleClickFolder($event, item)">
              <tr style="font-size: 14px; font-weight: 100; font-family:'Times New Roman', Times, serif">
                <td>{{ index + 1 }}</td>
                <td class="text-left" :title="'Creator Name: '+ item.user_info.user.name + '\n ' + 'Date Created: ' + dDate(item.user_info.user.created_at)"> <img src="../assets/folder.png" alt="Folder Image"  width="30"/>&nbsp;
                  <router-link :to="`/folders/${item.id}`">
                    <span v-if="!item.editMode" @click="enableEditMode(item)">
                      {{ item.name }}
                    </span>
                    <span v-else>
                      <input
                        type="text"
                        v-model="item.name"
                        @keyup.enter="renameFolder(item)"
                      />
                    </span>
                  </router-link>
                </td>
                <td>{{ dDate(item.user_info.user.updated_at) }}</td>
                <td v-if="item.name">Folder</td>
                <td v-if="item.user_info.user">{{ item.user_info.user.name }}</td>
              </tr>
            </tbody>
            <vue-simple-context-menu
                element-id="myUniqueId_3"
                :options="ContentMenuFolderOptions"
                ref="vueSimpleContextMenuFolder"
                @option-clicked="optionClickedFolder"
            />
          </template>
          <template v-else-if="fileData.length > 0">
          </template>
          <template v-else>
            <tr>
              <td colspan="5" class="text-center">This folder is empty</td>
            </tr>
          </template>
            <tbody v-for="(file, index) in fileData" :key="index" @contextmenu.prevent.stop="handleClickListFile($event, file)">
              <tr style="font-size: 14px; font-weight: 100; font-family:'Times New Roman', Times, serif">
                <td>{{ index + 1 }}</td>
                <!-- <a :href="apiUrl('download-media')+'/'+file.id" download="download"> -->
                  <td class="text-left" :title="'Creator Name: '+ file.user_name + '\n ' + 'Date Created: ' + dDate(file.data_created)"> <img src="../assets/file.png" alt="File Image"  width="30"/>&nbsp;
                    <!-- <span v-if="file.name">{{ file.name }}</span> -->
                    <span v-if="!file.editModeFile" @click="enableEditModeFile(file)">
                      {{ file.original_name }}
                    </span>
                    <span v-else>
                      <input
                        type="text"
                        v-model="file.original_name"
                        v-on:keyup.enter="renameFile(file)"
                      />
                      </span>
                  </td>
                <!-- </a> -->
                <td>{{ dDate(file.data_created) }}</td>
                <td v-if="file.original_name">File {{ file.extension }}</td>
                <td v-if="file.user_name">{{ file.user_name }}</td>
              </tr>
            </tbody>
            <vue-simple-context-menu
              element-id="myUniqueId_4"
              :options="ContentMenuOptions"
              ref="vueSimpleContextMenuFileList"
              @option-clicked="optionClickedListFile"
            />
        </table>
      </div>
    </div>
      <b-modal v-model="modal_show" size="sm" :hide-footer=true title="Add New Folder">
        <AddFolder :parent_id="parent_id" v-if="modal_show" @closeModal="close_modal()" @fileFolderList="file_folder_list()"/>
      </b-modal>
      <b-modal v-model="file_modal_show" size="lg" :hide-footer=true title="Upload File">
        <UploadFile :parent_id="parent_id" v-if="file_modal_show" @closeFileModal="close_file_modal()" @fileFolderList="file_folder_list()"/>
      </b-modal>

      <!-- <div :class="imageViewerImageUrl ? 'image-viewer-open' : 'image-viewer'">
        <div style="width: 100%; position: relative; display: inline;">
          <div class="bg-danger ps-3" style="position: relative; display: inline;">
            <span class="pdfclose" @click="closeViewFile()"><img src="../assets/cross.jpg" alt="File Image" width="30"/></span>
              <iframe :src="imageViewerImageUrl" style="width: 91%; height: 90vh; background: #f2f3f5;"></iframe>
          </div>
        </div>
      </div> -->
  </div>
</template>


<script>
import MainLayout from '../components/MainLayout.vue';
import AddFolder from '../components/modalComponents/addFolder.vue';
import FolderList from '../components/FolderList.vue';
import UploadFile from '../components/modalComponents/uploadFile.vue';
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
export default {
    data() {
        return {
            app_name: 'DMS',
            modal_show: false,
            file_modal_show: false,
            folderData: null,
            fileData:null,
            parent_id: null,
            breadCrumbs: [],
            tipData: { title: 'Tooltip <em>Message</em>' },
            date: new Date(),
            timer: null,
            buttonGridValue: true,
            buttonListValue: false,
            loading: false,
            show: false,
            ContentMenuOptions: [
              { name: 'Rename' },
              { name: 'Delete' },
              { name: 'Preview' },
            ],
            ContentMenuFolderOptions: [
              { name: 'Rename' },
              { name: 'Delete' },
            ],
            renamingFile: null,
            newFileName: '',
            imageViewerImageUrl: '',
            selectedFolder: null,
            selectedFile: null
        };
    },
    components: {
      MainLayout,
      AddFolder,
      FolderList,
      UploadFile
    },
    created(){
      this.axios_setup();
      this.$router.afterEach((to, from, next) => {
          // console.log("==>",to);
          if(to.name == 'folders'){
            this.file_folder_list();
            this.bread_crumbs_list();
          }
      });
    },
    mounted(){
      // alert(localStorage.getItem("user_id"));
      this.file_folder_list();
      this.bread_crumbs_list();
      document.addEventListener('click', this.handleClickOutside);
    },
    beforeDestroy() {
      document.removeEventListener('click', this.handleClickOutside);
    },
    methods:{
        optionClicked (event) {
          if (event.option.name === 'Delete') {
            this.deleteFile(event.item)
          } else if (event.option.name === 'Preview') {
            this.viewFile(event.item)
          } else if (event.option.name === 'Rename') {
            this.enableEditModeFile(event.item)
          }
            // window.alert(JSON.stringify(event))
        },
        enableEditModeFile(file) {
          this.selectedFile = file;
          file.editModeFile = true;
        },
        async renameFile(val) {
          this.loading = true
          let url = this.apiUrl('/api/v1/auth/ajax/update_file_data')
          let form = {
            id: val.id,
            original_name: val.original_name
          };
          var result = await this.axios.post(url, form)
          this.loading = false
          if (result.success) {
            this.$swal({
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 3000,
  
              icon: 'success',
              title: 'Success',
              text: 'Update Successfully!',
            });
            this.file_folder_list();
          } else {
            // this.msg = error.response.data.msg;
          }
          // this.bread_crumbs_list();
        },
        optionClickedFolder (event) {
          if(event.option.name === 'Delete') {
            this.deleteFolder(event.item)
          } else if (event.option.name === 'Rename') {
            this.enableEditMode(event.item)
          }
        },
        // enableEditMode(folder) {
        //     folder.editMode = true;
        //     folder.newName = folder.name;
        //      // Add a click event listener to the document
        //     document.addEventListener('click', this.handleClickOutside);
        // },
        enableEditMode(folder) {
          // console.log('folder', folder)
          this.selectedFolder = folder;
          folder.editMode = true;
          // folder.name = folder.name;
        },
        async renameFolder(item) {
          let url = this.apiUrl('/api/v1/auth/ajax/update_folder_data')
          let form = {
            id: item.id,
            name: item.name
          };
          var result = await this.axios.post(url, form)
          if (result.success) {
            this.$swal({
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 3000,
  
              icon: 'success',
              title: 'Success',
              text: 'Update Successfully!',
            });
            this.file_folder_list();
          } else {
            // this.msg = error.response.data.msg;
          }
          // this.bread_crumbs_list();
        },
        // renameFolder(val) {
        //   let url = this.apiUrl('/api/v1/auth/ajax/update_folder_data');
        //   let form = {
        //       id: val.id,
        //       name: val.name
        //   };
        //   this.axios.post(url, form).then((result) => {
        //       if (result.data.success) {
        //           this.$swal({
        //               toast: true,
        //               position: 'top-end',
        //               showConfirmButton: false,
        //               timer: 3000,
        //               icon: 'success',
        //               title: 'Success',
        //               text: 'Update Successfully!',
        //           });
        //           this.file_folder_list();
        //           val.editMode = false;
        //       } else {
        //       }
        //   }).catch((error) => {
        //       console.error('Error:', error);
        //   });
        // },
        handleClickOutside(event) {
          if (
            this.selectedFolder &&
            event.target !== this.$el.querySelector('input')
          ) {
            this.cancelRename(this.selectedFolder);
          }
        },
        cancelRename(folder) {
          folder.editMode = false;
          this.selectedFolder = null;
        },
        optionClickedListFile (event) {
          if (event.option.name === 'Delete') {
            this.deleteFile(event.item)
          // const item = event.item
          // let url = this.apiUrl('/api/v1/auth/ajax/file_delete')
          //   this.axios.post(url, item)
          //   this.$swal({
          //     toast: true,
          //     position: 'top-end',
          //     showConfirmButton: false,
          //     timer: 3000,

          //     icon: 'success',
          //     title: 'Success',
          //     text: 'Delete Successfully!',
          //   });

              // this.file_folder_list();
              // this.bread_crumbs_list();

          } else if (event.option.name === 'Preview') {
            this.viewFile(event.item)
          } else if (event.option.name === 'Rename') {
            this.enableEditModeFile(event.item)
          }
        },
        handleClick (event, item) {
          // alert('file');
          this.$refs.vueSimpleContextMenu.showMenu(event, item)
        },
        handleClickListFile (event, item) {
          this.$refs.vueSimpleContextMenuFileList.showMenu(event, item)
        },
        handleClickFolder (event, item) {
          // alert('folder');
          this.$refs.vueSimpleContextMenuFolder.showMenu(event, item)
        },
        viewFile: function(item) {
            // console.log('itemViewFile', item)
            window.open(item.url)
          // this.imageViewerImageUrl = item.url
        },
        closeViewFile: function() {
            // window.open(item.url)
            this.imageViewerImageUrl = ''
        },
        async deleteFile (item) {
          let url = this.apiUrl('/api/v1/auth/ajax/file_delete')
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
          this.file_folder_list();
          this.bread_crumbs_list();
        },
        async deleteFolder (item) {
          let url = this.apiUrl('/api/v1/auth/ajax/folder_delete')
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
          this.file_folder_list();
          this.bread_crumbs_list();
        },
        truncateFileName(fileName) {
          if (fileName && fileName.length > 15) {
            return fileName.substr(0, 15) + '...';
          }
          return fileName;
        },
        gridChange() {
          this.buttonGridValue = true
          this.buttonListValue = false
        },
        listChange () {
          this.buttonGridValue = false
          this.buttonListValue = true
        },
        file_folder_list: async function(){
          if(this.$route.params.parent_id.length > 0){
            this.parent_id = this.$route.params.parent_id;
          } else {
            this.parent_id = 0;
          }
            // alert(this.parent_id);
            let url = this.apiUrl('api/v1/auth/ajax/file_folder_list');
            let form = {
                user_id: localStorage.getItem("user_id"),
                parent_id: this.parent_id
            };

            try {
                let res = await this.axios.get(url,{params:form});
                this.folderData = res.data.data.folder_list;
                this.fileData = res.data.data.file_list;

            } catch (error) {

            }
        },
        bread_crumbs_list:async function(){
            let url = this.apiUrl('api/v1/auth/ajax/bread_crumbs');
            let form = {
                id: this.parent_id
            };

            try {
                let res = await this.axios.get(url,{ params:form });
                this.breadCrumbs = res.data;

            } catch (error) {

            }
        },
        createFolder(){
            // alert('click');
            this.modal_show = true;
        },
        uploadFile(){
            // alert('click');
            this.file_modal_show = true;
        },
        close_modal(){
            this.modal_show = false;
        },
        close_file_modal(){
            this.file_modal_show = false;
        },
        clearPath(){
            // localStorage.setItem("parent_id", 0);
            this.file_folder_list();
        }
    }
}
</script>

<style class="scoped">
  a:link {
    text-decoration: none;
  }
  .iconDesign {
    margin-left: 850px;
    margin-right: 6px;
  }
  .rename-dialog {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 10px;
    border: 1px solid #ccc;
  }
  .image-viewer {
    position: fixed;
    right: 0px;
    top: -14px;
    width: 0;
    height: 100%;
    overflow: hidden;
    padding-top: 80px;
    transition: all 500ms;
  }
  .image-viewer-open {
    position: fixed;
    right: -60px;
    top: -24px;
    width: 43%;
    height: 100%;
    overflow: hidden;
    padding-top: 80px;
    transition: all 500ms;
    z-index: 999999;
  }
  .pdfclose {
    cursor: pointer;
    margin: 39px;
    display: inline;
    position: absolute;
    z-index: 999;
    background: #2e1153;
    padding: 5px 15px;
    border-top-left-radius: 15px;
    border-bottom-left-radius: 15px;
    color: #fff;
    left: -53px;
    font-size: 16px !important;
}
</style>
