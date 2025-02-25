//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50093 "Funds Transfer Card"
{
    PageType = Card;
    SourceTable = "Funds Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Name"; Rec."Paying Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Transfer(LCY)"; Rec."Amount to Transfer(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount"; Rec."Total Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount(LCY)"; Rec."Total Line Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque/Doc. No"; Rec."Cheque/Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24; "Funds Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Transfer")
            {
                ApplicationArea = Basic;
                Caption = 'Post Transfer';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    Rec.CalcFields(Rec."Total Line Amount");
                    Rec.TestField(Rec."Amount to Transfer", Rec."Total Line Amount");




                    //IF Status<>Status::Approved THEN ERROR('Document must be approved before Posting');
                    //  if FundsUser.Get(UserId) then begin
                    //FundsUser.TestField(FundsUser."FundsTransfer Template Name");
                    //FundsUser.TestField(FundsUser."FundsTransfer Batch Name");
                    JTemplate := 'GENERAL'; //FundsUser."FundsTransfer Template Name";
                    JBatch := 'PAYMENTS';//FundsUser."FundsTransfer Batch Name";
                                         //Post Transfer
                    FundsManager.PostFundsTransfer(Rec, JTemplate, JBatch);
                    //  end else begin
                    //    Error('User Account Not Setup, Contact the System Administrator');
                    //  end; 

                    /*
                    //Print Here
                    FHeader.RESET;
                    FHeader.SETRANGE(FHeader."No.","No.");
                    IF FHeader.FINDFIRST THEN
                       Report.run(515102011,TRUE,TRUE,FHeader);
                    //End Print Here
                    */

                end;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*FHeader.RESET;
                    FHeader.SETRANGE(FHeader."No.","No.");
                    IF FHeader.FINDFIRST THEN BEGIN
                      REPORT.RUNMODAL(REPORT::"Funds Transfer Voucher",TRUE,FALSE,FHeader);
                    END;
                    */

                    FHeader.Reset;
                    FHeader.SetRange(FHeader."No.", Rec."No.");
                    if FHeader.FindFirst then
                        Report.run(515102011, true, true, FHeader);

                end;
            }
            separator(Action1000000005)
            {
                Caption = '-';
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::FundsTransfer;
                    ApprovalEntries.SetRecordFilters(Database::"Funds Transfer Header", DocumentType, Rec."No.");
                    ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    //IF ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) THEN
                    //      ApprovalsMgmt.OnSendSaccoTransferForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin

                    if Confirm('Are you sure you want to cancel this approval request', false) = true then begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                end;
            }
            separator(Action1000000001)
            {
                Caption = '       -';
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Pay Mode":="Pay Mode"::Cash;
        Rec."Transfer Type" := Rec."transfer type"::InterBank;
    end;

    var
        FundsManager: Codeunit "Funds Management";
        FundsUser: Record "Funds User Setup";
        JTemplate: Code[50];
        JBatch: Code[50];
        FHeader: Record "Funds Transfer Header";
        FLine: Record "Funds Transfer Lines";
        DocumentType: enum "Approval Document Type";

    procedure CheckRequiredItems()
    begin
        Rec.TestField(Rec."Posting Date");
        Rec.TestField("Paying Bank Account");
        Rec.TestField("Amount to Transfer");
        Rec.TestField("Global Dimension 2 Code");
        if Rec."Pay Mode" = Rec."pay mode"::Cheque then
            Rec.TestField("Cheque/Doc. No");
        Rec.TestField(Description);
        //TESTFIELD("Transfer To");

        FLine.Reset;
        FLine.SetRange(FLine."Document No", Rec."No.");
        FLine.SetFilter(FLine."Amount to Receive", '<>%1', 0);
        if FLine.FindSet then begin
            repeat
                FLine.TestField(FLine."Receiving Bank Account");
            until FLine.Next = 0;
        end;
    end;
}




