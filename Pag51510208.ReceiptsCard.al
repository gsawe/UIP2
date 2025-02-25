page 51510208 "Receipts Card"
{
    PageType = Card;
    SourceTable = Receipts;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No"; Rec."Customer No")
                {
                    Editable = ReceiptEditable;
                }
                field("Project Code"; Rec."Project Code")
                {
                    Editable = ReceiptEditable;
                }
                field("Plot No"; Rec."Plot No")
                {
                    Editable = ReceiptEditable;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = ReceiptEditable;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    Editable = ReceiptEditable;
                }
                field("Reference Code"; Rec."Reference Code")
                {
                    Editable = ReceiptEditable;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    Editable = ReceiptEditable;
                }
                field(Comment; Rec.Comment)
                {
                    Editable = ReceiptEditable;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("User Sales Manager"; Rec."User Sales Manager")
                {
                }
                field("User Branch Manager"; Rec."User Branch Manager")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                        Error('Kindly send the receipt for approval before posting.');
                    if Confirm('Are you sure you want to post') then begin

                        Rec.Status := Rec.Status::Posted;
                        Rec.Modify;
                        Message('Posted successfully');
                    end;
                    exit;
                end;
            }
            action(Attachments)
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Documents;
                //RunPageLink = "Doc No."=FIELD(Key);
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action("Send A&pproval Request")
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text001: Label 'This Batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField("Approval Status", "Approval Status"::Open);
                    Rec.TestField("Reference Code");
                    Rec.TestField("Payment Date");
                    Rec.TestField(Amount);
                    //IF "Approval Status"="Approval Status"::"Pending Approval" THEN
                    //ERROR('Receipt is already pending approval.');
                    Rec.CalcFields(Staff);
                    if Rec.Staff = false then begin
                        VarVariant := Rec;
                        //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        // CustomApprovals.OnSendDocForApproval(VarVariant);
                    end else begin
                        UserSetup.Get(UserId);
                        if UserSetup.Administrator = true then begin
                            Rec.Status := Rec.Status::Posted;
                            Rec."Approved By" := UserId;
                            Rec."Approved Date" := Today;
                            Rec.Modify;
                            Message('Receipt updated successfully.');
                        end else begin
                            Error('You need to be setup as adminstrator to post staff receipts.');
                        end;

                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    //VarVariant := Rec;
                    //CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    if Confirm('Are you sure you want to cancel this document?', true, false) = true then begin
                        Rec.Status := Rec.Status::New;
                        Rec."Approval Status" := Rec."Approval Status"::Open;
                        Rec.Modify;
                        Message('Document canceled.');
                    end;
                end;
            }
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

    trigger OnAfterGetCurrRecord()
    begin
        ReceiptEditable := true;
        if Rec."Approval Status" <> Rec."Approval Status"::Open then
            ReceiptEditable := false;
        PrintEnabled := false;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            PrintEnabled := true;
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;
        //CustomApprovals: Codeunit "Custom Approvals Codeunits";
        UserSetup: Record "User Setup";
        Receipt: Record Receipts;
        Sale: Record "Sale/Offer";
        Customer: Record Customer;
        ReceiptEditable: Boolean;
        PrintEnabled: Boolean;
}

