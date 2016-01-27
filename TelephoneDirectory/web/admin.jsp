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

        <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" type="text/css" href="css/sweetalert.css">

    </head>
    <body style="background-image: url('images/gplaypattern.png')">


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
                    </ul>
                </div>
            </div>
        </nav>
        
        
        <div class="container-fluid">
            <div class="col-md-6">
                <form class="navbar-form navbar-left pull-left" method="POST" role="search" action="LoginServlet">
                    <div class="form-group input-group" style="width: 550px">
                        <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-search"></i></span>
                        <input type="text" id="ename" class="form-control" name="EMname" placeholder="search employee by name">
                    </div>
                </form>
                
                
                <div id="exnums" style="padding-left: 20px; padding-top: 50px">

                </div>    
                
                
                           
            </div>
            
            <div class="col-md-6" style="padding-top:35px">
                
                <div class="col-md-8 col-md-push-2" style="min-height: 180px">
                    <div class="col-md-6">
                        <img src="images/user1.png" style="height:150px; width: 150px" alt="Mountain View">
                    </div>
                    <div class="col-md-4">
                    <p class="row" style="text-align: right; font-size: 30px"><%=request.getAttribute("fullname")%></p>
                    <p class="row" style="text-align: right; font-size: 15px"><%=request.getAttribute("type")%></p>
                    </div>
                </div>

                
                <div class="col-md-11 ">
                    <%
                        ArrayList<String> list = (ArrayList<String>) request.getAttribute("exNum");
                        int count = 1;
                        for (String lines : list) {%>
                    <div class="col-md-6" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <div style="color: #863D8D; font-size:16px">
                                <img src="images/phone3.png" alt="Mountain View" style="width:30px;height:30px;">  <b><%=lines%></b>
                            </div>
                            
                        </div>
                    </div>
                            
                    <div class="col-md-2" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <b>
                                <form role="search" method="POST" action="ProfileDelete" >
                                    <div class="collapse">
                                        <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                        <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                        <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                                        <input type="hidden" class="form-control" name="extension" value="<%=lines%>">
                                    </div>
                                    <input id="del" class="btn btn-default" role="button" type="image"  src="images/delete2.png" value="Delete" style="width:45px;height:35px;" onclick="return confirm('Are you sure to delete this')"/>                
                                </form>
                            </b>
                        </div>
                    </div>
                    <div class="col-md-4" style="min-height: 80px">
                        <div style="padding-bottom: 20px">
                            <b>
                                <form id="<%=count%>" role="search" method="POST" action="ProfileEdit">
                                    <a class="btn btn-default" role="button" data-toggle="collapse" href="#collapseExample<%=count%>" aria-expanded="false" aria-controls="collapseExample">
                                        <img id="pen" src="images/edit2.png" alt="Mountain View" style="width:20px;height:20px;">
                                    </a>
                                    <div class="collapse" style="padding-top: 10px" id="collapseExample<%=count%>">                
                                        <input id="<%=lines%>" style="width: 50%" type="text" class="form-control" name="Nextension" placeholder="Ext Number">
                                        <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                        <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
                                        <input type="hidden" class="form-control" name="type" value="<%=request.getAttribute("type")%>">
                                        <input type="hidden" class="form-control" name="extension" value="<%=lines%>">
                                        <div style="padding-top: 10px"><button style="width: 50%" id="editBtn" type="button" onclick="valid('<%=lines%>', '<%=count%>')" value="Edit" class="btn btn-warning">Edit</button>
                                            
                                        </div>
                                    </div>            
                                </form>
                            </b>
                        </div>
                    </div>
                    <% count++;
                        }
                    %>
                    
                         
                    <div class="col-md-4" style="min-height: 80px">
                        <form id="formAdd" role="search" method="POST" action="NewExtensionServlet">
                            <a class="btn btn-default" role="button" data-toggle="collapse" href="#collapseAddnew" aria-expanded="false" aria-controls="collapseExample">
                                <img id="add" src="images/add2.png" alt="Mountain View" style="width:20px;height:20px;">
                            </a>
                            <div class="collapse" style="padding-top: 10px" id="collapseAddnew">
                                <input type="hidden" class="form-control" name="username" value="<%=request.getAttribute("username")%>">
                                <input type="hidden" class="form-control" name="fullname" value="<%=request.getAttribute("fullname")%>">
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
                                
       <div>
            <%
                if ("Extension using".equals(request.getAttribute("check"))) {
            %>
        <div>
        <script>
            swal("Already Using this", "Please Input again!!!", "warning");
        </script>
        </div>
        <%
            }
        %>
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
                            <a href='/TelephoneDirectory/ProfileView?member="+val+"<%=request.getAttribute("username")%>'><b>" + val + "</b></a>\n\
                                                        </form><br>"); 
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
                        return flase;
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
