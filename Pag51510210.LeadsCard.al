page 51510210 "Leads Card"
{
    PageType = Card;
    SourceTable = Contact;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            group("Source Details")
            {
                field(Source; Rec.Source)
                {
                }
                field("Campaign / Page or Group"; Rec."Campaign / Page or Group")
                {
                }
                field("Next Follow Up Date"; Rec."Next Follow Up Date")
                {
                    Editable = false;
                }
                field("Follow Up Purpose"; Rec."Follow Up Purpose")
                {
                    Editable = false;
                }
                field("Follow Up Details"; Rec."Follow Up Details")
                {
                    Editable = false;
                }
                field("Sales Person"; Rec."Sales Person")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Lead)
            {
                Caption = 'Lead';
                action(" Follow Ups")
                {
                    Caption = ' Follow Ups';
                    Image = PaymentForecast;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Lead Follow Ups";
                    RunPageLink = "Lead No" = FIELD("No.");
                }
                action("Schedule Task")
                {
                    Caption = 'Schedule Task';
                    Image = Payment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Lead Tasks";
                    RunPageLink = "Lead No" = FIELD("No.");
                }
                action("Convert to Customer")
                {
                    Caption = 'Convert to Customer';
                    Image = Splitlines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("Customer No", '');
                        SalesReceivablesSetup.Get();
                        Nos := '';
                        Customer.Init;
                        Nos := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Customer Nos.", Today, true);
                        Customer."No." := Nos;
                        Customer.Name := Rec.Name;
                        Customer."E-Mail" := Rec."E-Mail";
                        Customer."Phone No." := Rec."Phone No.";
                        Customer.Marketer := Rec."Sales Person";
                        Customer.Gender := Rec.Gender;
                        Customer.Insert;


                        Rec."Customer No" := Nos;
                        Rec.Modify;


                        Customer6.Reset;
                        Customer6.SetRange("No.", Nos);
                        if Customer6.FindFirst then
                            PAGE.Run(51510203, Customer6);
                        //MESSAGE('Customer No %1 has been created',Nos);
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
                    RunPageLink = "Doc No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Sales Person" := UserId;
        UserSetup.Get(UserId);
        //Rec."User Sales Manager":=UserSetup."User Sales Manager";
        //"User Branch Manager":=UserSetup."User Branch Manager";
    end;

    var
        UserSetup: Record "User Setup";
        Customer: Record Customer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Nos: Code[50];
        Customer6: Record Customer;
}

