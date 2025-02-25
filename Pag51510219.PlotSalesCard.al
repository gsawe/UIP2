page 51510219 "Plot Sales Card"
{
    PageType = Card;
    SourceTable = "Sale/Offer";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Joint Name"; Rec."Joint Name")
                {
                    Caption = 'Name';
                    Editable = false;
                }
                field("Sale Type"; Rec."Sale Type")
                {
                }
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Plot No"; Rec."Plot No")
                {
                }
                field("Sale Amount"; Rec."Sale Amount")
                {
                }
                field(Discount; Rec.Discount)
                {
                }
                field("Installment Interest"; Rec."Installment Interest")
                {
                    Editable = false;
                }
                field("Amount Payable"; Rec."Amount Payable")
                {
                    Editable = false;
                }
                field(Financier; Rec.Financier)
                {
                }
                field("Payment Option"; Rec."Payment Option")
                {
                }
                field("Terms and Conditions"; Rec."Terms and Conditions")
                {
                }
                field("Payment Period"; Rec."Payment Period")
                {
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    Editable = false;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    Editable = false;
                }
                field(Balance; Rec."Amount Payable" - Rec."Amount Paid")
                {
                    Editable = false;
                }
                field("Schedule Amount"; Rec."Schedule Amount")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                }
                field("Agreement Start Date"; Rec."Agreement Start Date")
                {
                }
                field("Sales Agreement Approved"; Rec."Sales Agreement Approved")
                {
                }
            }
            part(Control22; "Payment Plan")
            {
                SubPageLink = "Customer No" = FIELD("Customer No"),
                              "Project Code" = FIELD("Project Code"),
                              "Plot No" = FIELD("Plot No");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                // SubPageLink = "Table ID"=CONST(515102004),
                // "No."=FIELD("Plot No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Witness)
            {
                Ellipsis = true;
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Witness;
                //RunPageLink = Rec."Customer No"=FIELD("Customer No"),
                // "Project Code"=FIELD("Project Code"),
                // "Plot No"=FIELD("Plot No");
            }
            action("Add Customer")
            {
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Add Customer";
                // RunPageLink = "Project Code"=FIELD("Project Code"),
                //"Plot No"=FIELD("Plot No");
            }
            action("Add Signatories")
            {
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 51510399;
                // RunPageLink = "Project Code"=FIELD("Project Code"),
                // "Plot No"=FIELD("Plot No");
            }
            action("Add Contact Person")
            {
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 51510321;
                //RunPageLink = "Document Number"=FIELD("Customer No"),
                // "Project Code"=FIELD("Project Code"),
                // "Plot Number"=FIELD("Plot No");
            }
            action(Receipt)
            {
                Ellipsis = true;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Page "Receipts Sales";
                //RunPageLink = "Customer No"=FIELD("Customer No"),
                // "Project Code"=FIELD("Project Code"),
                // "Plot No"=FIELD("Plot No");
            }
            action("New Receipt")
            {
                Caption = 'New Receipt';
                Ellipsis = true;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // RunObject = Page "Receipts Card Sales";
                //RunPageLink = "Customer No"=FIELD("Customer No"),
                //  "Project Code"=FIELD("Project Code"),
                // "Plot No"=FIELD("Plot No");
                RunPageMode = Create;
            }
            action(Attachments)
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Documents;
                //RunPageLink = "Doc No."=FIELD(No);
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post the same') then begin
                        Plots.Reset;
                        Plots.SetRange(Project, rec."Project Code");
                        Plots.SetRange("Plot No", rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Sold;
                            Plots."Sold By" := UserId;
                            Plots.Modify;
                        end;
                        rec.Status := rec.Status::Posted;
                        rec.Modify;
                        Message('Plot sold successfully');
                    end;
                end;
            }
            action("Generate Payment Plan")
            {
                Image = CapableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to generate the payment plan') then begin

                        rec.CalcFields("Amount Paid");
                        bal := rec."Amount Payable" - rec."Amount Paid";
                        amtpermonth := Round(bal / rec."Payment Period", 1, '=');
                        loop := 1;
                        repeat
                            PaymentPlan.Init;
                            PaymentPlan."Customer No" := rec."Customer No";
                            PaymentPlan."Project Code" := rec."Project Code";
                            PaymentPlan."Plot No" := rec."Plot No";
                            dateloop := loop - 1;
                            dateloopstring := '+' + Format(dateloop) + 'M';
                            if loop = 1 then
                                PaymentPlan.Date := Today
                            else
                                PaymentPlan.Date := CalcDate(dateloopstring, Today);

                            if loop < rec."Payment Period" then
                                PaymentPlan.Amount := amtpermonth
                            else
                                PaymentPlan.Amount := bal;
                            bal := bal - PaymentPlan.Amount;
                            PaymentPlan.Balance := bal;
                            PaymentPlan.Insert;
                            loop := loop + 1;
                        until loop > rec."Payment Period";
                        Message('Payment plan generated successfully');
                    end;
                end;
            }
            action("Generate Receipt")
            {
                Image = CapableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SaleOffer.Reset;
                    SaleOffer.SetRange("Customer No", rec."Customer No");
                    SaleOffer.SetRange("Project Code", rec."Project Code");
                    SaleOffer.SetRange("Plot No", rec."Plot No");
                    if SaleOffer.FindFirst then
                        REPORT.Run(80055, true, false, SaleOffer);
                end;
            }
            action("Release Plot")
            {
                Enabled = ReleasePlotEnabled;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Plots: Record Plots;
                begin
                    if Confirm('Are you sure you want to release this plot?', true, false) = true then begin
                        Plots.Reset;
                        Plots.SetRange(Plots.Project, rec."Project Code");
                        Plots.SetRange(Plots."Plot No", rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Available;
                            Plots."Released By" := UserId;
                            Plots.Modify;
                        end;

                        Receipt.Reset;
                        Receipt.SetRange(Receipt."Customer No", rec."Customer No");
                        Receipt.SetRange(Receipt."Project Code", rec."Project Code");
                        Receipt.SetRange(Receipt."Plot No", rec."Plot No");
                        if Receipt.FindFirst then begin
                            repeat
                                Receipt.Inactive := true;
                                Receipt.Modify;
                            until Receipt.Next = 0;
                        end;
                        rec."Is Active" := rec."Is Active"::NO;
                        rec.Modify;
                        Message('Plot has been successfully released.');
                    end;
                end;
            }
            action("Print Sales Agreement")
            {
                Caption = 'Print Sales Agreement';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SaleOffer.Reset;
                    SaleOffer.SetRange("Customer No", rec."Customer No");
                    SaleOffer.SetRange("Project Code", rec."Project Code");
                    SaleOffer.SetRange("Plot No", rec."Plot No");
                    if SaleOffer.FindFirst then
                        REPORT.Run(80037, true, false, SaleOffer);
                end;
            }
            action("Print Acknowledgement")
            {
                Image = Note;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //IF "Approval Status"<>"Approval Status"::Approved THEN
                    //ERROR('This document should first be approved  to view Sales Agreement.');
                    SaleOffer.Reset;
                    SaleOffer.SetRange("Customer No", rec."Customer No");
                    SaleOffer.SetRange("Project Code", rec."Project Code");
                    SaleOffer.SetRange("Plot No", rec."Plot No");
                    if SaleOffer.FindFirst then
                        REPORT.Run(80060, true, false, SaleOffer);
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
                    //TESTFIELD("Approval Status","Approval Status"::Open);
                    VarVariant := Rec;
                    //  if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                    //  CustomApprovals.OnSendDocForApproval(VarVariant);
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
                    VarVariant := Rec;
                    // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Customer No" <> '' then begin
            Customers.Reset;
            Customers.SetRange(Customers."Customer No", Rec."Customer No");
            Customers.SetRange(Customers."Project Code", Rec."Project Code");
            Customers.SetRange(Customers."Plot No", Rec."Plot No");
            if not Customers.FindFirst then begin
                Customers.Init;
                Customers."Customer No" := Rec."Customer No";
                Customers.Validate("Customer No");
                Customers."Plot No" := Rec."Plot No";
                Customers."Project Code" := Rec."Project Code";
                Customers.Insert(true);
            end;


        end;

        ReleasePlotEnabled := false;
        Usersetup.Get(UserId);
        if Usersetup."PLot Holding" = true then
            ReleasePlotEnabled := true;
    end;

    var
        Plots: Record Plots;
        PaymentPlan: Record "Payment Plan";
        bal: Decimal;
        amtpermonth: Decimal;
        loop: Integer;
        dateloop: Integer;
        dateloopstring: Text;
        SaleOffer: Record "Sale/Offer";
        ApprovalEntry: Record "Approval Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunits";
        Customers: Record "Added Customers";
        ReleasePlotEnabled: Boolean;
        Usersetup: Record "User Setup";
        Receipt: Record Receipts;
}

