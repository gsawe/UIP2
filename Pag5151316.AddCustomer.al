page 5151316 "Add Customer"
{
    PageType = ListPlus;
    SourceTable = "Added Customers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No"; Rec."Customer No")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Phone No"; Rec."Phone No")
                {
                }
                field(ID; Rec.ID)
                {
                }
                field(Signatory; Rec.Signatory)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup9)
            {
                action("Update Customers")
                {
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to update customers?', true, false) = true then begin

                            JointName := '';
                            JointID := '';
                            JointTel := '';
                            Customers.Reset;
                            Customers.SetRange(Customers."Project Code", Rec."Project Code");
                            Customers.SetRange(Customers."Plot No", Rec."Plot No");
                            Customers.SetRange(Customers.Signatory, true);
                            if Customers.FindFirst then begin
                                repeat
                                    JointName := ' ' + Customers.Name + ' | ' + JointName;
                                    JointID := ' ' + Customers.ID + ' ' + Customers.Name + ' | ' + JointID;
                                    JointTel := Customers."Phone No" + ' ' + JointTel;
                                until Customers.Next = 0;
                            end;
                            //MESSAGE('JointName%1',JointName);


                            SaleOffer.Reset;
                            SaleOffer.SetRange(SaleOffer."Project Code", Rec."Project Code");
                            SaleOffer.SetRange(SaleOffer."Plot No", Rec."Plot No");
                            //SaleOffer.SETRANGE(SaleOffer."Is Active",SaleOffer."Is Active"::YES);
                            if SaleOffer.FindLast then begin
                                // IF Cust.GET(SaleOffer."Customer No") THEN BEGIN
                                // JointName:=JointName;
                                // JointID:=JointID;
                                // JointTel:=JointTel;
                                // END;
                                //MESSAGE('Here%1' ,JointName);
                                SaleOffer."Joint ID" := JointID;
                                SaleOffer."Joint Telephone" := JointTel;
                                SaleOffer."Joint Name" := JointName;
                                SaleOffer."Joint Sale" := true;
                                SaleOffer.Modify
                            end;


                            Customers.Reset;
                            Customers.SetRange(Customers."Plot No", Rec."Plot No");
                            Customers.SetRange(Customers."Project Code", Rec."Project Code");
                            if Customers.FindFirst then begin
                                Signitories.Reset;
                                Signitories.SetRange(Signitories."Plot No", Rec."Plot No");
                                Signitories.SetRange(Signitories."Project Code", Rec."Project Code");
                                if Signitories.FindSet then
                                    Signitories.DeleteAll;
                                repeat
                                    Signitories.Init;
                                    Signitories."Customer No" := Customers."Customer No";
                                    Signitories."Project Code" := Customers."Project Code";
                                    Signitories."Plot No" := Customers."Plot No";
                                    Signitories.ID := Customers.ID;
                                    Signitories.Name := Customers.Name;
                                    Signitories."Phone No" := Customers."Phone No";
                                    Signitories.Insert(true);

                                until Customers.Next = 0;
                            end;
                            Message('Customers have been updated.');
                        end;
                    end;
                }
            }
        }
    }

    var
        Customers: Record "Added Customers";

        SaleOffer: Record "Sale/Offer";
        Cust: Record Customer;
        JointID: Code[200];
        JointName: Text[200];
        JointTel: Code[200];
        Signitories: Record Signitories;
}

