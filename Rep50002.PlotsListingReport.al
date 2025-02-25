report 50002 "Plots Listing Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\PlotsList.rdlc';

    dataset
    {
        dataitem(DataItemName; Plots)
        {
            RequestFilterFields=Project,"Project Name";

            column(Project; Project)
            {

            }

            column(Project_Name; "Project Name")
            {

            }

            column(Client_Name; "Client Name")
            {

            }

            column(Outstanding_Balance; "Outstanding Balance")
            {

            }

            column(Plot_No; "Plot No")
            {

            }

            column(CompName; CompInfo.Name)
            {

            }

            column(CompAddress; CompInfo.Address)
            {

            }

            column(CompCity; CompInfo.City)
            {

            }

            column(CompPicture; CompInfo.Picture)
            {

            }

            column(CompPhone; CompInfo."Phone No.")
            {

            }

            column(Availability; Availability)
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
                    field(Name; ProjectCode)
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
        CompInfo.get();
        CompInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        ProjectCode: Code[40];
        CompInfo: Record "Company Information";
}