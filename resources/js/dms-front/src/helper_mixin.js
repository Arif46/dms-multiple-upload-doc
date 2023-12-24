import axios from 'axios';
import moment from 'moment'
export default{
    data(){
        return {
            axios: null,
            moment: ''
        }
    },
    methods:{
        apiUrl:function(uri){
            // return "https://dms-back.studypress.org/"+uri.replace(/^\/|\/$/g, '');
            // return "http://doc_management.test/"+uri.replace(/^\/|\/$/g, '');
            return "http://document-management.local/"+uri.replace(/^\/|\/$/g, '');
        },
        axios_setup: function () {
            var ref = this;
            var api_token = null;
            
            if(localStorage.getItem('token_name')){
            	api_token=localStorage.getItem('token_name');
            }

            var headers = {
                Accept: "application/json",
                Authorization: "Bearer " + api_token,
                "Access-Control-Allow-Origin": "*",
                'Content-Type': 'multipart/form-data'
            };

            ref.axios = axios.create({
                headers: headers
            })
        },
        clone_object: function (value) {
            return Object.assign({}, value)
        },
        dDate: function (value, format = 'D MMM YYYY') {
            return moment.utc(value).local().format(format)
        }
    }
}