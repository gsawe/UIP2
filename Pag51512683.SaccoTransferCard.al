//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51512683 "Sacco Transfer Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDateEditable;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = VarMemberNoEditable;
                    Visible = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = RemarkEditable;
                }
                field("Source Account Type"; Rec."Source Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type"; Rec."Source Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;

                    trigger OnValidate()
                    begin
                        SourceLoanVisible := false;
                        if (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Charged") or
                            (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Paid") or
                            (Rec."Source Transaction Type" = Rec."source transaction type"::Repayment) or
                            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Due") or
                            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Paid")
                          then begin
                            SourceLoanVisible := true;
                        end;
                    end;
                }
                group(DepositDebitType)
                {
                    Caption = 'Deposit Debit Type';
                    Visible = DepositDebitTypeVisible;
                }
                field("Source Loan No"; Rec."Source Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = SourceLoanNoEditable;
                    Visible = SourceLoanVisible;
                }
                field("Header Amount"; Rec."Header Amount")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Charge Transfer Fee"; Rec."Charge Transfer Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transfer Fee"; Rec.GetTransferFee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NetTransferable; Rec.NetTransferable)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
            part(Control1102760014; "Sacco Transfer Schedule")
            {
                SubPageLink = "No." = field(No);
            }
        }
        area(factboxes)
        {

            // part(Control1; "Member Statistics FactBox")
            // {
            //     Caption = 'BOSA Statistics FactBox';
            //     SubPageLink = "No." = field("Source Account No.");
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        Rec.TestField("Transaction Description");
                        if ((Rec."Schedule Total" > Rec."Header Amount") and (Rec.Refund)) then
                            Error('Scheduled Amount must be less or equal to Header Amount!');

                        if ((Rec."Schedule Total" > Rec."Header Amount") and
                          (not ((Rec."Source Transaction Type" = Rec."source transaction type"::Repayment)
                          or (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Paid") or (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Penalty Charged")))) then
                            Error('Scheduled Amount must be less or equal to Header Amount!');
                        if FnLimitNumberOfTransactions() then
                            Error(Txt0001);
                        /*                         if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                                                    ApprovalsMgmt.OnSendSaccoTransferForApproval(Rec); */
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Enabled = CanCancelApprovalFOrRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        /*   if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                              ApprovalsMgmt.OnCancelSaccoTransferApprovalRequest(Rec); */
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::SaccoTransfers;
                        ApprovalEntries.SetRecordFilters(Database::"Sacco Transfers", DoctypeEnum, Rec.No);
                        ApprovalEntries.Run;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post & Print';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SaccoGeneralSetUp: Record "Sacco General Set-Up";
                        TransferFee: Decimal;
                        CalculatedTransferFee: Decimal;
                        ScheduleAmt: Decimal;
                    begin
                        if FundsUSer.Get(UserId) then begin
                            Jtemplate := FundsUSer."Payment Journal Template";
                            Jbatch := FundsUSer."Payment Journal Batch";
                        end;
                        if Rec.Posted = true then
                            Error('This Shedule is already posted');

                        if Confirm('Are you sure you want to transfer schedule?', false) = true then begin

                            /*IF "Source Transaction Type"="Source Transaction Type"::"Share Capital" THEN BEGIN
                              //IF "Receipt No"='' THEN
                              //  ERROR('Please enter receipt Number to confirm transfer');
                              //TESTFIELD("Receipt No");
                              END;
                              */


                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", Jbatch);
                            GenJournalLine.DeleteAll;

                            //Transfer Charge
                            if Rec."Charge Transfer Fee" = true then begin
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := Jbatch;
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Account No." := Rec."Source Account No.";
                                GenJournalLine."Loan No" := Rec."Source Loan No";
                                GenJournalLine."Posting Date" := Rec."Transaction Date";

                                SaccoGeneralSetUp.Get;
                                SaccoGeneralSetUp.TestField("Internal Transfer Fee");
                                SaccoGeneralSetUp.TestField("Internal Transfer Fee Account");
                                TransferFee := ROUND(Rec.TransferCharges, 0.05, '=');

                                GenJournalLine.Amount := TransferFee;
                                //MESSAGE(FORMAT(TransferFee));
                                GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := SaccoGeneralSetUp."Internal Transfer Fee Account";
                                GenJournalLine.Description := 'Transfer Charges' + Rec."Transaction Description";//+' '+"Source Account No.";
                                GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                GenJournalLine.Insert;
                            end;
                            //END;

                            //END Transer Charge

                            //Recovery Charges
                            /*IF "Charge Transfer Fee"= TRUE THEN BEGIN
                                  GenJournalLine.INIT;
                                  GenJournalLine."Journal Template Name":=Jtemplate;
                                  GenJournalLine."Journal Batch Name":=Jbatch;
                                  GenJournalLine."Document No.":=No;
                                  GenJournalLine."Line No.":=GenJournalLine."Line No."+10000;
                                  GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
                                  GenJournalLine."Account No.":="Source Account No.";
                                  GenJournalLine."Loan No":="Source Loan No";
                                  GenJournalLine."Posting Date":="Transaction Date";

                                    SaccoGeneralSetUp.GET;
                                    SaccoGeneralSetUp.TESTFIELD("Internal Transfer Fee");
                                    SaccoGeneralSetUp.TESTFIELD("Internal Transfer Fee Account");
                                    TransferFee:=ROUND(TransferCharges,0.05,'=');

                                  GenJournalLine.Amount := TransferFee;
                                  //MESSAGE(FORMAT(TransferFee));
                                  GenJournalLine."Amount (LCY)":=GenJournalLine.Amount;
                                  GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                  GenJournalLine."Bal. Account No.":=SaccoGeneralSetUp."Internal Transfer Fee Account";
                                  GenJournalLine.Description:='Transfer Charges'+"Transaction Description";//+' '+"Source Account No.";
                                  GenJournalLine."Transaction Type":="Source Transaction Type";
                                  GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                  GenJournalLine."Shortcut Dimension 2 Code":=BTRANS."Global Dimension 2 Code";
                                  GenJournalLine.INSERT;
                            END;
                            */
                            //End Recovery Charges



                            // UPDATE Source Account
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Document No." := Rec.No;
                            GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";
                            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
                            if Rec."Source Account Type" = Rec."source account type"::Customer then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                GenJournalLine."Account No." := Rec."Source Account No.";
                                GenJournalLine."Loan No" := Rec."Source Loan No";
                            end else
                                if Rec."Source Account Type" = Rec."source account type"::Customer then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                    GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                    GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                    GenJournalLine."Account No." := Rec."Source Account No.";
                                    GenJournalLine."Loan No" := Rec."Source Loan No";
                                end else

                                    if Rec."Source Account Type" = Rec."source account type"::MWANANGU then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                        GenJournalLine."Account No." := Rec."Source Account No.";
                                    end else
                                        if Rec."Source Account Type" = Rec."source account type"::"G/L ACCOUNT" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Transaction Type" := Rec."Source Transaction Type";
                                            GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                            GenJournalLine."Account No." := Rec."Source Account No.";
                                        end else
                                            if Rec."Source Account Type" = Rec."source account type"::Bank then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                                GenJournalLine."Account No." := Rec."Source Account No.";
                                            end;
                            GenJournalLine."Posting Date" := Rec."Transaction Date";
                            GenJournalLine.Description := Rec."Transaction Description";//+' '+"Source Account No.";
                            Rec.CalcFields("Schedule Total");
                            ScheduleAmt := Rec."Schedule Total";
                            //IF "Charge Transfer Fee" THEN ScheduleAmt:=NetTransferable;
                            GenJournalLine.Amount := ScheduleAmt;
                            GenJournalLine."Amount (LCY)" := ScheduleAmt;

                            GenJournalLine.Insert;




                            BSched.Reset;
                            BSched.SetRange(BSched."No.", Rec.No);
                            if BSched.Find('-') then begin
                                repeat

                                    GenJournalLine.Init;

                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := Rec.No;
                                    GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;

                                    if BSched."Destination Account Type" = BSched."destination account type"::CUSTOMER
                                     then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Transaction Type" := BSched."Destination Type";
                                        GenJournalLine."Account No." := BSched."Destination Account No.";
                                        GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";
                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                    end else

                                        if BSched."Destination Account Type" = BSched."destination account type"::VENDOR
                                           then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            if ObjVendors.Get(Rec."Source Account No.") then begin
                                                ObjVendors.CalcFields(Balance);
                                                if ObjVendors.Balance < 0 then
                                                    Error('Account has insufficient Balance');
                                            end;
                                            GenJournalLine."Transaction Type" := BSched."Destination Type";
                                            GenJournalLine."Account No." := BSched."Destination Account No.";
                                            GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                        end else
                                            if BSched."Destination Account Type" = BSched."destination account type"::"G/L ACCOUNT" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := BSched."Destination Account No.";
                                                GenJournalLine."Shortcut Dimension 2 Code" := '01';
                                                GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";

                                            end else
                                                if BSched."Destination Account Type" = BSched."destination account type"::BANK then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                    GenJournalLine."Account No." := BSched."Destination Account No.";
                                                    GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";
                                                    GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                                end;
                                    GenJournalLine."Loan No" := BSched."Destination Loan";
                                    GenJournalLine.Validate(GenJournalLine."Loan No");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Rec."Transaction Date";
                                    GenJournalLine.Description := Rec."Transaction Description" + ' ' + Rec."Source Account No.";
                                    GenJournalLine.Amount := -BSched.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Insert;
                                until BSched.Next = 0;
                            end;



                            //Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                            if GenJournalLine.Find('-') then begin
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                            end;

                            //Post
                            Rec.Posted := true;
                            Rec.Modify;
                            //MESSAGE('Transaction posted succesfully');

                        end;
                        /*BTRANS.RESET;
                        BTRANS.SETRANGE(BTRANS.No,No);
                        IF BTRANS.FIND('-') THEN
                         */
                        //Print
                        /*
                       BTRANS.RESET;
                        BTRANS.SETRANGE(BTRANS.No,No);
                        IF BTRANS.FIND('-') THEN BEGIN
                        Report.run(172902,TRUE,TRUE,BTRANS);
                        END;*/

                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, Rec.No);
                        if BTRANS.Find('-') then begin
                            Report.run(172902, true, true, BTRANS);
                        end;
                    end;
                }
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                // RunObject = Page "Members Statistics";
                //RunPageLink = "No." = field(Rec."Source Account No.");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        ApprovalsmgtBase: Codeunit "Approvals Mgmt.";
    begin
        AddRecordRestriction();

        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsmgtBase.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalFOrRecord := ApprovalsmgtBase.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalFOrRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;
        if Rec.Status = Rec.Status::Approved then
            EnablePost := true;
        SourceLoanVisible := false;
        if (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Charged") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Paid") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::Repayment) or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Due") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
        DepositDebitTypeVisible := false;
        if Rec."Source Transaction Type" = Rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        //"Transaction Date":=TODAY;
        //MODIFY;
    end;

    trigger OnAfterGetRecord()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if Rec."Source Transaction Type" = Rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        SourceLoanVisible := false;
        if (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Charged") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Paid") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::Repayment) or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Due") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnOpenPage()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if Rec."Source Transaction Type" = Rec."source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        SourceLoanVisible := false;
        if (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Charged") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Loan Insurance Paid") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::Repayment) or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Due") or
            (Rec."Source Transaction Type" = Rec."source transaction type"::"Interest Paid")
          then begin
            SourceLoanVisible := true;
        end;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Sacco Transfers Schedule";
        BTRANS: Record "Sacco Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DoctypeEnum: Enum "Approval Document Type";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        ObjSaccoTransfers: Record "Sacco Transfers";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalFOrRecord: Boolean;
        EnablePost: Boolean;
        Txt0001: label 'You cannot transfer another amount before three months elapse. ';
        DepositDebitTypeVisible: Boolean;
        ObjGensetup: Record "Sacco General Set-Up";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarExciseDuty: Decimal;
        VarExciseDutyAccount: Code[30];
        VarDepositDebitTypeEditable: Boolean;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjMember: Record Customer;
        VarMemberNoEditable: Boolean;
        ObjLoans: Record "Loans Register";
        window: Dialog;
        SourceLoanVisible: Boolean;
        cust: Record Customer;

    local procedure AddRecordRestriction()
    begin
        if Rec.Status = Rec.Status::Open then begin
            SourceAccountNoEditbale := true;
            SourceAccountNameEditable := true;
            SourceAccountTypeEditable := true;
            SourceLoanNoEditable := true;
            SourceTransactionType := true;
            TransactionDateEditable := true;
            VarDepositDebitTypeEditable := true;
            VarMemberNoEditable := true;
            RemarkEditable := true
        end else
            if Rec.Status = Rec.Status::"Pending Approval" then begin
                SourceAccountNoEditbale := false;
                SourceAccountNameEditable := false;
                SourceAccountTypeEditable := false;
                SourceLoanNoEditable := false;
                SourceTransactionType := false;
                TransactionDateEditable := false;
                VarDepositDebitTypeEditable := false;
                VarMemberNoEditable := false;
                RemarkEditable := false
            end else
                if Rec.Status = Rec.Status::Approved then begin
                    SourceAccountNoEditbale := false;
                    SourceAccountNameEditable := false;
                    SourceAccountTypeEditable := false;
                    SourceLoanNoEditable := false;
                    SourceTransactionType := false;
                    TransactionDateEditable := false;
                    VarDepositDebitTypeEditable := false;
                    VarMemberNoEditable := false;
                    RemarkEditable := false;
                end;
    end;

    local procedure FnLimitNumberOfTransactions(): Boolean
    begin
        ObjSaccoTransfers.Reset;
        ObjSaccoTransfers.SetRange("Savings Account Type", 'NIS');
        ObjSaccoTransfers.SetRange("Source Account No.", Rec."Source Account No.");
        ObjSaccoTransfers.SetRange(Posted, true);
        ObjSaccoTransfers.SetCurrentkey(No);
        if ObjSaccoTransfers.FindLast then begin
            if (Rec."Transaction Date" - ObjSaccoTransfers."Transaction Date") > 30 then
                exit(true);
        end;
        exit(false);
    end;
}




