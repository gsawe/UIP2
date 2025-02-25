page 51510207 "Receipts"
{
    CardPageID = "Receipts Card";
    PageType = List;
    SourceTable = Receipts;
    SourceTableView = WHERE(Status = FILTER(<> Posted));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Plot No"; Rec."Plot No")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Approval Status"; Rec."Approval Status")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Payment Method"; Rec."Payment Method")
                {
                }
                field("Reference Code"; Rec."Reference Code")
                {
                }
                field("Payment Date"; Rec."Payment Date")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Post)
            {
                Caption = 'Post';
                action(Receipt)
                {
                    ApplicationArea = All;
                    Caption = 'Receipt';
                    Enabled = PrintEnabled;
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        Sale.Reset;
                        Sale.SetRange(Sale."Customer No", Rec."Customer No");
                        Sale.SetRange(Sale."Plot No", Rec."Plot No");
                        Sale.SetRange(Sale."Joint Sale", false);
                        if Sale.FindFirst then begin
                            Receipt.Reset;
                            Receipt.SetRange(Receipt."Customer No", Rec."Customer No");
                            Receipt.SetRange(Receipt."Project Code", Rec."Project Code");
                            Receipt.SetRange(Receipt."Plot No", Rec."Plot No");
                            if Receipt.FindFirst then
                                REPORT.Run(80043, true, false, Receipt);
                        end else begin
                            Receipt.Reset;
                            Receipt.SetRange(Receipt."Customer No", Rec."Customer No");
                            Receipt.SetRange(Receipt."Project Code", Rec."Project Code");
                            Receipt.SetRange(Receipt."Plot No", Rec."Plot No");
                            if Receipt.FindFirst then
                                REPORT.Run(80047, true, false, Receipt);
                        end;
                    end;
                }
                action("Revenue Report")
                {
                    // RunObject = Report "Revenue Report";
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        PrintEnabled := false;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            PrintEnabled := true;
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if UserSetup."Sales Executive" = true then begin
            Rec.FilterGroup(2);
            Rec.SetRange("User ID", UserId);
            //FILTERGROUP(0);
        end;

        if (UserSetup."Sales Manager" = true) or (UserSetup."Branch Manager" = true) then begin
            if Rec.FindFirst then
                repeat

                    //  REPEAT
                    if (Rec."User ID" = UserId) or (Rec."User Sales Manager" = UserId) or (Rec."User Branch Manager" = UserId) then
                        Rec.Mark(true);

                until Rec.Next = 0;
            Rec.MarkedOnly(true);
        end;
    end;

    var
        UserSetup: Record "User Setup";
        Receipt: Record Receipts;
        Sale: Record "Sale/Offer";
        Customer: Record Customer;
        PrintEnabled: Boolean;
}

