page 51512383 "Receipt Allocation-BOSA"
{
    Caption = 'PageName';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Account Type" := Rec."account type"::Customer
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Plot Document Number"; Rec."Plot Document Number")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Project No"; Rec."Project No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Plot Number"; Rec."Plot Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}