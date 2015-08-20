<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=10" /> 

    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="jquery-1.3.2.min.js" type="text/javascript"></script>

    <script type = "text/javascript">

        
        
        function getExt() {

            document.getElementById('search_name').addEventListener('input', function () {
                document.getElementById("div3").style.maxHeight = "300px";
                var inputName = document.getElementById("search_name").value;
                if ("" + inputName != "") {
                    $.ajax({
                        type: "POST",
                        url: "Default.aspx/GetExtention",
                        data: "{'name': '" + inputName + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",

                        success: function (response) {
                            
                            var table = "";
                            if (!response.d.toString() == "") {
                                document.getElementById("div2").style.visibility = "visible";
                                document.getElementById("noEmp").style.visibility = "hidden";
                                document.getElementById("h1").style.visibility = "visible";


                                table = "<table>"

                                for (var i = 0; i < response.d.length; i++) {

                                     
                                    table = table.concat("<tr><td><label>" + response.d[i][0].toString() + "</label></td><td><a href='#' onclick = 'same_Extension(" + response.d[i][1].toString() + ")' style= 'text-decoration : none'>" + response.d[i][1].toString() + "</a></label></td><td style='width:80px; height:50px; text-align: center;'><label>  <img src=" + response.d[i][2] + " height ='50px' width='50px'>  </label></td> </tr>");
                                }
                                table = table.concat("</table")
                                document.getElementById("div3").innerHTML = table;
                            }
                            else {
                                document.getElementById("noEmp").style.visibility = "visible";
                                document.getElementById("h1").style.visibility = "hidden";
                                document.getElementById("div3").innerHTML = "";
                            }
                        },
                        failure: function (response) {
                            alert(response.d);
                        }
                    });
                }
                else {
                    document.getElementById("div2").style.visibility = "hidden";
                    document.getElementById("h1").style.visibility = "hidden";
                    document.getElementById("noEmp").style.visibility = "hidden";
                }
            });

        }

        function Show_Hide_By_Display_Important(id) {

            if (id == "important") {
                if (document.getElementById("GridViewImportant").style.display == "" || document.getElementById("GridViewImportant").style.display == "block") {
                    document.getElementById("GridViewImportant").style.display = "none";
                    document.getElementById("GridViewConference").style.top = "480px";
                    document.getElementById("Btn_Conference").style.top = "434px";
                    document.getElementById("Btn_Important").style.border = "1px solid #A878AE"
                }
                else {
                    document.getElementById("GridViewImportant").style.display = "block";
                    document.getElementById("GridViewConference").style.top = "620px";
                    document.getElementById("Btn_Conference").style.top = "580px";
                    document.getElementById("Btn_Important").style.border = "3px solid #873E8D"
                }
            }
            if (id == "conference") {
                if (document.getElementById("GridViewConference").style.display == "" || document.getElementById("GridViewConference").style.display == "block") {
                    document.getElementById("GridViewConference").style.display = "none";
                    document.getElementById("Btn_Conference").style.border = "1px solid #A878AE"
                }
                else {
                    document.getElementById("GridViewConference").style.display = "block";
                    document.getElementById("Btn_Conference").style.border = "3px solid #873E8D"
                }
            }

            return false;
        }

        function same_Extension(id) {

            if ("" + id != "") {
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetSameExtention",
                    data: "{'name': '" + id + "' }",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {
                        $('#<%=TextSameExt.ClientID %>').focus = "true";
                        document.getElementById("TextSameExt").innerHTML = "Employees Having " + id + " Extension ";
                        document.getElementById("SameExtDiv").style.display = "block"
                        document.getElementById("TextSameExt").style.display = "block"
                        var table = "";
                        if (!response.d.toString() == "") {
                            table = "<table>"

                            for (var i = 0; i < response.d.length; i++) {
                                if (id == response.d[i][1].toString()) {
                                    table = table.concat("<tr><td><label>" + response.d[i][0].toString() + "</label></td></tr>");
                                }

                            }
                            table = table.concat("</table")
                            document.getElementById("SameExtDiv").innerHTML = table;
                        }
                        else {

                            document.getElementById("SameExtDiv").innerHTML = "";
                        }
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }
            else {
                document.getElementById("SameExtDiv").style.display = "none";
                document.getElementById("TextSameExt").style.display = "none";
            }
        }


        function hideExt() {
            document.getElementById("SameExtDiv").style.display = "none";
            document.getElementById("TextSameExt").style.display = "none";
        
        }

        </script>

    <style type="text/css">
        
        #container {
	position: relative;
}
        
        
        #divImportant
        {
            top: 516px;
            left: 10px;
            position: absolute;
            height: 133px;
            width: 897px;
        }
        #SameExtDiv
        {
            top: 900px;
            left: 114px;
            position: absolute;
            height: 313px;
            width: 401px;
        }
    </style>


</head>

