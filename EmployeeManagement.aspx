<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeeManagement.aspx.cs" Inherits="EmployeeManagement" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=10" /> 

    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js" type = "text/javascript"></script>
    <script src="http://code.jquery.com/jquery-1.11.3.min.js"  type = "text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type = "text/javascript"></script>

    <link href="jquery-ui-1.9.2.custom.css" rel="stylesheet" type="text/css" />


    <script type="text/javascript">

        $(document).ready(function () {
            $("#<%=TextBoxSearchID.ClientID %>").autocomplete({
                source: function (request, response) {
                    var drpVal = $('#<%= Edit_Radio.ClientID %> input:checked').val();
                   // var drpval = document.getElementById('Edit_Radio').value.;
                    $.ajax({
                        url: "EmployeeManagement.aspx/GetEmployee",
                        data: "{ 'name': '" + request.term + "', 'id': '"+drpVal+"'}",
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
                            url: "EmployeeManagement.aspx/GetEmployee",
                            data: "{ 'name': '" + request.term + "', 'id': '" + drpVal + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {

                                   if (drpVal == 1) {
                                        if (item[0] == $("#<%=TextBoxSearchID.ClientID %>").val()) {

                                            $('#<%=TextBoxEditID.ClientID %>').val(item[0]);
                                            $('#<%=TextBoxEditName.ClientID %>').val(item[1]);
                                            $('#<%=TextBoxEditExtension.ClientID %>').val(item[2]);
                                            $('#<%=DropDownEditFloor.ClientID %>').val(item[3]);
                                        }
                                    }
                                    else {
                                        if (item[0] == $("#<%=TextBoxSearchID.ClientID %>").val()) {

                                            $('#<%=TextBoxEditID.ClientID %>').val(item[1]);
                                            $('#<%=TextBoxEditName.ClientID %>').val(item[0]);
                                            $('#<%=TextBoxEditExtension.ClientID %>').val(item[2]);
                                            $('#<%=DropDownEditFloor.ClientID %>').val(item[3]);
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
                        url: "EmployeeManagement.aspx/GetEmployee",
                        data: "{ 'name': '" + request.term + "','id':'" + drpVal + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                //  $('#<%=TextBoxEditID.ClientID %>').val("Dil");
                                return {
                                    label: item[0]
                                }
                            }))
                        }
                    });

                    $("#<%=TextBoxDelete.ClientID %>").focus(function () {
                        $.ajax({
                            url: "EmployeeManagement.aspx/GetEmployee",
                            data: "{ 'name': '" + request.term + "','id':'" + drpVal + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    if (item[0] == $("#<%=TextBoxDelete.ClientID %>").val()) {
                                        $('#<%=Show_Detail.ClientID %>').text(item[0]).append('<br />');
                                        $('#<%=Show_Detail.ClientID %>').append(item[1]).append('<br />');
                                        $('#<%=Show_Detail.ClientID %>').append(item[2]).append('<br />');
                                        $('#<%=Show_Detail.ClientID %>').append(item[3] + " Floor");
                                    }
                                }))
                            }
                        });
                    });
                },
                minLength: 1
            });
            
        });


        function Extension_onblur() {
            var inputName = document.getElementById("TextBoxExtension").value;
            $.ajax({
                url: "EmployeeManagement.aspx/GetFloor",
                data: "{ 'name': '" + inputName + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $('#<%=DropDownFloor.ClientID %>').val(data.d[0][0].toString());
                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function Edit_Extension_onblur() {
            var inputName = document.getElementById("TextBoxEditExtension").value;
            $.ajax({
                url: "EmployeeManagement.aspx/GetFloor",
                data: "{ 'name': '" + inputName + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $('#<%=DropDownEditFloor.ClientID %>').val(data.d[0][0].toString());
                },
                error: function (response) {
                    alert(response.responseText);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
        }


</script>


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
                <div class = "nav" id = "nav" runat = "server" style="position:absolute; top: 180px; left: 110px;"
                    >
                
                    
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



               

                    <asp:Panel ID="AdminRegister" runat="server" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px"
style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;">

<asp:Label ID="IDLabel" runat="server"
style="height: 19px; top: 77px; left: 317px; position: absolute; width: 95px"
Text="Employee ID" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"></asp:Label>

<asp:Label ID="NameLabel" runat="server" ForeColor="#873E8D"
style="height: 19px; top: 124px; left: 318px; position: absolute; width: 115px"
Text="Employee Name"></asp:Label>

<asp:TextBox ID="TextBoxID" runat="server" ForeColor="Black"
style="height: 22px; top: 75px; left: 472px; position: absolute; width: 180px" ></asp:TextBox>

<asp:TextBox ID="TextBoxName" runat="server" ForeColor="Black"
style="height: 22px; top: 121px; left: 472px; position: absolute; width: 180px"></asp:TextBox>

<asp:RequiredFieldValidator ID="NameRequired" runat="server"
ControlToValidate="TextBoxName" ErrorMessage="Name is Required"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#E53527"

                            style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 124px; left: 676px; position: absolute; width: 157px; bottom: 174px;"></asp:RequiredFieldValidator>

<asp:Label ID="ExtensionLabel" runat="server" ForeColor="#873E8D"
style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 217px; left: 318px; position: absolute; width: 139px"
Text="Employee Extension"></asp:Label>

<asp:Button ID="ButtonRegister" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" ForeColor="White" onclick="Register_Emplyee"
style="height: 26px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 252px; left: 482px; position: absolute; width: 84px"
Text="Register" />

<asp:Label ID="LabelFloor" runat="server" ForeColor="#873E8D"
style="font-family: Calibri; font-size: 12pt; font-weight: bold; top: 170px; left: 318px; position: absolute; width: 89px; height: 19px"
Text="Floor Detail"></asp:Label>

<asp:DropDownList ID="DropDownFloor" runat="server" 
                            onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                            AutoPostBack="true" ForeColor="Black"

                            
                            
                            
                            style="font-family: Calibri; font-size: 12pt; font-weight: bold; top: 167px; left: 472px; position: absolute; Height:24px; Width:180px">
 
</asp:DropDownList>

<asp:RequiredFieldValidator ID="IDRequired" runat="server"
ControlToValidate="TextBoxID" ErrorMessage="Admin ID is Required"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#E53527"

                            style="height: 19px; font-family: Calibri; font-size: 12pt; font-weight: bold; top: 78px; left: 676px; position: absolute; width: 157px"></asp:RequiredFieldValidator>

　

 
                        <asp:DropDownList ID="ExtentionDropDown" runat="server" 
                            
                            
                            style="z-index: 1; left: 472px; top: 213px; position: absolute; width: 180px; height: 22px;" 
                            Height="22px" Width="161px">
                        </asp:DropDownList>

</asp:Panel>

　

　

<asp:Panel ID="EditPanel" runat="server" BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px"
style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;">
<%--<asp:Label ID="HeadingLabel" runat="server" Text="Search By ID"

Width="300px" Font-Bold="True" Font-Names="Calibri" Font-Size="13pt" ForeColor="#873E8D"

style="top: 22px; left: 327px; position: absolute; width: 897px; height: 21px"></asp:Label>--%>
<asp:TextBox ID="TextBoxSearchID" runat="server"
style="top: 115px; left: 76px; position: absolute; width: 173px; height: 22px" 
        ForeColor="Black"></asp:TextBox>

<asp:Label ID="IDLabelEdit" runat="server"
style="height: 19px; top: 118px; left: 337px; position: absolute; width: 90px"
Text="Employee ID" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>

<asp:Label ID="NameLabelEdit" runat="server"
style="height: 19px; top: 152px; left: 337px; position: absolute; width: 114px; bottom: 146px;"
Text="Employee Name" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>

<asp:TextBox ID="TextBoxEditName" runat="server" ForeColor="Black"
style="height: 22px; top: 151px; left: 484px; width: 180px; position: absolute;"
Width="200px"></asp:TextBox>

<asp:TextBox ID="TextBoxEditID" runat="server" ForeColor="Black"
style="height: 22px; top: 117px; left: 485px; width: 180px; position: absolute;"
Width="200px" ></asp:TextBox>

<asp:Button ID="ButtonUpdate" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" Font-Bold="True" ForeColor="White" onclick="Update"
style="top: 260px; left: 485px; position: absolute; width: 67px; height: 26px"
Text="Update" />

<asp:Label ID="LabelEditExtension" runat="server"
style="top: 223px; left: 337px; position: absolute; width: 34px; height: 25px"
Text="Extension" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>

<asp:Label ID="LabelEditFloor" runat="server"
style="top: 187px; left: 337px; position: absolute; width: 81px; height: 19px"
Text="Floor Detail" Font-Bold="True" Font-Names="Calibri" Font-Size="12pt"
ForeColor="#873E8D"></asp:Label>

<asp:RadioButtonList ID="Edit_Radio" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"
style="top: 51px; left: 76px; position: absolute; height: 52px; width: 118px">

<asp:ListItem Value="1" Selected="True">Edit by ID</asp:ListItem>
<asp:ListItem Value="2">Edit by Name</asp:ListItem>

</asp:RadioButtonList>

<asp:TextBox ID="TextBoxEditExtension" runat="server" ForeColor="Black" onblur = "Edit_Extension_onblur()"
style="top: 221px; left: 484px; position: absolute; width: 180px; height: 22px"
Width="200px"></asp:TextBox>

<asp:DropDownList ID="DropDownEditFloor" runat="server" ForeColor="Black"

        
        style="top: 187px; left: 484px; position: absolute; font-weight:bold; width: 180px; height: 22px">
</asp:DropDownList>

<asp:HiddenField ID="hEdit" runat="server" />
<%--<asp:DropDownList ID="SelectBy" runat="server" ForeColor="#873E8D"

style="top: 63px; left: 147px; position: absolute; font-weight:bold; width: 150px; height: 33px">

　

<asp:ListItem Value="1">Search By ID</asp:ListItem>

<asp:ListItem Value="2">Search By Name</asp:ListItem>

</asp:DropDownList>--%>

<asp:RequiredFieldValidator ID="RequiredFieldEditID" runat="server"
ErrorMessage="Name is Required"
style="top: 153px; left: 689px; position: absolute; width: 200px; height: 19px;"
Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#FF3300"
ControlToValidate="TextBoxEditName"></asp:RequiredFieldValidator>

<asp:RequiredFieldValidator ID="RequiredFieldName" runat="server"
ErrorMessage="ID is Required"
style="top: 120px; left: 689px; position: absolute; width: 200px; height: 19px;"
Font-Bold="True" Font-Names="Calibri" Font-Size="12pt" ForeColor="#FF3300"
ControlToValidate="TextBoxEditID"></asp:RequiredFieldValidator>



   



</asp:Panel>

　

<asp:Panel ID="DeletePanel" runat="server"
style="top: 352px; left: 108px; position: relative; width: 1023px; height: 317px;"
BorderColor="#873E8D" BorderStyle="Solid" BorderWidth="3px">


<asp:TextBox ID="TextBoxDelete" runat="server" ForeColor="Black"
style="top: 139px; left: 393px; position: absolute; height: 22px; width: 184px"></asp:TextBox>

<asp:RadioButtonList ID="Delete_Radio" runat="server" Font-Bold="True"
Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"
style="top: 73px; left: 348px; position: absolute; height: 52px; width: 140px">

<asp:ListItem Value="1" Selected="True">Delete by ID</asp:ListItem>
<asp:ListItem Value="2">Delete by Name</asp:ListItem>

</asp:RadioButtonList>

　

<asp:Button ID="ButtonDelete" runat="server" BackColor="#A878AE"
BorderColor="#873E8D" ForeColor="White"
style="top: 139px; left: 602px; position: absolute; height: 26px; width: 56px"
Text="Delete" onclick="Delete" />


<%-- <asp:Label ID="LabelDelete" runat="server" Font-Bold="True"

Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"

style="top: 78px; left: 326px; position: absolute; height: 19px; width: 100px"

Text="Delete By ID">

</asp:Label>--%>

<asp:HiddenField ID="hDelete" runat="server" />

　

<asp:Label ID="Show_Detail" runat="server"

style="top: 172px; left: 393px; position: absolute; width: 200px; height: 150px; "

></asp:Label>

　

　

　

<%-- <asp:DropDownList ID="Delete_DropDown" runat="server" Font-Bold="True"

Font-Names="Calibri" Font-Size="12pt" ForeColor="#873E8D"

style="top: 137px; left: 140px; position: absolute; width: 150px; height: 30px; border: 3px Solid #873E8D">

<asp:ListItem Value="1">Delete By ID</asp:ListItem>

<asp:ListItem Value="2">Delete By Name</asp:ListItem>

</asp:DropDownList>--%>

　

</asp:Panel>




              

    </div>

    </form>

</body>

</html>