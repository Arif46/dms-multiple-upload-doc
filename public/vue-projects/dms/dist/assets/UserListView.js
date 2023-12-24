import{_ as v,r as a,o as d,c as m,f as l,g as i,t as h,d as w,w as U,v as V,b as s,h as p,M as C,F as k,i as S,j as D}from"./index.js";const B={props:["editItem"],data(){return{form:{email:"",name:"",phone:null,id:null},show:!0,msg:null}},created(){this.axios_setup()},mounted(){this.editItem&&(this.form=this.editItem)},methods:{onSubmit:async function(){let n=this.apiUrl("/api/v1/auth/ajax/create-user"),e={id:this.form.id,email:this.form.email,name:this.form.name,phone:this.form.phone};try{this.msg=null;let f=await this.axios.post(n,e);this.$swal({toast:!0,position:"top-end",showConfirmButton:!1,timer:3e3,icon:"success",title:"Success",text:"Saved Successfully!"}),this.$emit("closeModal",!0),this.$emit("loadData",!0)}catch(f){this.msg=f.response.data.msg}},onReset(n){n.preventDefault(),this.form.email="",this.form.name="",this.form.phone="",this.show=!1,this.$nextTick(()=>{this.show=!0})}}},I={key:0,class:"text-danger"};function M(n,e,f,x,o,r){const c=a("b-form-input"),u=a("b-form-group"),_=a("b-button"),b=a("b-form");return d(),m("div",null,[l(b,{onSubmit:e[4]||(e[4]=t=>r.onSubmit()),onReset:r.onReset},{default:i(()=>[o.msg?(d(),m("span",I,h(o.msg),1)):w("",!0),U(s("input",{type:"hidden","onUpdate:modelValue":e[0]||(e[0]=t=>o.form.id=t)},null,512),[[V,o.form.id]]),l(u,{id:"input-group-2",label:"Your Name:","label-for":"input-2"},{default:i(()=>[l(c,{id:"input-2",modelValue:o.form.name,"onUpdate:modelValue":e[1]||(e[1]=t=>o.form.name=t),placeholder:"Enter name"},null,8,["modelValue"])]),_:1}),l(u,{id:"input-group-1",label:"Email address:","label-for":"input-1",description:"We'll never share your email with anyone else."},{default:i(()=>[l(c,{id:"input-1",modelValue:o.form.email,"onUpdate:modelValue":e[2]||(e[2]=t=>o.form.email=t),type:"email",placeholder:"Enter email"},null,8,["modelValue"])]),_:1}),l(u,{id:"input-group-2",label:"Your Phone:","label-for":"input-2"},{default:i(()=>[l(c,{id:"input-2",modelValue:o.form.phone,"onUpdate:modelValue":e[3]||(e[3]=t=>o.form.phone=t),placeholder:"Enter Phone"},null,8,["modelValue"])]),_:1}),l(_,{type:"submit",variant:"primary"},{default:i(()=>[p("Submit")]),_:1}),l(_,{type:"reset",variant:"danger"},{default:i(()=>[p("Reset")]),_:1})]),_:1},8,["onReset"])])}const N=v(B,[["render",M]]),A={data(){return{app_name:"DMS",users:[],show:!1,editItem:""}},components:{MainLayout:C,AddUser:N},created(){this.axios_setup()},mounted(){this.user_list()},methods:{user_list:async function(){let n=this.apiUrl("api/v1/auth/ajax/user_list");try{let e=await this.axios.get(n);this.users=e.data.data.list}catch{}},deleteConfirmation(n){this.$swal({title:"Are you sure to delete?",showCancelButton:!0,confirmButtonText:"Yes",cancelButtonText:"No",focusConfirm:!1}).then(e=>{e.isConfirmed&&this.deleteUser(n)})},async deleteUser(n){let e=this.apiUrl("/api/v1/auth/ajax/user_delete");await this.axios.post(e,n),this.$swal({toast:!0,position:"top-end",showConfirmButton:!1,timer:3e3,icon:"success",title:"Success",text:"Delete Successfully!"}),this.user_list()},addUserForm(){this.editItem=null,this.show=!0},close_modal(){this.show=!1},editData(n){this.editItem=n,this.show=!0}}},E={class:"container"},L={class:"row",style:{"margin-top":"25px"}},R=s("div",{class:"col-md-10"},[s("h2",null,"User List")],-1),T={class:"col-md-2"},j={class:"table table-striped"},F=s("thead",null,[s("tr",null,[s("th",null,"Sl"),s("th",{class:"text-left"},"Name"),s("th",null,"Email"),s("th",null,"Phone"),s("th",null,"Action")])],-1),P={key:0},Y={class:"text-left"};function z(n,e,f,x,o,r){const c=a("MainLayout"),u=a("b-button"),_=a("AddUser"),b=a("b-modal");return d(),m("div",null,[l(c),s("div",E,[s("div",L,[R,s("div",T,[l(u,{class:"btn btn-success",onClick:e[0]||(e[0]=t=>r.addUserForm())},{default:i(()=>[p("Add User")]),_:1})])]),s("table",j,[F,o.users.length?(d(),m("tbody",P,[(d(!0),m(k,null,S(o.users,(t,y)=>(d(),m("tr",null,[s("td",null,h(y+1),1),s("td",Y,h(t.name),1),s("td",null,h(t.email),1),s("td",null,h(t.phone),1),s("td",null,[l(u,{class:"btn btn-sm btn-success",onClick:g=>r.editData(t)},{default:i(()=>[p("Edit")]),_:2},1032,["onClick"]),l(u,{class:"btn btn-sm btn-danger",onClick:g=>r.deleteConfirmation(t)},{default:i(()=>[p("Delete")]),_:2},1032,["onClick"])])]))),256))])):w("",!0)])]),l(b,{modelValue:o.show,"onUpdate:modelValue":e[3]||(e[3]=t=>o.show=t),size:"lg","hide-footer":!0,title:"Add New User"},{default:i(()=>[o.show?(d(),D(_,{key:0,editItem:o.editItem,onCloseModal:e[1]||(e[1]=t=>r.close_modal()),onLoadData:e[2]||(e[2]=t=>r.user_list())},null,8,["editItem"])):w("",!0)]),_:1},8,["modelValue"])])}const q=v(A,[["render",z]]);export{q as default};