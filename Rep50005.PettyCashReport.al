report 50005 "Petty Cash Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    
    RDLCLayout = 'Layouts\PettyCashReport.rdlc';
    dataset
    {
        dataitem(DataItemName; "G/L Entry")
        {
            RequestFilterFields="Posting Date";
            DataItemTableView= where ("G/L Account No."=filter('12003'));
            column(Document_No_;"Document No." )
            {

            }
            column(Description; Description)
            {

            }
            column(Amount; amount)
            {

            }


            column(Posting_Date;"Posting Date")
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