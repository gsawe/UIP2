page 51512557 "Due Diligence Search Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Due Diligence";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Regitration)
            {
                Editable = false;
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
                field("Cost Per Acre"; Rec."Parcel Type")
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

            }
            group("Search Findings")
            {
                field("Search Conducted By?"; Rec."Search Conducted By?")
                {
                    ApplicationArea = All;
                }
                field("Search Office"; Rec."Search Office")
                {
                    ApplicationArea = All;
                }
                field("Owner after search"; Rec."Owner after search")
                {
                    ApplicationArea = All;
                }
                field("Parcel Size after search"; Rec."Parcel Size after search")
                {
                    ApplicationArea = All;
                }
                field("Title No after Search"; Rec."Title No after Search")
                {
                    ApplicationArea = All;
                }

                field(Caveat; Rec.Caveat)
                {
                    ApplicationArea = All;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post DueDiligence")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    If Confirm('Are you sure you want to convert this search to project?', true, false) = true then begin
                        Rec.Posted := true;
                        Rec."Due Diligence Status" := Rec."Due Diligence Status"::Project;
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