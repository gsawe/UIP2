page 51510205 "Plot Sales/Offer Card"
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
                field("Payment Period"; Rec."Payment Period")
                {
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    Editable = false;
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
    }

    actions
    {
        area(processing)
        {
            action(Attachments)
            {
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Documents;
                //  RunPageLink = Rec."Doc No."=FIELD(No);
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
            action("Convert Offer to Sale")
            {
                Image = CampaignEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to convert to sale') then begin
                        Rec."Sale Type" := Rec."Sale Type"::Sale;
                        Rec."Sale Date" := Today;
                        Rec.Modify;
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
                    SaleOffer.Reset;
                    SaleOffer.SetRange("Customer No", Rec."Customer No");
                    SaleOffer.SetRange("Project Code", Rec."Project Code");
                    SaleOffer.SetRange("Plot No", Rec."Plot No");
                    if SaleOffer.FindFirst then
                        REPORT.Run(80037, true, false, SaleOffer);
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
}

