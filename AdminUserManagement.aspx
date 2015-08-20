<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminUserManagement.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=10" /> 

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"
type = "text/javascript"></script>
 
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"
type = "text/javascript"></script>
    <link href="jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=TextBoxSearchID.ClientID %>").autocomplete({
                source: function (request, response) {
                    var DropBoxValue = $('#<%= SelectBy.ClientID %> input:checked').val();
                    $.ajax({
                        url: "AdminUserManagement.aspx/GetAdmin",
                        data: "{ 'name': '" + request.term + "', 'id': '" + DropBoxValue + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {

                                return {
                                    label: item[0]
                                }

                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });

                    $("#<%=TextBoxSearchID.ClientID %>").focus(function () {
                        $.ajax({
                            url: "AdminUserManagement.aspx/GetAdmin",
                            data: "{ 'name': '" + request.term + "', 'id': '" + DropBoxValue + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {

                                    if (DropBoxValue == 1) {
                                        if (item[0] == $("#<%=TextBoxSearchID.ClientID %>").val()) {

                                            $('#<%=TextBoxEditID.ClientID %>').val(item[0]);
                                            $('#<%=TextBoxEditName.ClientID %>').val(item[1]);
                                        }
                                    }
                                    else {
                                        if (item[0] == $("#<%=TextBoxSearchID.ClientID %>").val()) {

                                            $('#<%=TextBoxEditID.ClientID %>').val(item[1]);
                                            $('#<%=TextBoxEditName.ClientID %>').val(item[0]);
                                        }
                                    }
                                }))
                            },

                            error: function (response) {
                                alert(response.responseText);
                            },

                            failure: function (response) {
                                alert(response.responseText);
                            }
                        });
                    });
                },
                minLength: 1
            });
        });



       $(document).ready(function () {
           $("#<%=TextBoxDelete.ClientID %>").autocomplete({
               source: function (request, response) {

                   var drpVal = $('#<%= Delete_Radio.ClientID %> input:checked').val();
                   $.ajax({
                       url: "AdminUserManagement.aspx/GetAdmin",
                       data: "{ 'name': '" + request.term + "','id':'" + drpVal + "'}",
                       dataType: "json",
                       type: "POST",
                       contentType: "application/json; charset=utf-8",
                       success: function (data) {
                           response($.map(data.d, function (item) {
                               return {
                                   label: item[0]
                               }
                           }))
                       }
                   });

                   $("#<%=TextBoxDelete.ClientID %>").focus(function () {
                       $.ajax({
                           url: "AdminUserManagement.aspx/GetAdmin",
                           data: "{ 'name': '" + request.term + "','id':'" + drpVal + "'}",
                           dataType: "json",
                           type: "POST",
                           contentType: "application/json; charset=utf-8",
                           success: function (data) {
                               response($.map(data.d, function (item) {
                                   if (item[0] == $("#<%=TextBoxDelete.ClientID %>").val()) {
                                       $('#<%=Show_Detail.ClientID %>').text(item[0]).append('<br />');
                                       $('#<%=Show_Detail.ClientID %>').append(item[1]).append('<br />');
                                   }
                               }))
                           }
                       });
                   });
               },
               minLength: 1
           });
           $("#<%=TextBoxDelete.ClientID %>").focusin(function () {
               $('#<%=Show_Detail.ClientID %>').text(" ");
           });
       });

