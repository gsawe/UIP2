page 51510001 "Projects Card"
{
    PageType = Card;
    SourceTable = Projects;
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                }
                field("Project Name"; Rec."Project Name")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Project Size(Acres)"; Rec."Project Size(Acres)")
                {
                    Visible = false;
                }
                field("Commision Type"; Rec."Commision Type")
                {
                    Visible = false;
                }
                field("No of Plots"; Rec."No of Plots")
                {
                }
                field("Plot Size"; Rec."Plot Size")
                {
                }
                field("Title No"; Rec."Title No")
                {
                }
                field("Initial Cost"; Rec."Initial Cost")
                {
                    Editable = false;
                }
                field("Initial Cost Per Plot"; Rec."Initial Cost Per Plot")
                {
                    Editable = false;
                }
                field(Cost; Rec.Cost)
                {
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                }
                field("Commision Value"; Rec."Commision Value")
                {
                    Visible = false;
                }
                field(Price; Rec.Price)
                {
                    Visible = false;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    Visible = true;
                }
                field("Receivables Account"; Rec."Receivables Account")
                {
                    Visible = true;
                }
                field("Commission Receivable"; Rec."Commission Receivable")
                {
                    Visible = true;
                }
                field("Disposal Account"; Rec."Disposal Account")
                {
                    Visible = true;
                }
                field("Plots Title Prefix"; Rec."Plots Title Prefix")
                {
                }
                field("Plots Title Suffix"; Rec."Plots Title Suffix")
                {
                }
            }
            part(Control12; Plots)
            {
                ApplicationArea = all;
                SubPageLink = Project = FIELD(Name);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Subdivide Project")
            {
                Gesture = RightSwipe;
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to subdivide the project') then begin
                        Plots.Reset;
                        Plots.SetRange(Project, Rec.Name);
                        if Plots.FindSet() then begin
                            Plots.DeleteAll();
                        end;
                        No := 1;
                        Plots.Reset;
                        Plots.SetRange(Project, Rec.Name);
                        if Plots.FindFirst() then
                            suffix := Rec."Plots Title Suffix";
                        repeat
                            Plots.Init;
                            Plots."Plot No" := No;
                            Plots.Size := Rec."Plot Size";
                            Plots."Title No" := Rec."Plots Title Prefix" + Format(suffix);
                            Plots.Price := Rec.Cost;
                            Plots.Project := Rec.Name;
                            Plots."Project Name" := Rec."Project Name";
                            Plots.Insert;
                            No := No + 1;
                            suffix := suffix + 1;
                        until No > Rec."No of Plots";
                        Message('Subdivision Completed Successfully');
                    end;
                end;
            }
            action("Update Plots")
            {
                Gesture = RightSwipe;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to modify the plots') then begin
                        suffix := Rec."Plots Title Suffix";
                        Plots.Reset;
                        Plots.SetRange(Project, Rec.Name);
                        if Plots.FindFirst then begin
                            repeat

                                Plots.Size := Rec."Plot Size";
                                Plots."Title No" := Rec."Plots Title Prefix" + Format(suffix);
                                Plots.Price := Rec.Price;
                                Plots.Modify;
                                suffix := suffix + 1;
                            until Plots.Next = 0;
                        end;
                        Message('Completed Successfully');
                    end;
                end;
            }
        }
    }

    var
        Plots: Record Plots;
        No: Integer;
        suffix: Integer;
}

