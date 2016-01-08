<%--
  Document    : index
  Author  : Narmada Balasooriya
--%>

<%@page import="ActiveDirectory.Authentication"%>
<%@page import="DbConnect.dbConnection"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head> 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <title>IFS</title>
    <script src="js/jquery-1.11.3.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/sweetalert.min.js"></script>

    <link rel="stylesheet" href="css/bootstrap-theme.min.css" type="text/css">
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/sweetalert.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">

  </head>
  <body style="background-image: url('images/concrete_seamless.png')" onload="document.getElementById('loginButton').click();">
    <nav class = "navbar navbar-default" >
      <div class="container-fluid" style="background-color:#863D8D; box-shadow: 0px 10px 10px #724867">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="http://www.ifsworld.com/en/"><img src="images/IFS-Logo.png" alt="Mountain View" style="width:50px;height:50px;"></a>
        </div>
      </div>
    </nav>
    <div class="container-fluid">
      <div class="col-md-4" style="padding-top: 200px">
      </div> 
      <div class="col-md-4">
        <div class="col-md-4"></div>
        <div class="col-md-4" style="min-height: 180px">
          <div class="col-md-8 col-md-pull-10">
            <img src="images/user1.png" style="height:150px; width:150px; padding-top: 10px" alt="Mountain View">
          </div>
          <div class="col-md-8 col-md-pull-4 ">
              <%    String IpAddress =  request.getRemoteAddr();
                    InetAddress address = InetAddress.getByName(IpAddress); 
                    String username = address.getHostName();
                    String [] name = username.split("\\d");
                    username = name[0];
                    username = username.toLowerCase();
                    
                    
                    
              
              %>
              <p class="row" style="text-align: left; font-size: 30px"><%= username%></p>
          </div>
          <div class="col-md-7 col-md-push-2" >

                    <ul class="nav navbar-nav  navbar-right">
                        <form id="loginForm" class="navbar-form navbar-left" method="POST" role="search" action="LoginServlet">
                           
                            <button type="submit" class="btn btn-default" id ="loginButton" onclick="pop()">CONTINUE</button>
                        </form>
                    </ul>
                </div>
        </div>
        <div class="col-md-4">
        </div>
      
      </div>
      <div class="col-md-4">
        
      </div>
    </div>
          <script>
            function pop()
            {
               
               setTimeout(1500);

            }
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
                        $('#exnums').append("<label class='text' style='color:#863D8D'>" + val + "</label><br>");
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

  </body>
</html>
