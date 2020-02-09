<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IncidentDatabase.aspx.cs" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

 <div class="ml-4 mr-4">
        <div class="row mt-2">
            <h3 class="p-4" style="color: #86BC25; font-size: xx-large; font-family: Arial, Helvetica, sans-serif; font-weight: bolder; font-style: normal; font-variant: normal; text-transform: none;">Incident Database</h3>
        </div>

        <div class="row">
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 d-flex justify-content-start">
                <div class="btn-group d-line">
                    <button type="button" data-toggle="modal" data-target="#RIT_Add_Incident" class="btn" style="background-color: #86BC24; color: white">Add New Incident</button>
                    <button type="button" data-toggle="modal" data-target="#RIT_Edit" class="btn" style="background-color: #86BC24; color: white">Edit Incident</button>
                </div>
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 d-flex justify-content-end">
                <div class="btn-group d-line">
                    <a class="btn btn-primary pr-4 pl-4" href="../RIT.aspx">RIT</a>
                    <a class="btn btn-primary" href="../IncidentDatabase.aspx">Incident Database</a>
                </div>
            </div>
        </div>
        <br />

        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col" style="width: 95px; color: #86BC25; background-color: black">Date</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Affected Client</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Affected Process</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Issue</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Type</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Robot Account</th>
                    <th scope="col" style="color: #86BC25; background-color: black">VM Server</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Resolution</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Date Resolved</th>
                    <th scope="col" style="color: #86BC25; background-color: black">Supporting Documents</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <!-- Date -->
                    <td>01/01/2020</td>
                    <!-- Affected Client -->
                    <td>PSS</td>
                    <!-- Affect Process -->
                    <td>Leavers</td>
                    <!-- Issue -->
                    <td>Incident involving website</td>
                    <!-- Type -->
                    <td>Website</td>
                    <!-- Robot Account -->
                    <td>UKSSORobot13</td>
                    <!-- VM Server -->
                    <td>UKVDSKP860091 </td>
                    <!-- Resolution -->
                    <td>Initial Investigation Begun On MM</td>
                    <!-- Date Resolved -->
                    <td>22/10/2019 09:00</td>
                    <!-- Supporting Documents -->
                    <td>Deliver incident report to IC for client communication</td>
                    <!-- END -->
                </tr>
        </table>
    </div>


    <!--ADD INCIDENT Modal -->
    <div class="modal fade" id="RIT_Add_Incident" tabindex="-1" role="dialog" aria-labelledby="RIT_Add_Incidented" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="RIT_Add_Incidented">RIT - Add Incident</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!--********************** ADD INCIDENT MODAL BODY ****************************************** -->
                    <div class="row">
                        <div id="Left2" class="col-xs-12 col-sm-12 col-md-6 col-lg-3 ml-4">
                            <div id="rowLeft1" class="row p-2 m-2">
                                <label class="m-2" style="width: 80px">Date</label>
                                <input type="date" class="pr-1" />
                            </div>
                            <div id="rowLeft2" class="row p-2 m-2">
                                <label class="m-2" style="width: 80px">Client</label>
                                <input class="pr-1" />
                            </div>
                            <div id="rowLeft3" class="row p-2 m-2">
                                <label class="m-2" style="width: 80px">Process</label>
                                <input class="pr-1" />
                            </div>
                            <div id="rowLeft4" class="row p-2 m-2">
                                <label class="m-2" style="width: 80px">Robot Account</label>
                                <input class="pr-1" />
                            </div>
                            <div id="rowLeft5" class="row p-2 m-2">
                                <label class="m-2" style="width: 80px">VM Server</label>
                                <input class="pr-1" />
                            </div>
                            <div id="rowLeft6" class="row p-2 m-2">
                                <label class="m-2" style="width: 80px">Type</label>
                                <input  class="pr-1" />
                            </div>
                            <div id="rowRight23" class="row m-2 ml-3">
                                <label class="m-2">Supporting Documents</label>
                                <input type="date" class="pr-1" />
                            </div>
                        </div>
                        <div id="Middle" class="col-xs-12 col-sm-12 col-md-6 col-lg-4">

                            <div id="rowMiddle21" class="row m-2 ml-3">
                                <label class="m-2">Issue</label>
                                <textarea rows="11" cols="50">

                                </textarea>
                            </div>
                        </div>
                        <div id="Right2" class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
                            <div id="rowRight21" class="row m-2 ml-3">
                                <label class="m-2">Resolution</label>
                                <textarea rows="11" cols="50">
                                </textarea>
                            </div>
                            <div id="rowRight22" class="row p-2 m-2">
                                <label class="m-2">Date Resolved</label>
                                <input type="date" class="pr-1" />
                            </div>
                        </div>
                </div>
    <!--********************** END ADD INCIDENT MODAL BODY ****************************************** -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>


            <br />
            <br />
            <br />

            <script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</asp:Content>
