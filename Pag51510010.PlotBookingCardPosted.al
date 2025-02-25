page 51510010 "Plot Booking Card Posted"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Plots Register";
    Editable = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group("Parcel Sale")
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                }
                field("Client No"; Rec."Client Code")
                {

                }
                field("CLient Name"; Rec."Client Name")
                {

                }
                field(Project; Rec.Project)
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

                field("Plot Amount"; Rec."Plot Amount")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
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
            action("Post Plot Sale")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PlotsR.Reset();
                    PlotsR.SetRange(PlotsR.No, Rec.No);
                    if PlotsR.FindFirst() then begin
                        "Journal Template" := 'GENERAL';
                        "Journal Batch" := 'Plots';
                        GenJnlLine.Reset();
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
                        if GenJnlLine.Find('-') then begin
                            GenJnlLine.DeleteAll();
                        end;
                        LineNo := LineNo + 10000;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Plot Number" := Rec."Plot No";
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := PlotsR."Record Date";
                        GenJnlLine."Document No." := PlotsR.No;
                        GenJnlLine.Description := 'Plot booking' + Format(Rec."Plot No");
                        GenJnlLine."External Document No." := format(PlotsR."Plot No");
                        GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                        GenJnlLine."Account No." := Rec."Client Code";
                        GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::Plot;
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine.Amount := Rec."Plot Amount";
                        GenJnlLine."Amount (LCY)" := Rec."Plot Amount";
                        //GenJnlLine.Validate(GenJnlLine.Amount);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;



                        LineNo := LineNo + 10000;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := "Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name" := "Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := PlotsR."Record Date";
                        GenJnlLine."Document No." := PlotsR.No;
                        GenJnlLine.Description := 'Plot booking' + Format(Rec."Plot No");
                        GenJnlLine."External Document No." := format(PlotsR."Plot No");
                        GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account";
                        GenJnlLine."Account No." := 'GIRO';// Rec."Client Code";

                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine.Amount := -Rec."Plot Amount";
                        GenJnlLine."Amount (LCY)" := -Rec."Plot Amount";
                        // GenJnlLine.Validate(GenJnlLine.Amount);
                        if GenJnlLine.Amount <> 0 then
                            GenJnlLine.Insert;





                        //Post New
                        GenJnlLine.Reset();
                        GenJnlLine.SetRange("Journal Template Name", "Journal Template");
                        GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
                        if GenJnlLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJnlLine);
                        end;

                        Rec.Posted := true;
                        Rec.Modify;
                    end;
                end;



            }
        }
    }

    var

        PlotsR: Record "Plots Register";
        "Journal Template": Code[80];
        "Journal Batch": Code[80];

        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
}