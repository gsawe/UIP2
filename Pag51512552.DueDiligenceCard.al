page 51512552 "Due Diligence Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Due Diligence";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Parcel Owner"; Rec."Parcel Owner")
                {
                    ApplicationArea = All;
                }
                field("Parcel Type"; Rec."Parcel Type")
                {
                    ApplicationArea = All;
                }
                field("Parcel Size In Acres"; Rec."Parcel Size In Acres")
                {
                    ApplicationArea = All;
                }
                field("Number Of Plots"; Rec."Number Of Plots")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Plot"; Rec."Cost Per Plot")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Acre"; Rec."Cost Per Acre")
                {
                    ApplicationArea = All;
                }
                field("Parcel Size In words"; Rec."Parcel Size In words")
                {
                    ApplicationArea = All;
                }
                field("Parcel Location"; Rec."Parcel Location")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Parcel Cost';
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Title No"; Rec."Title No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Due Diligence Status"; Rec."Due Diligence Status")
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
            action("Move to Search")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    If Confirm('Are you sure you want to move this record to search?', true, false) = true then begin
                        Rec."Due Diligence Status" := Rec."Due Diligence Status"::Search;
                        Rec.Modify();
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}