</script>


    <style type="text/css">
        #divSix
        {
            top: 979px;
            left: 201px;
            position: absolute;
            height: 298px;
            width: 897px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
                <asp:Panel runat="server" class = "divOne" style="position:absolute">

     
        <table class = "table1">

            <tr>
                <td>
                    <asp:Image ID="Image1" runat="server" ImageUrl = "a.png"/>
                </td>

                <td>
                     <h1 class = "text1">IFS EXTENSION FINDER</h1>
                </td>
            </tr>

        </table>

        
    </asp:Panel>

         <div class = "navMain">
                <div class = "nav" id = "nav" runat = "server" style="position:absolute; top: 180px; left: 110px;" >
                
                    
                   <ul>
		             <li><a href="Default.aspx">Home</a></li>

                      <li><a href="#">Administrator Management</a>
			            <ul>
				            <li><a href='AdminUserManagement.aspx?p=add'>Add Admin User</a></li>
				            <li><a href='AdminUserManagement.aspx?p=edit'>Edit Admin User</a></li>
				            <li><a href='AdminUserManagement.aspx?p=delete'>Delete Admin User</a></li>
			            </ul>
		             </li>

                      <li><a href="#">Employee Management</a>
			            <ul>
				            <li><a href='EmployeeManagement.aspx?p=add'>Add Employee</a></li>
				            <li><a href='EmployeeManagement.aspx?p=edit'>Edit Employee</a></li>
                            <li><a href='EmployeeManagement.aspx?p=delete'>Delete Employee</a></li>
				        </ul>
		            </li>
                    <li><a href="#">Extension Management</a> 
                         <ul> 
                             <li><a href='ExtensionManagement.aspx'>Add Extension</a></li> 
                         </ul> 
                    </li>
		        </ul>

                </div>
             </div>

               
                    <asp:Panel ID="AdminRegister" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt"
style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;"
BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px">

<asp:Label ID="IDLabel" runat="server"
style="height: 19px; top: 102px; left: 292px; position: absolute; width: 75px"
Text="Admin ID" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"></asp:Label>

<asp:Label ID="NameLabel" runat="server" ForeColor="#873E8D"
style="height: 19px; top: 160px; left: 291px; position: absolute; width: 92px"
Text="Admin Name"></asp:Label>

<asp:TextBox ID="TextBoxID" runat="server" ForeColor="Black"
style="height: 24px; top: 100px; left: 392px; position: absolute; width: 180px" ></asp:TextBox>

<asp:TextBox ID="TextBoxName" runat="server" ForeColor="Black"
style="height: 24px; top: 158px; left: 393px; position: absolute; width: 180px"
Width="200px"></asp:TextBox>

<asp:Button ID="ButtonRegister" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" ForeColor="White"
style="height: 26px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 215px; left: 455px; position: absolute; width: 84px"
Text="Register" onclick="Register_Admin" />

<asp:RequiredFieldValidator ID="IDValidator" runat="server"
ControlToValidate="TextBoxID" ErrorMessage="Admin ID is Required"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#E53527"
style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 102px; left: 623px; position: absolute; width: 157px"></asp:RequiredFieldValidator>

<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"

ControlToValidate="TextBoxName" ErrorMessage="Name is Required"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#E53527"
style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 161px; left: 624px; position: absolute; width: 157px"></asp:RequiredFieldValidator>
</asp:Panel>

<asp:Panel ID="EditPanel" runat="server"
style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;"
BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px">

<%--<asp:Button ID="ButtonSearch" runat="server" BackColor="#A878AE"

BorderColor="#873E8D" Font-Bold="True" ForeColor="White" onclick="SearchToEdit"

style="top: 53px; left: 554px; position: absolute; width: 56px; height: 26px"

Text="Search" />--%>

<asp:Label ID="IDLabelEdit" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"
style="height: 19px; top: 127px; left: 361px; position: absolute; width: 75px"
Text="Admin ID"></asp:Label>

<asp:Label ID="NameLabelEdit" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"
style="height: 19px; top: 169px; left: 362px; position: absolute; width: 96px"
Text="Admin Name"></asp:Label>

<asp:Button ID="ButtonUpdate" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" Font-Bold="True" ForeColor="White" onclick="Update"
style="top: 213px; left: 514px; position: absolute; width: 67px; height: 26px"
Text="Update" />

<asp:TextBox ID="TextBoxEditName" runat="server" ForeColor="Black"
style="height: 22px; top: 168px; left: 474px; width: 185px; position: absolute;"
Width="200px"></asp:TextBox>

<asp:TextBox ID="TextBoxEditID" runat="server" ForeColor="Black"
style="height: 22px; top: 126px; left: 473px; width: 185px; position: absolute;"
Width="200px"></asp:TextBox>

<%-- <asp:Label ID="HeadingLabel" runat="server" Font-Bold="True"

Font-Names="Calibri" Font-Size="13pt" ForeColor="#873E8D"

style="top: 23px; left: 199px; position: absolute; width: 897px; height: 21px"

Text="Search By ID" Width="300px"></asp:Label>--%>

<asp:TextBox ID="TextBoxSearchID" runat="server"
style="top: 124px; left: 56px; position: absolute; width: 185px; height: 22px" 
        ForeColor="Black"></asp:TextBox>

<asp:HiddenField ID="hfCustomerId" runat="server" />

<%--<asp:DropDownList ID="SelectBy" runat="server" Font-Bold="True"

Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"

style="height: 30px; top: 56px; left: 142px; position: absolute; width: 150px; border: 3px Solid #873E8D">

<asp:ListItem Value="1">Select By ID</asp:ListItem>

<asp:ListItem Value="2">Select By Name</asp:ListItem>

</asp:DropDownList>--%>

<asp:RadioButtonList ID="SelectBy" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"
style="top: 59px; left: 60px; position: absolute; height: 52px; width: 118px">
<asp:ListItem Value="1" Selected="True">Edit by ID</asp:ListItem>
<asp:ListItem Value="2">Edit by Name</asp:ListItem>
</asp:RadioButtonList>

<asp:RequiredFieldValidator ID="RequiredFieldName" runat="server"
ErrorMessage="Name Required"
style="height: 19px; top: 171px; left: 670px; position: absolute; width: 141px;"
ControlToValidate="TextBoxEditName" Font-Bold="True" Font-Names="Calibri"
Font-Size="12pt" ForeColor="#E53527"></asp:RequiredFieldValidator>

<asp:RequiredFieldValidator ID="RequiredFieldID" runat="server"
ErrorMessage="ID is Required" Font-Bold="True" Font-Names="Calibri"
Font-Size="12pt" ForeColor="#E53527"
style="height: 19px; top: 129px; left: 670px; position: absolute; width: 141px;"
ControlToValidate="TextBoxEditID"></asp:RequiredFieldValidator>
</asp:Panel>

<asp:Panel ID="DeletePanel" runat="server" Height="270px"
style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;"
BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px">

　

<%-- <asp:Label ID="LabelDelete" runat="server"

style="top: 50px; left: 385px; position: absolute; height: 19px; width: 100px"

Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"

ForeColor="#873E8D" Text="Delete By ID">

</asp:Label>--%>

<asp:TextBox ID="TextBoxDelete" runat="server" ForeColor="Black"
style="top: 132px; left: 379px; position: absolute; height: 22px; width: 179px"
></asp:TextBox>

<asp:Button ID="ButtonDelete" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" ForeColor="White"
style="top: 131px; left: 591px; position: absolute; height: 26px; width: 56px"
Text="Delete" onclick="Delete" />
<asp:HiddenField ID="hDelete" runat="server" />
<asp:Label ID="Show_Detail" runat="server"
style="top: 176px; left: 379px; position: absolute; width: 280px; height: 137px; ">

</asp:Label>

<%--<asp:DropDownList ID="Delete_DropDown" runat="server" Font-Bold="True"

Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"

style="height: 30px; top: 127px; left: 187px; position: absolute; width: 150px; border: 3px Solid #873E8D">

<asp:ListItem Value="1">Delete By ID</asp:ListItem>

<asp:ListItem Value="2">Delete By Name</asp:ListItem>

</asp:DropDownList>--%>

<asp:RadioButtonList ID="Delete_Radio" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"
style="top: 60px; left: 337px; position: absolute; height: 61px; width: 180px">
<asp:ListItem Value="1" Selected="True">Delete by ID</asp:ListItem>
<asp:ListItem Value="2">Delete by Name</asp:ListItem>

</asp:RadioButtonList>

</asp:Panel>

              
                         
    </div>
    </form>
    
    
</body>
</html>
