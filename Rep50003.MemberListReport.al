report 50003 "Member List Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    
    DefaultLayout = RDLC;
    
    RDLCLayout = 'Layouts\MemberList.rdlc';

    dataset
    {
        dataitem(DataItemName; Customer)
        {
            RequestFilterFields="No.","Member Type","Employer Code";
            column(No_; "No.")
            {

            }

            column(Name; Name)
            {

            }

            column(Address; Address)
            {

            }

            column(Sacco_no; "Sacco no")
            {

            }
            column(Shares_Retained;"Shares Retained")
            {

            }
            column(Current_Shares; "Current Shares")
            {

            }

            column(Xmas_Contribution; "Xmas Contribution")
            {


            }
            column(CompInfPicture; CompInf.Picture)
            {


            }
            column(CompInfName; CompInf.Name)
            {


            }
            column(CompInfAddress; CompInf.Address)
            {


            }
            column(CompInfCity; CompInf.City)
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
        CompInf.get();
        CompInf.CalcFields(Picture)
    end;

    var
        myInt: Integer;
        ProjectCode: Code[60];

        CompInf: record "Company Information";
}