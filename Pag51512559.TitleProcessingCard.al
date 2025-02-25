page 51512559 "Title Processing Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Title Deeds";

    layout
    {
        area(Content)
        {
            group("Title Processing card")
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;

                }

                field("Plot No"; Rec."Plot No")
                {
                    ApplicationArea = All;

                }

                field("Received Title Document"; Rec."Received Title Document")
                {
                    ApplicationArea = All;

                }

                field("Title Deed No"; Rec."Title Deed No")
                {
                    ApplicationArea = All;

                }
                field("Title Location"; Rec."Title Location")
                {
                    ApplicationArea = All;

                }
                field("Place Of Issue"; Rec."Place Of Issue")
                {
                    ApplicationArea = All;

                }

                field("Issued To"; Rec."Issued To")
                {
                    ApplicationArea = All;

                }
                field("Issued To Name"; Rec."Issued To Name")
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
            action("Issue Title Deed")
            {
                Gesture = RightSwipe;
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    If Confirm('Are you sure you want to issue title deed to this member?', true, false) = true then begin
                        Rec."Title Location" := Rec."Title Location"::"Issued To Parcel Owner";
                        Rec."Issued Date" := Today;
                        Rec."Issued By" := UserId;
                        Rec.Issued := true;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}