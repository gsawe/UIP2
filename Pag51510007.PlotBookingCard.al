page 51510007 "Plot Booking Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Plots Register";
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
                field(Type; Rec.Type)
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
                field("Commission Amount"; Rec."Commission Amount")
                {
                    ApplicationArea = All;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
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

            action("Post Plot Sale")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = Post;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post plots sales?', true, false) = true then begin
                        if Rec.Type = Rec.Type::Original then begin
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
                                Project.Reset();
                                Project.SetRange(Project.Name, Rec.Project);
                                if Project.FindFirst() then begin


                                    PAmount := 0;
                                    PAmount := Rec."Plot Amount" - Rec."Commission Amount";


                                    LineNo := LineNo + 10000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := "Journal Template";
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name" := "Journal Batch";
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Plot Number" := Rec."Plot No";
                                    GenJnlLine."Project Name" := Rec.Project;
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := PlotsR."Record Date";
                                    GenJnlLine."Document No." := PlotsR.No;
                                    GenJnlLine.Description := 'Plot purchase ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                    GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                    GenJnlLine."Account No." := Rec."Client Code";
                                    GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::Plot;
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Amount := Rec."Plot Amount";
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
                                    GenJnlLine.Description := 'Plot purchase price ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                    GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
                                    GenJnlLine."Account No." := Project."Vendor No";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Amount := -PAmount;
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    //Commission
                                    LineNo := LineNo + 10000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := "Journal Template";
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name" := "Journal Batch";
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := PlotsR."Record Date";
                                    GenJnlLine."Document No." := PlotsR.No;
                                    GenJnlLine.Description := 'Commission on ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                    GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                                    GenJnlLine."Account No." := Project."Commission Receivable";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Amount := -Rec."Commission Amount";
                                    // GenJnlLine."Amount (LCY)" := -Rec."Commission Amount";
                                    //GenJnlLine.Validate(GenJnlLine.Amount);
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                    //Discount

                                    LineNo := LineNo + 10000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name" := "Journal Template";
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name" := "Journal Batch";
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Plot Number" := Rec."Plot No";
                                    GenJnlLine."Project Name" := Rec.Project;
                                    GenJnlLine."Line No." := LineNo;
                                    GenJnlLine."Posting Date" := PlotsR."Record Date";
                                    GenJnlLine."Document No." := PlotsR.No;
                                    GenJnlLine.Description := 'Discount On Plot purchase ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                    GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                    GenJnlLine."Account No." := Rec."Client Code";
                                    GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::"Plot Repayment";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Amount := -Rec."Discount Amount";
                                    //GenJnlLine."Amount (LCY)" := Rec."Plot Amount";
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
                                    GenJnlLine.Description := 'Discount On Plot purchase ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                    GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                                    GenJnlLine."Account No." := '41602';
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine.Amount := Rec."Discount Amount";
                                    if GenJnlLine.Amount <> 0 then
                                        GenJnlLine.Insert;

                                end;

                                //  if Rec.Type = Rec.Type then begin

                                //         PlotsR.Reset();
                                //         PlotsR.SetRange(PlotsR.No, Rec.No);
                                //         if PlotsR.FindFirst() then begin
                                //             "Journal Template" := 'GENERAL';
                                //             "Journal Batch" := 'Plots';
                                //             GenJnlLine.Reset();
                                //             GenJnlLine.SetRange("Journal Template Name", "Journal Template");
                                //             GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
                                //             if GenJnlLine.Find('-') then begin
                                //                 GenJnlLine.DeleteAll();
                                //             end;
                                //             Project.Reset();
                                //             Project.SetRange(Project.Name, Rec.Project);
                                //             if Project.FindFirst() then begin

                                //                 LineNo := LineNo + 10000;
                                //                 GenJnlLine.Init;
                                //                 GenJnlLine."Journal Template Name" := "Journal Template";
                                //                 GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                //                 GenJnlLine."Journal Batch Name" := "Journal Batch";
                                //                 GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                //                 GenJnlLine."Plot Number" := Rec."Plot No";
                                //                 GenJnlLine."Project Name" := Rec.Project;
                                //                 GenJnlLine."Line No." := LineNo;
                                //                 GenJnlLine."Posting Date" := PlotsR."Record Date";
                                //                 GenJnlLine."Document No." := PlotsR.No;
                                //                 GenJnlLine.Description := 'Plot purchase ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                //                 GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                //                 GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                                //                 GenJnlLine."Account No." := Rec."Client Code";
                                //                 GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::Plot;
                                //                 GenJnlLine.Validate(GenJnlLine."Account No.");
                                //                 GenJnlLine.Amount := Rec."Plot Amount";
                                //                 if GenJnlLine.Amount <> 0 then
                                //                     GenJnlLine.Insert;


                                //                 LineNo := LineNo + 10000;
                                //                 GenJnlLine.Init;
                                //                 GenJnlLine."Journal Template Name" := "Journal Template";
                                //                 GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                //                 GenJnlLine."Journal Batch Name" := "Journal Batch";
                                //                 GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                //                 GenJnlLine."Line No." := LineNo;
                                //                 GenJnlLine."Posting Date" := PlotsR."Record Date";
                                //                 GenJnlLine."Document No." := PlotsR.No;
                                //                 GenJnlLine.Description := 'Plot purchase price ' + Rec."Project Name" + ' ' + Format(Rec."Plot No");
                                //                 GenJnlLine."External Document No." := format(PlotsR."Plot No");
                                //                 GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                                //                 GenJnlLine."Account No." := Project."Disposal Account";
                                //                 GenJnlLine.Validate(GenJnlLine."Account No.");
                                //                 GenJnlLine.Amount := -Rec."Plot Amount";
                                //                 if GenJnlLine.Amount <> 0 then
                                //                     GenJnlLine.Insert;
                                //             end;
                                //     end;


                                // end;


                                //Post New
                                GenJnlLine.Reset();
                                GenJnlLine.SetRange("Journal Template Name", "Journal Template");
                                GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
                                if GenJnlLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJnlLine);
                                end;

                                Rec.Posted := true;
                                Rec.Modify;

                                Plots.Reset();
                                Plots.SetRange(Plots."Plot No", Rec."Plot No");
                                Plots.SetRange(Plots.Project, Rec.Project);
                                if Plots.FindFirst() then begin
                                    Plots.Availability := Plots.Availability::Held;
                                    Plots.modify;
                                end;
                            end;
                        end;
                    end;
                    CurrPage.Close();
                end;



            }
        }

    }
    var

        PlotsR: Record "Plots Register";
        "Journal Template": Code[80];
        "Journal Batch": Code[80];
        Plots: Record Plots;
        LineNo: Integer;
        GenJnlLine: Record "Gen. Journal Line";
        Project: Record Projects;

        PAmount: Decimal;
}