//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50090 "Receipt Header Card"
{
    PageType = Card;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted = const(false));

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque No.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount Received"; Rec."Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Received(LCY)"; Rec."Amount Received(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount(LCY)"; Rec."Total Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("On Behalf of"; Rec."On Behalf of")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control23; "Receipt Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post and Print Receipt")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckReceiptRequiredFields;
                    CheckLines;
                    DocNo := Rec."No.";

                    ok := Confirm('Post Receipt No:' + Format(Rec."No.") + '?');
                    if ok then begin
                       // if FundsUser.Get(UserId) then begin
                            //FundsUser.TestField(FundsUser."Receipt Journal Template");
                            //FundsUser.TestField(FundsUser."Receipt Journal Batch");
                            JTemplate :='GENERAL'; //FundsUser."Receipt Journal Template";
                            JBatch :='PAYMENTS';// FundsUser."Receipt Journal Batch";
                            FundsManager.PostReceipt(Rec, JTemplate, JBatch);
                            Commit;
                            //Print Receipt
                            ReceiptHeader.Reset;
                            ReceiptHeader.SetRange(ReceiptHeader."No.", DocNo);
                            if ReceiptHeader.FindFirst then begin
                                //  Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                            end;
                        //end else begin
                           // Error('User Account Not Setup');
                        //end;
                    end;
                end;
            }
            action("Print Receipt")
            {
                ApplicationArea = Basic;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                // trigger OnAction()
                // begin
                //     //Print Receipt
                //     ReceiptHeader.Reset;
                //     ReceiptHeader.SetRange(ReceiptHeader."No.", "No.");
                //     if ReceiptHeader.FindFirst then begin
                //         Report.RunModal(Report::"Receipt Header", true, false, ReceiptHeader);
                //     end;
                // end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Pay Mode" := Rec."pay mode"::Cash;
        Rec."Global Dimension 1 Code" := 'BOSA';
    end;

    var
        BillNoVisible: Boolean;
        AccNoVisible: Boolean;
        ok: Boolean;
        ReceiptLine: Record "Receipt Lines";
        LineNo: Integer;
        FundsTransTypes: Record "Funds Transaction Types";
        Amount: Decimal;
        "Amount(LCY)": Decimal;
        ReceiptLines: Record "Receipt Lines";
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        PostingVisible: Boolean;
        MoveVisible: Boolean;
        PageEditable: Boolean;
        ReverseVisible: Boolean;
        DocNo: Code[20];
        ReceiptHeader: Record "Receipt Header";
        BankAcc: Record "Bank Account";

    local procedure CheckReceiptRequiredFields()
    begin
        Rec.CalcFields(Rec."Total Amount");

        Rec.TestField(Rec."Total Amount");
        Rec.TestField(Rec."Amount Received");
        Rec.TestField(Rec."Bank Code");
        Rec.TestField(Rec.Date);
        Rec.TestField(Rec."Posting Date");
        // TESTFIELD(Description);
        //TESTFIELD("Received From");
        //TESTFIELD("Global Dimension 1 Code");
        //TESTFIELD("Global Dimension 2 Code");

        if Rec."Amount Received" <> Rec."Total Amount" then
            Error('Amount Received must be Equal to the total Amount');

        if Rec."Currency Code" = '' then begin
            if BankAcc.Get(Rec."Bank Code") then
                BankAcc.TestField(BankAcc."Currency Code", '');
        end;
    end;

    local procedure CheckLines()
    begin
        ReceiptLines.Reset;
        ReceiptLines.SetRange(ReceiptLines."Document No", Rec."No.");
        if ReceiptLines.FindSet then begin
            repeat
                ReceiptLines.TestField(ReceiptLines."Account Code");
                ReceiptLines.TestField(ReceiptLines."Account Code");
                ReceiptLines.TestField(ReceiptLines.Amount);
            until ReceiptLines.Next = 0;
        end else begin
            Error('Empty Receipt Lines');
        end;
    end;
}




