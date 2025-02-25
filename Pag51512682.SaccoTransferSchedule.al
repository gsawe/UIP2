//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512682 "Sacco Transfer Schedule"
{
    PageType = ListPart;
    SourceTable = "Sacco Transfers Schedule";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Registration Fee,Shares Capital,Interest Paid,Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Loan Penalty Charged,Loan Penalty Paid,HouseHold Savings,Housing Coop Shares,Utafiti Housing,Holiday Savings,Dependant 1 Savings,Dependant 2 Savings,Dependant 3 Savings,Interest on Deposits,Share Boost Fee,Rejoining Fee,Dormant Reactivation Fee';
                    // OptionMembers = " ","Registration Fee","Share Capital","Interest Paid",Repayment,"Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Loan Penalty Charged","Loan Penalty Paid","HouseHold Savings","Housing Coop Shares","Utafiti Housing","Holiday Savings","Dependant 1 Savings","Dependant 2 Savings","Dependant 3 Savings","Interest on Deposits","Share Boost Fee","Rejoining Fee","Dormant Reactivation Fee"

                    //;
                    //}
                    //OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Maono Housing,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Loan Penalty Charged,Loan Penalty Paid,Junior Savings,Safari Savings,Silver Savings';
                }
                field("Destination Loan"; Rec."Destination Loan")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Total Payment Loan"; Rec."Cummulative Total Payment Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SaccoHeader.Reset;
        SaccoHeader.SetRange(SaccoHeader.No, Rec."No.");
        if SaccoHeader.FindSet then begin
            if SaccoHeader.Status = SaccoHeader.Status::Open then begin
                CurrPage.Editable := true
            end else
                CurrPage.Editable := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        SaccoHeader.Reset;
        SaccoHeader.SetRange(SaccoHeader.No, Rec."No.");
        if SaccoHeader.FindSet then begin
            if SaccoHeader.Status = SaccoHeader.Status::Open then begin
                CurrPage.Editable := true
            end else
                if (SaccoHeader.Status = SaccoHeader.Status::"Pending Approval") or (SaccoHeader.Status = SaccoHeader.Status::"Pending Approval") then begin
                    CurrPage.Editable := false;
                end;
        end;
    end;

    var
        SaccoHeader: Record "Sacco Transfers";
}




