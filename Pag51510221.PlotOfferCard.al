page 51510221 "Plot Offer Card"
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
                    Visible = false;
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
                field("Offer Start Date"; Rec."Offer Start Date")
                {
                }
                field("Payment Period"; Rec."Payment Period")
                {
                    Caption = 'Valid Field Offer Days';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Offer Expiry Date"; Rec."Offer Expiry Date")
                {
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
                field(Marketer; Rec.Marketer)
                {
                }
                field("User Sales Manager"; Rec."User Sales Manager")
                {
                }
                field("User Branch Manager"; Rec."User Branch Manager")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
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
                //  "No."=FIELD("Plot No");
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
                              "Plot No" = FIELD("Plot No"),
                              "Sale Id" = FIELD("Sale ID");
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
            action(Attachments)
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 80079;
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
                        Rec.TestField("Project Code");
                        Rec.TestField("Plot No");
                        Rec.TestField("Customer No");
                        Rec.CalcFields("Similar Plots");

                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Sold;
                            Plots."Held By" := UserId;
                            // Plots."Sold By":=USERID;
                            Plots.Modify;
                        end;
                        Rec.Status := Rec.Status::Posted;
                        Rec.Modify;
                        Message('Plot sold successfully');
                    end;
                end;
            }
            action("Release Plot")
            {
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
                        Plots.SetRange(Plots.Project, Rec."Project Code");
                        Plots.SetRange(Plots."Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Available;
                            Plots."Released By" := UserId;
                            Plots.Modify;
                        end;
                        Rec."Is Active" := Rec."Is Active"::NO;
                        Rec.Modify;
                        Message('Plot has been successfully released.');
                    end;
                end;
            }
            action("Convert Offer to Sale")
            {
                Image = CampaignEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to convert to sale') then begin
                        Rec.TestField("Project Code");
                        Rec.TestField("Plot No");
                        Rec.TestField("Customer No");

                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Sold;
                            Plots."Sold By" := UserId;
                            Plots.Modify;
                        end;
                        Rec."Sale Date" := Today;
                        Rec.Modify;
                        Rec.Rename(Rec."Customer No", Rec."Sale Type"::Sale, Rec."Project Code", Rec."Plot No", Rec.No);
                        Message('Converted successfully');
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
                        Rec.CalcFields("Amount Paid");
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
            action("Print Offer Letter")
            {
                Caption = 'Print Offer Letter';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SaleOffer.Reset;
                    SaleOffer.SetRange("Customer No", Rec."Customer No");
                    SaleOffer.SetRange("Project Code", Rec."Project Code");
                    SaleOffer.SetRange("Plot No", Rec."Plot No");
                    if SaleOffer.FindFirst then
                        REPORT.Run(80038, true, false, SaleOffer);
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
                    //if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
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
            action(Receipt)
            {
                Ellipsis = true;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                /*                 RunObject = Page "Receipts Sales";
                                RunPageLink = "Customer No"=FIELD("Customer No"),
                                              "Project Code"=FIELD("Project Code"),
                                              "Plot No"=FIELD("Plot No"); */
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
                // RunPageLink = "Customer No"=FIELD("Customer No"),
                //               "Project Code"=FIELD("Project Code"),
                //               "Plot No"=FIELD("Plot No");
                RunPageMode = Create;
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
        //CustomApprovals: Codeunit "Custom Approvals Codeunits";
        Customers: Record "Added Customers";
        Sale: Record "Sale/Offer";
}