<body onload= "getExt()" style="overflow:auto">
    <form id="form1" runat="server">

    <div class = "main">

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
                <div class = "nav" id = "nav" runat = "server" style="position:absolute; top: 180px; left: 110px;">
                
                    
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

                <asp:Image ID="Image2" runat="server" ImageUrl="search.jpg" 
                style="top: 380px; left: 395px; position: absolute; height: 38px; width: 40px" />

                </div>

                <div class = "divThreeMain">
                <div class = "divThree" id = "divThree" runat = "server" 
                        style="position:absolute; top: 180px; left: 110px;">
        
                   <ul>
		             <li><a href="Default.aspx">Home</a></li>

                      <li><a href="#">Profile</a>
			            <ul>
				            <li><a href='NormalUser.aspx?p=add' id="add" runat="server">Add Me</a></li>
				            <li><a href='NormalUser.aspx?p=edit' id="edit" runat="server">Edit Profile</a></li>
			            </ul>
		             </li>

		        </ul>

              </div>  
        </div>
        
            
     </div>


      &nbsp;
			            <input id ="search_name" runat="server" onfocus="hideExt()"
        
                        
        style = "width:270px;height:29px; top: 380px; left: 110px; position: absolute; right: 551px;"/> 
                        <asp:Panel ID="Panel1" runat="server" 
                         
        style="top: 433px; left: 111px; position: absolute; width: 601px; height: 394px; margin-top: 0px">

                            <div id='div1'>
                        <div id='div2' style = "visibility:hidden">
                            <h4 id='noEmp' style="color:#873E8D; visibility:hidden" > Invalid Employee Name </h4>
			                <h3 id='h1' style="color:#873E8D">Extension Details</h3>
                            <div id='div3' style="width: 300px; overflow: auto;"> 
                              
                            </div>
			            </div>
            	    
                    </div>
                 </asp:Panel>


                    
        <asp:SqlDataSource ID="ConferenceExtension" runat="server" 
        ConnectionString="<%$ ConnectionStrings:employeedataConnectionStringConference %>" 
        ProviderName="<%$ ConnectionStrings:employeedataConnectionStringConference.ProviderName %>" 
        SelectCommand="SELECT Name, Conference_Hall_Extension FROM conference_hall">
        </asp:SqlDataSource>

     
 
        <asp:SqlDataSource ID="ImportantExtension" runat="server" 
        ConnectionString="<%$ ConnectionStrings:employeedataImportant Extension %>" 
        ProviderName="<%$ ConnectionStrings:employeedataImportant Extension.ProviderName %>" 
        SelectCommand="SELECT Name, Extension FROM important">
        </asp:SqlDataSource>
       
        <asp:Button ID="Btn_Important" runat="server" Text="Important Extensions" 
        Font-Bold="True" Font-Names="Calibri" Font-Size="14pt" ForeColor="#873E8D" 
        style="top: 385px; left: 800px; right: -13px; position: absolute; height: 35px; width: 320px; border : 1px solid #A878AE" 
        OnClientClick=" return Show_Hide_By_Display_Important('important')" />

        <asp:Button ID="Btn_Conference" runat="server" Text="Conference Room Extensions" 
        Font-Bold="True" Font-Names="Calibri" Font-Size="14pt" ForeColor="#873E8D"
        style="top: 434px; left: 800px; right: -13px; position: absolute; height: 35px; width: 320px; border : 1px solid #A878AE" 
        OnClientClick=" return Show_Hide_By_Display_Important('conference')" />


                    
        <asp:GridView ID="GridViewImportant" runat="server"
        style="top: 425px; left: 805px; right:-18px; position: absolute; height: 133px; width: 320px; display : none;" 
        GridLines="None" AutoGenerateColumns="False" DataKeyNames="Name"
        DataSourceID="ImportantExtension" Font-Names="Calibri" Font-Size="12pt">

                    <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" 
                    SortExpression="Name" ItemStyle-Width = "220px" ItemStyle-HorizontalAlign = "Left" HeaderStyle-Width = "220px" HeaderStyle-HorizontalAlign = "Left" />
                    <asp:BoundField DataField="Extension" HeaderText="Extension" 
                    SortExpression="Extension" ItemStyle-Width = "100px" ItemStyle-HorizontalAlign = "Left" HeaderStyle-Width = "100px" HeaderStyle-HorizontalAlign = "Left"/>
                    </Columns>

        </asp:GridView>

                   
        
        <asp:Label ID="TextSameExt" runat="server" Font-Bold="True"  
            Font-Names="Calibri" Font-Size="14pt" 
            style="top: 860px; left: 112px; position: absolute; height: 30px;color:#873E8D; width: 280px; border:none; display:none">Employees With Same Extension</asp:Label>
   
        <div  id="SameExtDiv" style="display:none; top:890px">
         </div>

         <asp:GridView ID="GridViewConference" runat="server"
        style="top: 480px; left: 802px; right:5px; position: absolute; height: 250px; width: 320px;  display : none; overflow:auto" 
        GridLines="None" AutoGenerateColumns="False" DataKeyNames="Name"
        DataSourceID="ConferenceExtension" Font-Names="Calibri" Font-Size="12pt">

                    <Columns>

                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" 
                    SortExpression="Name" ItemStyle-Width = "260px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width = "260px" ItemStyle-HorizontalAlign="Left" />
                    
                    <asp:BoundField DataField="Conference_Hall_Extension" HeaderText="Extension" 
                    ItemStyle-Width = "60px" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width = "60px" ItemStyle-HorizontalAlign="Left" />

                    </Columns>

                    </asp:GridView>
        
       
                   

                    
                   
                        
                
    </form>
    
</body>
</html>
