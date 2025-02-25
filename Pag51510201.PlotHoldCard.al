page 51510201 "Plot Hold Card"
{
    PageType = Card;
    SourceTable = "Plot Hold";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Project Code"; Rec."Project Code")
                {
                }
                field("Plot No"; Rec."Plot No")
                {
                }
                field("Release Date"; Rec."Release Date")
                {
                }
                field(Reason; Rec.Reason)
                {
                }
                field("Phone No to Notify"; Rec."Phone No to Notify")
                {
                }
                field("User Holding"; Rec."User Holding")
                {
                    Editable = false;
                }
                field("Date Held"; Rec."Date Held")
                {
                    Editable = false;
                }
                field(Approver; Rec.Approver)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Hold)
            {
                Image = Segment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to hold the plot') then begin
                        Rec.Status := Rec.Status::Approved;
                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.TestField(Availability, Plots.Availability::Available);
                            Plots.Availability := Plots.Availability::Held;
                            Plots."Held By" := Rec."User Holding";
                            Plots.Modify;
                        end;
                        Rec.Modify;
                    end;
                end;
            }
            action("Release Plot")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to release the plot') then begin
                        Rec.Status := Rec.Status::Released;
                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.TestField(Availability, Plots.Availability::Held);
                            Plots.Availability := Plots.Availability::Available;
                            Plots."Held By" := '';
                            Plots.Modify;
                        end;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        Plots: Record Plots;
}

