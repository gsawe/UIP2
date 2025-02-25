page 51510209 "Leads List"
{
    CardPageID = "Leads Card";
    PageType = List;
    SourceTable = Contact;
    SourceTableView = ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Sales Person"; Rec."Sales Person")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field("Campaign / Page or Group"; Rec."Campaign / Page or Group")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Next Follow Up Date"; Rec."Next Follow Up Date")
                {
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
            }
        }
    }



    var
        Customer: Record Customer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Nos: Code[50];
        UserSetup: Record "User Setup";
        Customer6: Record Customer;
}

