<%-- 
    Document   : profile
    Created on : Nov 3, 2015, 4:30:38 PM
    Author     : pvpelk, narblk, umchlk
--%>

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

        <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="css/sweetalert.css">
        
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
        
        </style> 

    </head>
    <body style="background-image: url('images/gplaypattern.png')">

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

                    
                    
                     <form id="loginForm" class="navbar-form navbar-right pull-right" method="POST" role="search" action="LoginServlet">
                            <button type="submit" class="btn btn-default"><%=request.getAttribute("username")%></button>
                            <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                        </form>
                </div>
            </div>
                        </div>
        </nav>
        
        
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
                        int editCount = 1;
                        for (String lines : list) {%>
                    <div class="col-md-5" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                           <div style="color: #863D8D; font-size:16px">
                               <img src="images/phone3.png" alt="Mountain View" style="width:30px;height:30px;">  <b><input type="text" id="<%=lines%>" onkeyup="myFunction('<%=lines%>')" value="<%=lines%>" style="border:transparent ;border-style:solid; background-color: transparent; width: 50px;" readonly=""></b>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <b>
                                <form role="search" method="POST" action="ProfileDelete" >
                                    <div class="collapse">
                                        <input type="hidden" class="form-control" name="myusername" value="<%=request.getAttribute("myusername")%>">
                                        <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                        <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                        <input type="hidden" class="form-control" name="extension" value="<%=lines%>">
                                        <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                                    </div>
                                    <input id="del" class="btn btn-default" role="button" type="image"  src="images/delete2.png" value="Delete" style="width:45px;height:35px;" onclick="return confirm('Are you sure to delete this')"/>                
                                </form>
                            </b>
                        </div>
                    </div>
                    <div class="col-md-5" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <b>
                                <form id="<%=count%>" role="search" method="POST" action="ProfileEdit">

                                    <input id="edit" class="btn btn-default" role="button" type="image"  src="images/edit2.png" value="Edit" style="width:45px;height:35px;" onclick="editNum('<%=lines%>','s<%=count%>','s<%=editCount%>')"/>

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
                    
                    
                    
                    
                    

                 
                    
                    <div class="col-md-6" style="min-height: 80px">
                        <form id="formAdd" role="search" method="POST" action="NewExtensionServlet">
                            <a class="btn btn-default" role="button" data-toggle="collapse" href="#collapseAddnew" aria-expanded="false" aria-controls="collapseExample">
                                <img id="add" src="images/add2.png" alt="Mountain View" style="width:20px;height:20px;">
                            </a>
                            <div class="collapse" style="padding-top: 10px" id="collapseAddnew">
                                <input type="hidden" class="form-control" name="myusername" value="<%=request.getAttribute("myusername")%>">
                                <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                                <input id="textboxA" type="text" class="form-control" name="extension" style="width: 50%" placeholder="Ext Number">
                                <div style="padding-top: 10px"><button type="button" style="width: 50%" onclick="valid3('textboxA', 'formAdd')" value="ADD NEW" class="btn btn-warning" id = "addButton">Add</button></div>
                            </div>                    
                        </form>
                        
                    </div>
                    
                    <div class="col-md-2">
                       
                    </div>
                </div>
            </div>
        </div>
                                
      
        </div>
        
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
                            $('#exnums').append("<form id='viewMember' role='search' method='POST' action='ProfileView'>\n\
                            <a href='/TelephoneDirectory/ProfileView?member="+val+"&admin=<%=request.getAttribute("username")%>'><b>" + val + "</b></a>\n\
                                                        </form><br>"); 
                        });
                    }
                });
            });
        </script>
       
        
        
        <script>
            $('#ename2').keyup(function () {

                var text = $('#ename2').val();
                var data1 = {'text': text};
                $.ajax({
                    type: 'POST',
                    data: data1,
                    url: 'EmplyeeServlet',
                    success: function (data) {
                        $('#exnums2').empty();
                        $.each(data['names'], function (key, val) {
                            console.log(val);
                            $('#exnums2').append("<option id='selectedUser'>" + val + "</option>");
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
           
                $("#cancelBtn").click(function(){
                    $(".edit").hide();
                });
           
        </script>
        
        
        <script>
            
            var funCall=0;
            function myFunction (textBoxA){


                var inputVal = document.getElementById(textBoxA);
                inputVal.style.borderColor = "red";


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




            
            function valid(textBox, formN)
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
                }

                else if ((/[a-z]/i.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                }

                else if ((/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Extension Number!!!", "warning");
                }
                else if (!("4" === (textVal.length).toString()))

                {
                    swal("Incorrect Input length !!!", "Please Input a Valid Extension Number!!!", "warning");
                }
                else
                {
                    if(confirm("Do you want to change the extension ?")){
                        document.getElementById(formN).submit();
                        return true;
                    }else{
                        return false;
                    }
                   
                }

            }

            function valid2(textBox, formN)
            {
                var textVal = document.getElementById(textBox).value;
                if (!textVal.match(/\S/))
                {
                    swal("Field is blank !!!", "Please Input a Valid Username!!!", "warning");
                    return false;
                }

                else if (/\d/.test(textVal))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Username!!!", "warning");
                }

                else if ((/[~`!#$%\^&*+=\-\[\]\\';,/{}|\\":<>\?]/g.test(textVal)))
                {
                    swal("Incorrect Input !!!", "Please Input a Valid Username!!!", "warning");
                }

                else
                {
                    swal("Correct Input !!!", "", "success");
                    setTimeout(function () {
                        document.getElementById(formN).submit();
                        return true;
                    }, 1500);
                }
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
               
                        document.getElementById(formN).submit();
                        return true;
                    }
                   
                }
                
                
              
            



        </script>
       
        





    </body>
</html>
