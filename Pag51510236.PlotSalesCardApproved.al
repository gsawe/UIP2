page 51510236 "Plot Sales Card Approved"
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
                //SubPageLink = "Table ID"=CONST(515102004),
                //                              "No."=FIELD("Plot No");
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
                RunPageLink = "Customer No" = FIELD("Customer No"),
                              "Project Code" = FIELD("Project Code"),
                              "Plot No" = FIELD("Plot No");
            }
            action("Add Customer")
            {
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Add Customer";
                RunPageLink = "Project Code" = FIELD("Project Code"),
                              "Plot No" = FIELD("Plot No");
            }
            action("Add Signatories")
            {
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Sales Signitories";
                RunPageLink = "Project Code" = FIELD("Project Code"),
                              "Plot No" = FIELD("Plot No");
            }
            action("Add Contact Person")
            {
                Ellipsis = true;
                Image = AddContacts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Contact Person Sales";
                RunPageLink = "Document Number" = FIELD("Customer No"),
                              "Project Code" = FIELD("Project Code"),
                              "Plot Number" = FIELD("Plot No");
            }
            action(Receipt)
            {
                Ellipsis = true;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Receipts Card";
                RunPageLink = "Customer No" = FIELD("Customer No"),
                              "Project Code" = FIELD("Project Code"),
                              "Plot No" = FIELD("Plot No");
            }
            action(Attachments)
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Documents;
                //RunPageLink = Rec."Doc No."=FIELD(No);
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
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Sold;
                            Plots."Sold By" := UserId;
                            Plots.Modify;
                        end;
                        Rec.Status := Rec.Status::Posted;
                        Rec.Modify;
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

                        Rec.CalcFields(Rec."Amount Paid");
                        bal := Rec."Amount Payable" - Rec."Amount Paid";
                        amtpermonth := Round(bal / Rec."Payment Period", 1, '=');
                        loop := 1;
                        repeat
                            PaymentPlan.Init;
                            PaymentPlan."Customer No" := Rec."Customer No";
                            PaymentPlan."Project Code" := Rec."Project Code";
                            PaymentPlan."Plot No" := Rec."Plot No";
                            dateloop := loop - 1;
                            dateloopstring := '+' + Format(dateloop) + 'M';
                            if loop = 1 then
                                PaymentPlan.Date := Today
                            else
                                PaymentPlan.Date := CalcDate(dateloopstring, Today);

                            if loop < Rec."Payment Period" then
                                PaymentPlan.Amount := amtpermonth
                            else
                                PaymentPlan.Amount := bal;
                            bal := bal - PaymentPlan.Amount;
                            PaymentPlan.Balance := bal;
                            PaymentPlan.Insert;
                            loop := loop + 1;
                        until loop > Rec."Payment Period";
                        Message('Payment plan generated successfully');
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
                    if Rec."Approval Status" <> Rec."Approval Status"::Approved then
                        Error('This document should first be approved  to view Sales Agreement.');
                    SaleOffer.Reset;
                    SaleOffer.SetRange("Customer No", Rec."Customer No");
                    SaleOffer.SetRange("Project Code", Rec."Project Code");
                    SaleOffer.SetRange("Plot No", Rec."Plot No");
                    if SaleOffer.FindFirst then
                        REPORT.Run(80037, true, false, SaleOffer);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = false;

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
                    VarVariant := Rec;
                    // if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
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
                    //  CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
        }
    }

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
}

