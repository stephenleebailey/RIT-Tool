<%@ Page Title="RIT" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RIT.aspx.cs" Inherits="RIT._Default" Debug="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <script type='text/javascript'>
        //Enables Calling of modal from C#
        function openModal() {
            jQuery.noConflict();
            $('#RIT_Edit').modal('show');
        } 
    </script>


    <%-- Webpage Title --%>
    <div class="ml-4 mr-4">
        <div class="row mt-2">
            <h3 class="p-4" style="color: #86BC25; font-size: xx-large; font-family: Arial, Helvetica, sans-serif; font-weight: bolder; font-style: normal; font-variant: normal; text-transform: none;">Realtime Incident Tracker </h3>
        </div>

        <%--Ticket Interaction buttons--%>
        <div class="row">
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 d-flex justify-content-start">
                <div class="btn-group d-line">
                    <button type="button" data-toggle="modal" data-target="#RIT_Add_Incident" class="btn" style="background-color: #86BC24; color: white">Add New Incident</button>
                    <button type="button" data-toggle="modal" data-target="#RIT_Edit" class="btn" style="background-color: #86BC24; color: white">Edit Incident</button>
                    <button type="button" data-toggle="modal" data-target="#RIT_Update" class="btn" style="background-color: #86BC24; color: white">Next Action</button>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 d-flex justify-content-end">
                <div class="btn-group d-line">
                    <a class="btn btn-primary pr-4 pl-4" href="../RIT.aspx">RIT</a>
                    <a class="btn btn-primary" href="../IncidentDatabase.aspx">Incident Database</a>
                </div>
            </div>
        </div>
       <%-- Error Message Banner--%>
        <br />
        <div id="ErrorMessage" runat="server" class="alert alert-danger" role="alert" visible="false">Test</div>
        <br />

      <%--Ticket Grid--%>
        <asp:GridView class="table table-hover" ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="TicketID" Style="margin-top: 0px" OnSelectedIndexChanged="OnSelectedIndexChanged">
            <AlternatingRowStyle BackColor="#666666" />
            <Columns>
                <asp:BoundField DataField="TicketID" HeaderText="TicketID" ReadOnly="True" SortExpression="TicketID" />
                <asp:BoundField DataField="Client" HeaderText="Client" SortExpression="Client" />
                <asp:BoundField DataField="Process" HeaderText="Process" SortExpression="Process" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:BoundField DataField="ICOwner" HeaderText="ICOwner" SortExpression="ICOwner" />
                <asp:BoundField DataField="AssignedTo" HeaderText="AssignedTo" SortExpression="AssignedTo" />
                <asp:BoundField DataField="Severity" HeaderText="Severity" SortExpression="Severity" />
                <asp:BoundField DataField="OpenedOn" HeaderText="OpenedOn" SortExpression="OpenedOn" />
                <asp:BoundField DataField="DueBy" HeaderText="DueBy" SortExpression="DueBy" />
                <asp:BoundField DataField="LastActionOn" HeaderText="LastActionOn" SortExpression="LastActionOn" />
                <asp:BoundField DataField="LastActionTaken" HeaderText="LastActionTaken" SortExpression="LastActionTaken" />
                <asp:BoundField DataField="NextActionDue" HeaderText="NextActionDue" SortExpression="NextActionDue" />
                <asp:BoundField DataField="NextActionRequired" HeaderText="NextActionRequired" SortExpression="NextActionRequired" />
            </Columns>
            <HeaderStyle BackColor="Black" ForeColor="#86BC25" />
            <SelectedRowStyle BorderColor="#86BC25" BorderStyle="Solid" BorderWidth="3px" />
        </asp:GridView>

        <!--ADD Incident Modal -->
        <div class="modal fade" id="RIT_Add_Incident" tabindex="-1" role="dialog" aria-labelledby="RIT_Add_Incidented" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="RIT_Add_Incidented">RIT - Add Incident</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!--Add Incident Body-->
                        <div class="row">
                            <div id="Left1" class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                <div id="row1" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Ticket ID</label>
                                    <input type="text" title="T-0000-000" pattern="T-[0-9]{3,}-[0-9]{3,}" class="pr-1" style="width: 200px" id="AddTicketID" runat="server"/>
                                </div>
                                <div id="row7" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Client</label>
                                    <asp:DropDownList class="pr-1" Style="width: 200px" ID="AddClient" runat="server" DataSourceID="SqlDataSource1" DataTextField="Client" DataValueField="Client"></asp:DropDownList>
                                </div>
                                <div id="row8" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Process</label>
                                    <asp:DropDownList Style="width: 200px" ID="AddProcess" runat="server" DataSourceID="SqlDataSource2" DataTextField="Process" DataValueField="Process"></asp:DropDownList>
                                </div>
                                <div id="row2" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Status</label>
                                    <asp:DropDownList ID="AddStatus" Style="width: 200px" runat="server" DataSourceID="SqlDataSource4" DataTextField="Status" DataValueField="Status"></asp:DropDownList>
                                </div>
                                <div id="row3" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">IC Owner</label>
                                    <asp:DropDownList ID="AddICOwner" Style="width: 200px" runat="server" DataSourceID="SqlDataSource5" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                                </div>
                                <div id="row4" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Assigned To</label>
                                    <asp:DropDownList ID="AddAssignedTo" Style="width: 200px" runat="server" DataSourceID="SqlDataSource5" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                                </div>
                                <div id="row5" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Severity</label>
                                    <asp:DropDownList ID="AddSeverity" runat="server" Style="width: 200px" DataSourceID="SqlDataSource3" DataTextField="SeverityLevel" DataValueField="SeverityLevel"></asp:DropDownList>
                                </div>
                                <div id="row9" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Opened On</label>
                                    <input type="datetime-local" min="2019-01-01T00:00:00" max="3000-01-01T00:00:00" id="AddOpenedOn" style="width: 200px" class="pr-1" runat="server"/>
                                </div>
                                <div id="row11" class="row p-2 m-2">
                                    <label class="m-2" style="width: 80px">Last Action On</label>
                                    <input type="datetime-local" min="2019-01-01T00:00:00" max="3000-01-01T00:00:00" id="AddLastActionOn" style="width: 200px" class="pr-1" runat="server"/>
                                </div>
                            </div>
                            <div id="Right1" class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                <div id="row25" class="row m-2">
                                    <label class="m-2">Last Action Taken</label>
                                    <textarea rows="11" cols="50" id="AddLastActionTaken" runat="server" validaterequestmode="Disabled"></textarea>
                                    <label class="m-2">Next Action Required</label>
                                    <textarea rows="11" cols="50" id="AddNextActionReq" runat="server" validaterequestmode="Disabled"></textarea>
                                </div>
                            </div>
                        </div>
                        <!--End Add Incident Body -->
                    </div>
                    <%--Add Incident Modal Buttons--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:Button runat="server" OnClick="Add_Incident" type="button" class="btn btn-primary" Text="Save"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
        <!--Edit Incident-->
        <div class="modal fade" id="RIT_Edit" tabindex="-1" role="dialog" aria-labelledby="RIT_Edited" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="RIT_Edited">RIT - Edit Incident</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!--Edit Incident Modal Body-->

                        <div class="row">
                            <div id="Left2" class="col-xs-12 col-sm-12 col-md-6 col-lg-3 ml-4">
                                <div id="rowLeft1" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Ticket ID</label>
                                    <%--Pattern uses to regex restrict input--%>
                                    <input disabled="disabled" type="text" title="T-0000-000" pattern="T-[0-9]{3,}-[0-9]{3,}" class="pr-1" style="width: 200px" id="EditTicketID" runat="server"/>
                                </div>
                                <div id="rowLeft2" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Client</label>
                                    <asp:DropDownList class="pr-1" Style="width: 200px" ID="EditClient" runat="server" DataSourceID="SqlDataSource1" DataTextField="Client" DataValueField="Client"></asp:DropDownList>
                                </div>
                                <div id="rowLeft9" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Process</label>
                                    <asp:DropDownList Style="width: 200px" ID="EditProcess" runat="server" DataSourceID="SqlDataSource2" DataTextField="Process" DataValueField="Process"></asp:DropDownList>
                                </div>
                                <div id="rowLeft3" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Status</label>
                                    <asp:DropDownList ID="EditStatus" Style="width: 200px" runat="server" DataSourceID="SqlDataSource4" DataTextField="Status" DataValueField="Status"></asp:DropDownList>
                                </div>
                                <div id="rowLeft4" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">IC Owner</label>
                                    <asp:DropDownList ID="EditICOwner" Style="width: 200px" runat="server" DataSourceID="SqlDataSource5" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                                </div>
                                <div id="rowLeft5" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Assigned To</label>
                                    <asp:DropDownList ID="EditAssignedTo" Style="width: 200px" runat="server" DataSourceID="SqlDataSource5" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
                                </div>
                                <div id="rowLeft6" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Severity</label>
                                    <asp:DropDownList ID="EditSeverity" runat="server" Style="width: 200px" DataSourceID="SqlDataSource3" DataTextField="SeverityLevel" DataValueField="SeverityLevel"></asp:DropDownList>
                                </div>
                                <div id="rowLeft7" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Opened On</label>
                                    <input type="datetime-local" min="2019-01-01T00:00:00" max="3000-01-01T00:00:00" id="EditOpenedOn" style="width: 200px" class="pr-1" runat="server"/>
                                </div>
                                <div id="rowMiddle21" class="row p-2 m-2">
                                    <label class="m-2" style="width: 100px">Last Action On</label>
                                    <input type="datetime-local" min="2019-01-01T00:00:00" max="3000-01-01T00:00:00" id="EditLastActionOn" style="width: 200px" class="pr-1" runat="server"/>
                                </div>
                            </div>
                            <div id="Middle" class="col-xs-12 col-sm-12 col-md-6 col-lg-4">

                                <div id="rowMiddle22" class="row m-2 ml-3">
                                    <label class="m-2">Last Action Taken</label>
                                    <textarea rows="11" cols="50" id="EditLastActionTaken" runat="server" validaterequestmode="Disabled" ></textarea>
                                </div>
                            </div>
                            <div id="Right2" class="col-xs-12 col-sm-12 col-md-6 col-lg-4">
                                <div id="rowRight22" class="row m-2 ml-3">
                                    <label class="m-2">Next Action Required</label>
                                    <textarea rows="11" cols="50" id="EditNextActionReq" runat="server" validaterequestmode="Disabled"></textarea>
                                </div>
                            </div>
                        </div>
                        <!--End Edit Incident Modal Body -->
                    </div>
                   <%-- Edit Invident Buttons--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:LinkButton ID="LinkButton5" runat="server" class="btn btn-primary" OnClick="Delete_Incident" OnClientClick="return confirm('Are you sure you want to delete this ticket?');">Delete</asp:LinkButton>
                        <asp:Button runat="server" OnClick="Edit_Incident" type="button" class="btn btn-primary" Text="Save"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Add Incident Next Action-->
        <div class="modal fade" id="RIT_Update" tabindex="-1" role="dialog" aria-labelledby="RIT_Updated" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="RIT_Updated">RIT - Update Task
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!--Incident Next Action Body -->
                        <div class="row">
                            <label id="UpdateTicketID" runat="server"></label>
                        </div>
                        <div class="row">
                            <div " class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                <div  class="row m-2">
                                    <label class="m-2">Last Action Taken</label>
                                    <textarea id="UpdateLastActionTaken" rows="11" cols="50" runat="server"></textarea>
                                </div>
                                <label class="row p-2 m-2">Last Action On</label>
                                <div class="row p-2 m-2">
                                <input id="UpdateLastActionOn" min="2019-01-01T00:00:00" max="3000-01-01T00:00:00" type="datetime-local" class="pr-1" runat="server"/>
                                </div>
                            </div>
                            <div " class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                <div class="row m-2">
                                    <label class="m-2">Next Action Required</label>
                                    <textarea id="UpdateNextActionReq" rows="11" cols="50" runat="server"></textarea>
                                </div>
                            </div>
                        </div>
                        <!--End Incident Next Action Body -->
                    </div>
                    <div class="modal-footer">
                    <!--Incident Next Action Buttons-->
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>   
                        <asp:Button runat="server" OnClick="Next_Action" type="button" class="btn btn-primary" Text="Save"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
        <!--SQL Datasources -->
        <asp:SqlDataSource ID="SqlDataSource6" runat="server"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RIT_DevConnectionString %>" SelectCommand="SELECT [Client] FROM [Clients]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:RIT_DevConnectionString %>" SelectCommand="SELECT [Process] FROM [Processes]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:RIT_DevConnectionString %>" SelectCommand="SELECT [SeverityLevel] FROM [SeveritySLA]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:RIT_DevConnectionString %>" SelectCommand="SELECT [Status] FROM [TicketStatus]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:RIT_DevConnectionString %>" SelectCommand="SELECT [Name] FROM [Users]"></asp:SqlDataSource>
        <br />
    </div>
</asp:Content>
