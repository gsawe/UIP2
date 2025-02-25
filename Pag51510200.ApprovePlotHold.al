page 51510200 "Approve Plot Hold"
{
    CardPageID = "Plot Hold Card";
    PageType = List;
    SourceTable = "Plot Hold";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
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
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve') then begin
                        Rec.Status := Rec.Status::Approved;
                        Plots.Reset;
                        Plots.SetRange(Project, Rec."Project Code");
                        Plots.SetRange("Plot No", Rec."Plot No");
                        if Plots.FindFirst then begin
                            Plots.Availability := Plots.Availability::Held;
                            Plots."Held By" := Rec."User Holding";
                            Plots.Modify;
                        end;
                        Rec.Modify;
                        Message('Approved Successfully');
                    end;
                end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                Image = "reject";

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reject') then begin
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify;
                        Message('Rejected Successfully');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange(Approver, UserId);
        Rec.FilterGroup(3);
    end;

    var
        Plots: Record Plots;
}

