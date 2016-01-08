


<%--
    Document   : profile
    Created on : Nov 3, 2015, 4:30:38 PM
    Author     : pvpelk, narblk, umchlk
--%>

<%@page import="ActiveDirectory.Authentication"%>
<%@page import="DbConnect.dbConnection"%>
<%@page import="java.net.InetAddress"%>
<%@page import="Model.User"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>IFS</title>

        <script type="text/javascript" src="js/jquery-1.11.3.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/sweetalert.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
         <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


        <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="css/sweetalert.css">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">


        <style type="text/css">
         html,body{height : 100%;}
        .container{
            min-height: 100%;
            overflow: hidden;
            border-style: ridge;
            border-color: #863D8D;
        }
        .navbar {
            width: 100%;
        }

         #collapseAddnew.width {
            height: auto;
            -webkit-transition: width 0.35s ease;
            -moz-transition: width 0.35s ease;
            -o-transition: width 0.35s ease;
            transition: width 0.35s ease;
 }

        </style>




    </head>
    <body >

        <div  class="container" style="background-image: url('images/gplaypattern.png'); ">
            <div class="row">
            <nav class="navbar navbar-default" style="">
            <div class="container-fluid" style=" background-color: #863D8D; box-shadow: 0px 10px 10px #724867">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>

                    <a href="http://www.ifsworld.com/en/"><img src="images/IFS-Logo.png" alt="Mountain View" style="width:50px;height:50px;"></a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                        <ul class="nav navbar-nav navbar-right">
                        <p class="row" style="text-align: right; font-size:18px; padding-top: 10px; padding-right: 20px; color: white"><%=request.getAttribute("username")%></p>
                        <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                    </ul>



                </div>
            </div>

        </nav>
         </div>

        <div class="container-fluid">
            <div class="col-md-6">
                <form class="navbar-form navbar-left pull-left" method="POST" role="search" action="LoginServlet">
                    <div class="form-group input-group" style="width: 500px">
                        <input type="text" id="ename" class="form-control" name="EMname" placeholder="search employee by name">
                        <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-search"></i></span>
                    </div>
                </form>


                <div id="exnums" style="padding-left: 20px; padding-top: 50px">

                </div>



            </div>

            <div class="col-md-6" style="padding-top:35px">
                <div class="col-md-1"></div>
                <div class="col-md-10 " style="min-height: 180px">
                    <div class="col-md-6">
                        <img src="images/user1.png" style="height:150px; width: 150px" alt="Mountain View">
                    </div>
                    <div class="col-md-6 col-md-push-1">
                    <p class="row" style="text-align: left; font-size: 30px"><%=request.getAttribute("fullname")%></p>

                    </div>
                </div>

                  <div class="col-md-2"></div>
                <div class="col-md-8 ">
                    <%
                        ArrayList<String> list = (ArrayList<String>) request.getAttribute("exNum");
                        int count = 1;
                        int editCount =1;
                        for (String lines : list) {%>
                    <div class="col-md-5" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <div style="color: #863D8D; font-size:16px">
                                <img src="images/phone3.png" alt="Mountain View" style="width:30px;height:30px;">  <b><input type="text" id="<%=lines%>" onkeyup="myFunction('<%=lines%>')" value="<%=lines%>" style="border:transparent ;border-style:solid; background-color: transparent; width: 50px;"  ></b>

                            </div>

                        </div>
                    </div>

                    <div class="col-md-2" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <b>
                                <form role="search" method="POST" action="ProfileDelete" >
                                    <div class="collapse">
                                        <input type="hidden" class="form-control" name="myusername" value="<%=request.getAttribute("myusername")%>">
                                        <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                        <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                        <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                                        <input type="hidden" class="form-control" name="extension" value="<%=lines%>">
                                    </div>
                                    <a href="#" data-toggle="tooltip" title="Delete">
                                        <input id="del" class="btn btn-default" role="button" type="image"  src="images/delete2.png" value="Delete" style="width:45px;height:35px;" onclick="return confirm('Are you sure to delete this')" /></a>
                                </form>
                            </b>
                        </div>
                    </div>

                    <div class="col-md-5" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <b>
                                <form id="<%=count%>" role="search" method="POST" action="ProfileEdit">
                                    <a href="#" data-toggle="tooltip" title="Edit">
                                    <input id="edit" class="btn btn-default" role="button" type="image"  src="images/edit2.png" value="Edit" style="width:45px;height:35px;" onclick="editNum('<%=lines%>','s<%=editCount%>','s<%=count%>')" />
                                    </a>
                                        <input type="hidden" class="form-control" name="myusername" value="<%=request.getAttribute("myusername")%>">
                                        <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                        <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                        <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                                        <input id="s<%=editCount%>" type="hidden" class="form-control" name="Nextension" >
                                        <input type="hidden" class="form-control" name="extension" value="<%=lines%>">


                                </form>
                            </b>
                        </div>
                    </div>


                    <% count++;
                    editCount++;
                        }
                    %>
                    <div class="col-md-12" style="min-height: 80px; display: inline; white-space: nowrap;">
                        <form id="formAdd" role="search" method="POST" action="NewExtensionServlet">                
                            <a class="btn btn-default" id="adding" role="button" data-toggle-me="tooltip" title="add extension" onclick="show('collapseAddnew')" >
                                <img id="add" src="images/add2.png" alt="Mountain View" style="width:20px;height:20px; " >
                            </a> 
                            <div class="collapse in width" id="collapseAddnew"  style="padding-left: 10px; display: inline-block; visibility:collapse; white-space: nowrap; vertical-align: middle" >
                                <img src="images/phone3.png" alt="Mountain View" style="width:40px;height:30px; padding-right: 10px"><input id="textboxA" type="text" class="form-control" name="extension" style="padding-left: 10px; width: 40%; display: inline-block; white-space: nowrap;" placeholder="Ext Number">
                                <div style="padding-left: 10px; display: inline-block; white-space: nowrap;">
                                    <a class="btn btn-default" id="cancel" role="button" data-toggle-me="tooltip" title="Cancel" onclick="cancel()"/>
                                    <img id="canceling" src="images/delete2.png" alt="Mountain View" style="width:20px;height:20px;">
                                    </a>
                                    <a class="btn btn-default" role="button" onclick="valid3('textboxA', 'formAdd')" class="btn btn-default" id = "addButton"  data-toggle-me="tooltip" title="Add New">
                                    <img id="addingVal" src="images/edit2.png"  alt="Mountain View" style="width:20px;height:20px;">
                                    </a>
                                    </div>
                                <input type="hidden" class="form-control" name="myusername" value="<%=request.getAttribute("myusername")%>">
                                <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                            
                            </div>
                        </form>

                    </div>
                    
                               
                    <div class="col-md-6">
                            <form id="formNew" method="POST" role="search" action="AddNewEmployee">
                            <a class="btn btn-default" role="button" data-toggle-me="tooltip" title="add new user"  data-toggle="collapse" href="#collapseAddnewUser" aria-expanded="false" >
                                <img id="pen" src="images/member.png" alt="Mountain View" style="width:20px;height:20px;">
                            </a>
                            <div class="collapse" style="padding-top: 10px" id="collapseAddnewUser">
                                <div style="display: inline; white-space: nowrap;">
                                <div style="padding-bottom: 10px; display: inline-block; white-space: nowrap;"><input id="uname" type="text" class="form-control" name="newusername" placeholder="Username"><input id="fname" type="hidden" class="form-control" name="newfname"></div>
                                <div style="height: 20px; width: 200px; display: inline-block; white-space: nowrap;" id="myDiv"></div>
                                </div>
                                <div style="padding-bottom: 10px"><input id="ext" type="text" class="form-control" name="newextension" placeholder="Extension"></div>
                                <button type="button" onclick="validM('ext', 'formNew')" value="Edit" class="btn btn-primary" disabled="true" id="addEmp">Add new User</button>
                                <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">

                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>

        </div>

    <script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});
