report 50001 "Plots Register Balances"
{
    UsageCategory = ReportsAndAnalysis;

    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/PlotsRegister.rdlc';


    dataset
    {
        dataitem(DataItemName; "Plots Register")

        {
            DataItemTableView = where(Posted = filter(true));
            RequestFilterFields = Project, "Outstanding Balance";
            column(Project; Project)
            {

            }

            column(Project_Name; "Project name")
            {

            }
            column(Plot_No; "Plot No")
            {

            }
            column(Plot_Amount; "Plot Amount")
            {

            }
            column(Outstanding_Amount; "Outstanding Balance")
            {

            }
            column(Client_Code; "Client Code")
            {

            }
            column(Client_Name; "Client Name")
            {

            }

            column(CompPicture; CompInf.Picture)
            {

            }
            column(CompName; CompInf.Name)
            {

            }

            column(CompTelephone; CompInf."Phone No.")
            {

            }
            column(CompAddress; CompInf.Address)
            {

            }

            column(CompCity; CompInf.City)
            {

            }


        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(ProjectCode; ProjectCode)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompInf.GET();
        CompInf.CalcFields(Picture);
    end;


    var
        ProjectCode: code[40];
        CompInf: Record "Company Information";
        SerialNo: Integer;
}