page 51510317 "Projects SE"
{
    CardPageID = "Projects Card SE";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Projects;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
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
            }
        }
    }

    actions
    {
    }
}

