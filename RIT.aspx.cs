using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Windows;

namespace RIT
{
    public partial class _Default : Page
    {
        private String strRitConnection = @"Data Source=ukvir10343\SQLEXPRESS;Initial Catalog=RIT_Dev;Persist Security Info=False;User ID=RIT_Tool;Password=RIT_Tool_Pa$$word1";
        public List<Incident> incidents { get; set; }
        public DataTable dataTable { get; set; } = new DataTable();
        public class Incident
        {
            public string TicketID { get; set; }
            public string Client { get; set; }
            public string Process { get; set; }
            public string Status { get; set; }
            public string ICOwner { get; set; }
            public string AssignedTo { get; set; }
            public string Severity { get; set; }
            public DateTime OpenedOn { get; set; }
            public DateTime DueBy { get; set; }
            public DateTime LastActionOn { get; set; }
            public string LastActionTaken { get; set; }
            public DateTime NextActionDue { get; set; }
            public string NextActionReq { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {      
                GetIncidents();
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
                checkSLAs();
                ErrorMessage.Visible = false;
                ErrorMessage.InnerText = "";
            }
        }

        protected override void Render(HtmlTextWriter writer)
        {
            //Make each row onclick selected
            foreach (GridViewRow r in GridView1.Rows)
            {
                if (r.RowType == DataControlRowType.DataRow)
                {
                    r.ToolTip = "Click to select row";
                    r.Attributes["onclick"] = this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + r.RowIndex, true);
                }
            }
            base.Render(writer);
        }
        /// <summary>
        /// Check if each row has exceeded its due by date or next action on time.
        /// </summary>
        private void checkSLAs()
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (DateTime.Now > Convert.ToDateTime(row.Cells[8].Text))
                {
                    row.BackColor = System.Drawing.Color.FromArgb(204, 0, 0);
                }
                else if (DateTime.Now > Convert.ToDateTime(row.Cells[11].Text))
                {
                    row.BackColor = System.Drawing.Color.FromArgb(225, 138, 7);
                }
            }
        }
        /// <summary>
        /// Pulls all data entries from SQL 
        /// </summary>
        private void GetRitTable()
        {
            dataTable = getSQLTable(strRitConnection, "select * from RITView",false,null);
        }
        private List<Incident> GetIncidents()
        {
            GetRitTable();
            incidents = new List<Incident>();
            foreach (DataRow dataRow in dataTable.Rows)
            {
                var incident = new Incident()
                {
                    TicketID = (string)dataRow["TicketID"],
                    Client = (string)dataRow["Client"],
                    Process = (string)dataRow["Process"],
                    Status = (string)dataRow["Status"],
                    ICOwner = (string)dataRow["ICOwner"],
                    AssignedTo = (string)dataRow["AssignedTo"],
                    Severity = (string)dataRow["Severity"],
                    OpenedOn = (DateTime)dataRow["OpenedOn"],
                    DueBy = (DateTime)dataRow["DueBy"],
                    LastActionOn = (DateTime)dataRow["LastActionOn"],
                    LastActionTaken = (string)dataRow["LastActionTaken"],
                    NextActionDue = (DateTime)dataRow["NextActionDue"],
                    NextActionReq = (string)dataRow["NextActionRequired"]
                };
                incidents.Add(incident);
            }
            return incidents;
        }
        /// <summary>
        /// Function called on add incident modal save. Pulls input data from add incident modal and passes data to a function to be added to the SQL database
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Add_Incident(object sender, System.EventArgs e)
        {
            //Values to be checked if they exceed todays date
            string[,] datesToCheck = new string[,]
                {
                        {AddOpenedOn.Value.ToString()},
                        {AddLastActionOn.Value.ToString()}
                };
            if (checkDate(datesToCheck)) {
            string[,] sqlVariables = new string[,]
                    {
                        {"@TicketID", AddTicketID.Value.ToString()},
                        {"@Client", AddClient.Text.ToString()},
                        {"@Process", AddProcess.Text.ToString()},
                        {"@Status", AddStatus.Text.ToString()},
                        {"@ICOwner", AddICOwner.Text.ToString()},
                        {"@AssignedTo", AddAssignedTo.Text.ToString()},
                        {"@Severity", AddSeverity.Text.ToString()},
                        {"@OpenedOn", AddOpenedOn.Value.ToString()},
                        {"@LastActionOn", AddLastActionOn.Value.ToString()},
                        {"@LastActionTaken", AddLastActionTaken.Value.ToString()},
                        {"@NextActionRequired", AddNextActionReq.Value.ToString()},
                        {"@EditedBy", Environment.UserName.ToString()}};

            dataTable = getSQLTable(strRitConnection, "AddIncident", true, sqlVariables);
            Response.Redirect(Request.RawUrl);
            }
        }
        /// <summary>
        /// Function called on edit modal save. Pulls input data from edit modal and passes data to a function to be added to the SQL database
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Edit_Incident(object sender, System.EventArgs e)
        {
            string[,] datesToCheck = new string[,]
               {
                        {EditOpenedOn.Value.ToString()},
                        {EditLastActionOn.Value.ToString()}
               };
            if (GridView1.SelectedIndex != -1)
            {
                string[,] sqlVariables = new string[,]
                {
                            {"@TicketID",EditTicketID.Value},
                            {"@Client",EditClient.Text},
                            {"@Process",EditProcess.Text},
                            {"@Status",EditStatus.Text},
                            {"@ICOwner",EditICOwner.Text},
                            {"@AssignedTo",EditAssignedTo.Text},
                            {"@Severity",EditSeverity.Text},
                            {"@OpenedOn",EditOpenedOn.Value},
                            {"@LastActionOn",EditLastActionOn.Value},
                            {"@LastActionTaken",EditLastActionTaken.Value},
                            {"@NextActionRequired",EditNextActionReq.Value},
                            {"@EditedBy",Environment.UserName} };
                dataTable = getSQLTable(strRitConnection, "EditIncident", true, sqlVariables);
                Response.Redirect(Request.RawUrl);
            }else {
                ErrorMessage.InnerText = "Error: Please select a row before attempting to edit an incident!";
                ErrorMessage.Visible = true;
            }
        }
        /// <summary>
        /// Function called on add next action modal save. Pulls input data from add next action modal and passes data to a function to be added to the SQL database
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Next_Action(object sender, System.EventArgs e)
        {
            string[,] datesToCheck = new string[,]
            {
                {UpdateLastActionOn.Value.ToString()}
            };
            if (GridView1.SelectedIndex != -1 && checkDate(datesToCheck))
            {
                string[,] sqlVariables = new string[,]
                {
                        {"@TicketID",UpdateTicketID.InnerText},
                        {"@LastActionOn",UpdateLastActionOn.Value},
                        {"@LastActionTaken",UpdateLastActionTaken.Value},
                        {"@NextActionRequired",UpdateNextActionReq.Value},
                        {"@EditedBy",Environment.UserName} };
            dataTable = getSQLTable(strRitConnection, "UpdateIncident", true, sqlVariables);
            Response.Redirect(Request.RawUrl);
            }else{
                ErrorMessage.InnerText = "Error: Please select a row before attempting to add a next action!";
                ErrorMessage.Visible = true;
            }
        }
        /// <summary>
        /// Called on edit incident modal deleted click. Calls SQL stored procedure using TicketId and the users username as parameters to mark and incident as deleted in the database.
        /// The ticket will no longer show in the table once deleted.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void Delete_Incident(object sender, System.EventArgs e)
        {
            using (var sqlConnection = new SqlConnection(strRitConnection))
            using (var command = new SqlCommand("DeleteIncident", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            })
            {
                command.Parameters.Add("@TicketID", SqlDbType.NVarChar).Value = EditTicketID.Value;
                command.Parameters.Add("@EditedBy", SqlDbType.NVarChar).Value = Environment.UserName;
                sqlConnection.Open();
                command.ExecuteNonQuery();
                sqlConnection.Close();
                Response.Redirect(Request.RawUrl);
            }
        }
        /// <summary>
        /// Called whenever a new row is selected. Updates edit modal and add next action modal inputs will the data of the selected row.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void OnSelectedIndexChanged(object sender, EventArgs e)
        {
            ErrorMessage.Visible = false;
            GetRitTable();
            foreach (DataRow row in dataTable.Rows)
            {
                if (dataTable.Rows.IndexOf(row) == GridView1.SelectedIndex)
                {
                    EditTicketID.Value = (string)row["TicketID"];
                    EditClient.Text = (string)row["Client"];
                    EditProcess.Text = (string)row["Process"];
                    EditStatus.Text = (string)row["Status"];
                    EditICOwner.Text = (string)row["ICOwner"];
                    EditAssignedTo.Text = (string)row["AssignedTo"];
                    EditSeverity.Text = (string)row["Severity"];
                    EditOpenedOn.Value = Convert.ToString(Convert.ToDateTime(row["OpenedOn"]).ToString("yyyy-MM-dd hh:mm:ss")).Replace(' ', 'T');
                    EditLastActionOn.Value = Convert.ToString(Convert.ToDateTime(row["LastActionOn"]).ToString("yyyy-MM-dd hh:mm:ss")).Replace(' ', 'T');
                    EditLastActionTaken.Value = (string)row["LastActionTaken"];
                    EditNextActionReq.Value = (string)row["NextActionRequired"];

                    UpdateTicketID.InnerText = (string)row["TicketID"];
                    UpdateLastActionTaken.Value = (string)row["NextActionRequired"];
                    break;
                }
            }        
        }
        /// <summary>
        /// Function takes a connection string for the database to be connected to, the SQL command or query, isExecuteable(Stored procedure(true) or query(false) and string array containing the parameters
        /// The function with then execute the stored procedure or query and return a datatable.
        /// </summary>
        /// <param name="connString"></param>
        /// <param name="command"></param>
        /// <param name="isExacutable"></param>
        /// <param name="variables"></param>
        /// <returns></returns>
        public static System.Data.DataTable getSQLTable(string connString, string command, bool isExacutable, string[,] variables)
        {
            int variableValueInt = 0;
            bool variableValueBool = true;
            DateTime variableValueDateTime = new DateTime();

            System.Data.DataTable dt = new System.Data.DataTable();
            SqlConnection conn = new SqlConnection(connString);
            int loopcount = 0;
            try
            {
                conn.Open();

                //Executable Tables
                if (isExacutable)
                {
                    SqlCommand execCommand = new SqlCommand(command, conn);
                    execCommand.CommandType = CommandType.StoredProcedure;

                    try
                    {
                        for (int i = 0; i < (variables.GetLength(0)); i++)
                        {
                            string variableName = variables[i, 0];

                            if (int.TryParse(variables[i, 1], out variableValueInt))
                            {
                                execCommand.Parameters.Add(variableName, SqlDbType.Int).Value = variableValueInt;
                            }else if (DateTime.TryParse(variables[i, 1], out variableValueDateTime))
                            {
                                execCommand.Parameters.Add(variableName, SqlDbType.DateTime).Value = variableValueDateTime;
                            }else if (bool.TryParse(variables[i, 1], out variableValueBool))
                            {
                                execCommand.Parameters.Add(variableName, SqlDbType.Bit).Value = variableValueBool;
                            }else
                            {
                                execCommand.Parameters.Add(variableName, SqlDbType.NVarChar).Value = variables[i, 1];
                            }
                        }
                    }
                    catch(Exception e)
                    {
                        MessageBox.Show(e.ToString());
                    }

                    loopcount = 0;
                    while (loopcount < 5)
                    {
                        try
                        {
                            dt.Load(execCommand.ExecuteReader());
                            break;
                        }
                        catch (Exception e) {
                            MessageBox.Show(e.ToString());
                        }
                        loopcount++;
                    }

                }
                //Select Statement Tables
                else if (!isExacutable)
                {
                    SqlCommand command2 = new SqlCommand(command, conn);
                    SqlDataAdapter da = new SqlDataAdapter(command2);

                    loopcount = 0;
                    while (loopcount < 5)
                    {
                        try
                        {
                            da.Fill(dt);
                            break;
                        }
                        catch (Exception e) { MessageBox.Show(e.ToString()); }
                        loopcount++;
                    }
                }
            }
            catch { }

            try { conn.Close(); } catch { }

            return dt;
        }
        /// <summary>
        /// Data validation to prevent users entering future dates
        /// </summary>
        /// <param name="dates"></param>
        /// <returns></returns>
        private bool checkDate(string[,] dates)
        {
            bool validDate = true;
            foreach (string dateTime in dates) {
                DateTime convertedDate = DateTime.Parse(dateTime);
                if (convertedDate > DateTime.Now)
                {
                    validDate = false;
                    ErrorMessage.InnerText = "Error: You have entered a date in the future.";
                    ErrorMessage.Visible = true;
                    return validDate;
                }  
            }
            return validDate;
        }
        //SQL Update/Insert Scripts
        public static void sqlUpdates(string connString, string command)
        {
            SqlConnection conn = new SqlConnection(connString);
            SqlCommand sqlCommand = conn.CreateCommand();

            try
            {
                conn.Open();
                sqlCommand.Connection = conn;
                sqlCommand.CommandText = command;
                sqlCommand.ExecuteNonQuery();
            }
            catch { }

            try { conn.Close(); } catch { }

        }
        /// <summary>
        /// Currently In development
        /// TODO: Add inout validation for data inputs to restrict empty values or invalid inputs
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Button1_Click(object sender, EventArgs e)
        {
            string[,] datesToCheck = new string[,]
           {
                {UpdateLastActionOn.Value.ToString()}
           };
            if (GridView1.SelectedIndex != -1) //&& checkDate(datesToCheck)
            {
                string[,] sqlVariables = new string[,]
                {
                        {"@TicketID",UpdateTicketID.InnerText},
                        {"@LastActionOn",UpdateLastActionOn.Value},
                        {"@LastActionTaken",UpdateLastActionTaken.Value},
                        {"@NextActionRequired",UpdateNextActionReq.Value},
                        {"@EditedBy",Environment.UserName} };
                dataTable = getSQLTable(strRitConnection, "UpdateIncident", true, sqlVariables);
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                ErrorMessage.InnerText = "Error: Please select a row before attempting to add a next action!";
                ErrorMessage.Visible = true;
            }
        }
    }
}




