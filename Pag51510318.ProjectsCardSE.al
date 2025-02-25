page 51510318 "Projects Card SE"
{
    PageType = Card;
    SourceTable = Projects;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Commision Type"; Rec."Commision Type")
                {
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
                field("Commision Value"; Rec."Commision Value")
                {
                }
                field(Price; Rec.Price)
                {
                }
                field("Plots Title Prefix"; Rec."Plots Title Prefix")
                {
                }
                field("Plots Title Suffix"; Rec."Plots Title Suffix")
                {
                }
            }
            part(Control12; 51510319)
            {
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
                        if Plots.FindLast then
                            No := Plots."Plot No" else
                            No := 1;
                        suffix := Rec."Plots Title Suffix";
                        repeat
                            Plots.Init;
                            Plots."Plot No" := No;
                            Plots.Size := Rec."Plot Size";
                            Plots."Title No" := Rec."Plots Title Prefix" + Format(suffix);
                            Plots.Price := Rec.Price;
                            Plots.Project := Rec.Name;
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
            action("Plots Sold")
            {
                Caption = 'Plots Sold';
                Gesture = RightSwipe;
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50009;
                RunPageLink = Project = FIELD(Name);
            }
            action("Plots Available")
            {
                Caption = 'Plots Available';
                Gesture = RightSwipe;
                Image = AvailableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Plots Available";
                RunPageLink = Project = FIELD(Name);
            }
            action("Plots Held")
            {
                Caption = 'Plots Held';
                Gesture = RightSwipe;
                Image = Filed;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Plots Held";
                RunPageLink = Project = FIELD(Name);
            }
        }
    }

    var
        Plots: Record Plots;
        No: Integer;
        suffix: Integer;
        PlotsEditable: Boolean;
}

