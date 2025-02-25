page 51513003 "Release Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Plots Release";

    layout
    {
        area(Content)
        {
            group(Release)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;

                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;

                }

                field("Sale Document"; Rec."Sale Document")
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
            action(PostPlotRelease)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                    PlotsR.Reset();
                    PlotsR.SetRange(PlotsR.No, Rec."Sale Document");
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
                        Project.SetRange(Project.Name, Rec."Project Code");
                        if Project.FindFirst() then begin

                            PlotsR.CalcFields(PlotsR."Outstanding Balance", PlotsR."Total Paid");
                            PAmount := 0;
                            PAmount := PlotsR."Plot Amount";


                            LineNo := LineNo + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := "Journal Template";
                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                            GenJnlLine."Journal Batch Name" := "Journal Batch";
                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                            GenJnlLine."Plot Number" := Rec."Plot Number";
                            GenJnlLine."Project Name" := Rec."Project Code";
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := PlotsR."Record Date";
                            GenJnlLine."Document No." := PlotsR.No;
                            GenJnlLine.Description := 'Plot release ' + Rec."Project Name" + ' ' + Format(Rec."Plot Number");
                            GenJnlLine."External Document No." := format(PlotsR."Plot No");
                            GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                            GenJnlLine."Account No." := Rec."Customer No";
                            GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::Plot;
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Amount := PAmount;
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
                            GenJnlLine.Description := 'Plot release ' + Rec."Project Name" + ' ' + Format(Rec."Plot Number");
                            GenJnlLine."External Document No." := format(PlotsR."Plot No");
                            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                            GenJnlLine."Account No." := Project."Disposal Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Amount := -PAmount;
                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.Insert;

                            //Deposit Refund
                            LineNo := LineNo + 10000;
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name" := "Journal Template";
                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                            GenJnlLine."Journal Batch Name" := "Journal Batch";
                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := PlotsR."Record Date";
                            GenJnlLine."Document No." := PlotsR.No;
                            GenJnlLine.Description := 'Repayment Refund on plot ' + Rec."Project Name" + ' ' + Format(Rec."Plot Number");
                            GenJnlLine."External Document No." := format(PlotsR."Plot No");
                            GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                            GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::"Deposit Contribution";
                            GenJnlLine."Account No." := Rec."Customer No";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Amount := -PlotsR."Total Paid";
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
                            GenJnlLine."Plot Number" := Rec."Plot Number";
                            GenJnlLine."Project Name" := Rec."Project Code";
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := PlotsR."Record Date";
                            GenJnlLine."Document No." := PlotsR.No;
                            GenJnlLine.Description := 'Plots Release Refund ' + Rec."Project Name" + ' ' + Format(Rec."Plot Number");
                            GenJnlLine."External Document No." := format(PlotsR."Plot No");
                            GenJnlLine."Account Type" := GenJnlLine."account type"::Customer;
                            GenJnlLine."Account No." := Rec."Customer No";
                            GenJnlLine."Transaction Type" := GenJnlLine."Transaction Type"::"Plot Repayment";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine.Amount := PlotsR."Total Paid";
                            //GenJnlLine."Amount (LCY)" := Rec."Plot Amount";
                            //GenJnlLine.Validate(GenJnlLine.Amount);
                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.Insert;


                        end;
                        //      PlotsR."Plot Released":=true;
                        //     PlotsR.Modify();


                    end;
                    //Post New
                    /*                                 GenJnlLine.Reset();
                                                    GenJnlLine.SetRange("Journal Template Name", "Journal Template");
                                                    GenJnlLine.SetRange("Journal Batch Name", "Journal Batch");
                                                    if GenJnlLine.Find('-') then begin
                                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJnlLine);
                                                    end;

                                                    Rec.Posted := true;
                                                    Rec.Modify;

                                                    Plots.Reset();
                                                    Plots.SetRange(Plots."Plot No", Rec."Plot Number");
                                                    Plots.SetRange(Plots.Project, Rec."Project Code");
                                                    if Plots.FindFirst() then begin
                                                        Plots.Availability := Plots.Availability::Available;
                                                        Plots.modify;
                                                    end; */
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