//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80004 "Posted Petty Cash Payments"
{
    CardPageID = "Cash Payment Header";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable=false;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const("Petty Cash"),
                            Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)"; Rec."Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
               area(processing)
        {
            action(PrintNew)
            {
                ApplicationArea = Basic;
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject=report "Petty Cash Report";
                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);
                    /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                       ERROR('You cannot Print until the document is Approved'); */

                      

                    /*RESET;
                    SETRANGE("No.","No.");
                    IF "No." = '' THEN
                      REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                    ELSE
                      REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                    RESET;
                    */

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."payment type"::"Cash Purchase";
        if FundsSetup.Get then begin
            FundsSetup.TestField(FundsSetup."Cash Account");
            Rec."Bank Account" := FundsSetup."Cash Account";
            Rec.Validate("Bank Account");
        end;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
    end;

    var
        FundsSetup: Record "Funds General Setup";
}




