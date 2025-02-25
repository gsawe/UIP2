report 50000 "Projects Listing"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\ProjectsListing.rdlc';
    dataset
    {
        dataitem(DataItemName; Projects)
        {
            RequestFilterFields="Project Name";
            column(Project_Name; "Project Name")
            {

            }
            column(Cost; Cost)
            {

            }
            column(Name; Name)
            {

            }
            column(No_of_Plots; "No of Plots")
            {

            }

            column(Plot_Size; "Plot Size")
            {

            }
            column(CompInf_Name; CompInf.Name)
            {

            }
            column(CompInf_Address; CompInf.Address)
            {

            }

            column(CompInf_City; CompInf.City)
            {

            }

            column(CompInf_Telephone; CompInf."Phone No.")
            {

            }

                       column(CompInf_Picture; CompInf.Picture)
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
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        ProjectCode: Code[40];
        CompInf: Record "Company Information";
}