</script>

 <script>
$(document).ready(function(){
    $('[data-toggleme="tooltip"]').tooltip();
});
</script>







        <script>
            $('#ename').keyup(function () {

                var text = $('#ename').val();
                var data1 = {'text': text};
                $.ajax({
                    type: 'POST',
                    data: data1,
                    url: 'EmplyeeServlet',
                    success: function (data) {
                        $('#exnums').empty();
                        $.each(data['names'], function (key, val) {
                            console.log(val);
                            var name = val.toString();
                            $('#exnums').append("<form id='viewMember' role='search' method='POST' action='ProfileView'>\n\
                            <a href='/TelephoneDirectory/ProfileView?member="+val+"&admin=<%=request.getAttribute("username")%>'><b>" + val + "</b></a>\n\
                                                        </form><br>");
                        });
                    }
                });
            });
        </script>

       <script>
            $('#uname').keyup(function (){
                var text = $('#uname').val();
                var data1 = {'text': text};
                $.ajax({
                    type: 'POST',
                    data: data1,
                    url: "NewEmployee",
                    success: function (data) {
                        $('#myDiv').empty();
                        $.each(data['fullname'], function (key, val) {
                            console.log(val);
                            if(val === "old"){
                                $('#myDiv').append("<label class='text' style='color:#863D8D'>Already has that username</label><br>");
                            }else if(val === null){
                                $('#myDiv').append("<label class='text' style='color:#863D8D'>No such employee</label><br>");
                            }else{
                                $('#myDiv').append("<label class='text' style='color:#863D8D'>" + val + "</label><br>");
                                $('#addEmp').removeAttr('disabled');
                                $('#fname').val(val);
                            }
                        });
                    }
                });
            });
        </script>




         <script>
            $('#textboxA').keyup(function () {
               var text = $('#textboxA').val() ;
               if(!text.isInteger()){
                   $('#textboxA').empty();
               }
            });
        </script>

        <script>
            var funCall=0;
            
            var editCount = 1;
            function show(textBox){
               
                if(editCount%2 === 1){
                   document.getElementById(textBox).style.visibility='visible';
                   
                }else{
                    document.getElementById(textBox).style.visibility='hidden'; 
                }
                 editCount++;
                 
            }
                function cancel(){
                document.getElementById("collapseAddnew").style.visibility='hidden';
                editCount = 1;
            }
            
            function testBtn(){
                document.getElementById("collapseAddnew").style.visibility='visible';
            }

            function myFunction (textBoxA){

                if(funCall%2 === 0){
                    funCall ++;
                }
                var inputVal = document.getElementById(textBoxA);
                inputVal.style.borderColor = "red";


            }


            function test(){
                alert("hi");

                document.getElementById("myDiv").style.visibility =visible;
            }





            function valid3(textBox, formN)
            {
                var textVal = document.getElementById(textBox).value;
                if (!textVal.match(/\S/))
                {
                    swal("Field is blank !!!", "Please Input a Valid Extension Number !!!", "warning");
                    return false;
                }

                else if (!(/\d/.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }

                else if ((/[a-z]/i.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }

                else if ((/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }
                else if (!("4" === (textVal.length).toString()))

                {
                    swal("Incorrect Input length !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }else{


                        document.getElementById(textBox).value = textVal;
                        document.getElementById(formN).submit();
                        return true;
                    }

                }

function editNum(textBox,textBoxB, formN)
            {
                var textVal = document.getElementById(textBox).value;

               if(funCall%2 === 0){

                   document.getElementById(textBox).select();
                   document.getElementById(textBox).focus();
                   funCall++;
                   event.preventDefault();

               }else{



                if (!textVal.match(/\S/))
                {
                    swal("Field is blank !!!", "Please Input a Valid Extension Number !!!", "warning");
                    return false;
                }

                else if (!(/\d/.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }

                else if ((/[a-z]/i.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }

                else if ((/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }
                else if (!("4" === (textVal.length).toString()))

                {
                    swal("Incorrect Input length !!!", "Please Input a Valid Extension Number!!!", "warning");
                     document.getElementById(textBox).value = "";
                    return false;
                }else{


                        document.getElementById(textBoxB).value = textVal;
                        document.getElementById(formN).submit();
                        return true;
                    }

                }

            }






function validM( ext, formN)
            {

                var textVal = document.getElementById(ext).value;
                if (!textVal.match(/\S/))
                {
                    swal("Field is blank!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }

                else if (!(/\d/.test(textVal)))
                {
                    swal("Incorrect Input!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }

                else if ((/[a-z]/i.test(textVal)))
                {
                    swal("Incorrect Input!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }

                else if ((/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(textVal)))
                {
                    swal("Incorrect Input!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }
                else if (!("4" === (textVal.length).toString()))

                {
                    swal("Incorrect Input length!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }else{
                     document.getElementById(formN).submit();
                        return true;

                }

            }








function validM( ext, formN)
            {

                var textVal = document.getElementById(ext).value;
                if (!textVal.match(/\S/))
                {
                    swal("Field is blank!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }

                else if (!(/\d/.test(textVal)))
                {
                    swal("Incorrect Input!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }

                else if ((/[a-z]/i.test(textVal)))
                {
                    swal("Incorrect Input!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }

                else if ((/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(textVal)))
                {
                    swal("Incorrect Input!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }
                else if (!("4" === (textVal.length).toString()))

                {
                    swal("Incorrect Input length!", "Please Input a Valid Extension Number!!!", "warning");
                    return false;
                }else{
                     document.getElementById(formN).submit();
                        return true;

                }

            }



        </script>



    </body>
</html>
